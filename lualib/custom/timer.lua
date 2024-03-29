--[[
    file:timer.lua 
    desc:定时器
    auth:Carol Luo
]]

local select = select
local ipairs = ipairs
local table = table
local heap = require("heap")
local class = require("class")
local os = require("extend_os")
local skynet = require("skynet")
local reusable = require("reusable")
local debug = require("extend_debug")

---@class timer
local timer = class()
local this = timer
---构造 
function timer:ctor(interval)
    ---@type number                 @轮询间隔
    self._interval = interval
    ---@type heap                   @最大堆
    self._heap   = heap.new()
    ---@type table<string,timeID>   @定时器
    self._names   = {nil}
    ---@type table<timeID,string>   @定时器
    self._idens   = {nil}
    ---@type reusable               @回收库
    self._store  = reusable.new()
    ---@type function               @轮询函数
    self._poling = function(_)
        self:poling()
    end
    ---启动定时器
    skynet.timeout(0,self._poling)
end

---重置数据
function timer:dataReboot()
    self:dataClear()
end

---清除数据
function timer:dataClear()
    ---@type integer                @暂停时间
    self._pauset = nil
    ---@type heap                   @清空数据
    self._heap:clear()
    ---@type table<string,timeID>   @定时器
    table.clear(self._names)
    ---@type table<timeID,string>   @定时器
    table.clear(self._idens)
end

---获取时间
function timer:time()
    return os.getmillisecond()
end

---定时回调
---@param  elapse   MS          @流逝时间
---@param  count    count       @回调次数
---@param  obj      class       @回调对象
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:append(elapse,count,call,...)
    local store = self._store
    ---@type tagTimer @定时数据
    local item = store:get()
    item.elapse = elapse
    item.count  = count
    item.call   = call
    item.args   = select("#",...) > 0 and {...} or nil
    local ulti = self:time() + elapse
    local head = self._heap
    return head:append(ulti,item)
end

---单次回调
---@param  elapse   MS          @流逝时间
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:appendCall(elapse,call,...)
    return self:append(elapse,1,call,...)
end

---无限回调
---@param  elapse   MS          @流逝时间
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:appendEver(elapse,call,...)
    return self:append(elapse,nil,call,...)
end

---定时回调
---@param  name     name        @定时名字
---@param  elapse   MS          @流逝时间
---@param  count    count       @回调次数
---@param  obj      class       @回调对象
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:appendBy(name,elapse,count,call,...)
    local idens = self._idens
    local names = self._names
    local iden = names[name]
    local indx,node = self._heap:search(iden)
    if node then
        self._heap:delete(indx)
        idens[iden] = nil
    end
    iden = self:append(elapse,count,call,...)
    names[name] = iden
    idens[iden] = name
end

---无限回调
---@param  name     name        @定时名字
---@param  elapse   MS          @流逝时间
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:appendEverBy(name,elapse,call,...)
    return self:appendBy(name,elapse,nil,call,...)
end


---删除定时
---@param iden    timeID      @定时器ID
function timer:remove(iden)
    local heap  = self._heap
    local list  = heap._list
    local store = self._store
    local idens = self._idens
    local names = self._names
    for index,node in ipairs(list) do
        if node.auto == iden then
            --删除数据
            heap:delete(index)
            store:set(node.data)
            --删除数据
            local name = idens[iden]
            if name then
                names[name] = nil
                idens[iden] = nil
            end
            break
        end
    end
end

---剩余时间
---@param iden timeID
function timer:remaining(iden)
    local now = self._pauset or self:time()
    for _,item in ipairs(self._heap._list) do
        if item.auto == iden then
            return item.ticks - now
        end
    end
    return 0
end

---剩余时间
---@param name name @定时名字
function timer:remainingBy(name)
    local names = self._names
    local iden = names[name]
   return self:remaining(iden)
end

---暂停定时
function timer:pause()
    if not self._pauset then
        self._pauset = self:time()
    end
end

---暂停取消
function timer:uPause()
    local pause = self._pauset
    if pause then
        self._pauset = nil
        local now = self:time()
        local dif = now - pause
        for _,item in ipairs(self._heap._list) do
            item.ticks = item.ticks + dif
        end
        --启动轮询
        self:poling()
    end
end


---定时轮询
function timer:poling()

    ---暂停
    if self._pauset then
        return
    end
    ---定时
    self:timeout()

    --循环执行
    while self:execute() do
    end
end

---轮询器
function timer:timeout()
    skynet.timeout(self._interval or 10,self._poling)
end

---设置间隔
---@param interval number @间隔 
function timer:interval(interval)
    self._interval = self._interval
end

---检测器
---@param inow number @当前时间
---@param iend number @结束时间
function timer:ifExpire(inow,iend)
    if inow < iend then
        return false
    end
    return true
end

---执行
---@return boolean
function timer:execute()
    ---@type heap       @最大堆
    local heap = self._heap
    ---@type heapNode   @第一个
    local rede = heap:reder()
    if not rede then
        return false
    end
    ---@type MS         @时间
    local inow = self:time()
    local iend = rede.ticks

    ---到期检查
    if not self:ifExpire(inow,iend) then
        return false
    end

    ---@type tagTimer   @定时器
    local item = rede.data
    ---@type count      @多少次
    local count = item.count
    if count then
        ---扣除次数
        item.count = count - 1
    end

    if 0 == item.count then
        ---移除事件
        heap:fetch()
        ---回收数据
        local store = self._store
        store:set(item)

        --删除数据
        local names = self._names
        local idens = self._idens
        local iden = rede.auto
        local name = idens[iden]
        if name then
            names[name] = nil
            idens[iden] = nil
        end

    else
        ---下次触发
        rede.ticks = iend + item.elapse
        ---调整位置
        heap:adjustByFirst(rede)
    end

    ---每次只调用一个定时
    local args = item.args
    item.call(args and table.unpack(args) or nil)
    return true
end

return timer

---@class tagTimer              @定时数据
---@field elapse    MS          @间隔时间
---@field count     count       @回调次数
---@field call      function    @回调函数
---@field args      any[]       @回调参数