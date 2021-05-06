--[[
    file:timer.lua 
    desc:定时器
    auth:Carol Luo
]]

local ipairs = ipairs
local table = table
local os = require("extend_os")
local skynet = require("skynet")
local class = require("class")
local heap = require("heap")
local reusable = require("reusable")

---@class timer
local timer = class()
---构造 
function timer:ctor()
    ---@type heap                   @最大堆
    self._heap   = heap.new()
    ---@type table<string,timeID>   @定时器
    self._list   = {}
    ---@type reusable               @回收库
    self._store  = reusable.new()
    ---@type function               @轮询函数
    self._poling = function(_)
        self:poling()
    end
end

---重置
function timer:dataReboot()
    ---@type integer                @暂停时间
    self._pauset = nil
    ---@type heap                   @清空数据
    self._heap:clear()
    ---@type table<string,timeID>   @定时器
    self._list   = {}
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
    item.args   = {...}
    local ulti = os.getmillisecond() + elapse
    local head = self._heap
    return head:append(ulti,item)
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
    local list = self._list
    local iden = list[name]
    local indx,node = self._heap:search(iden)
    if node then
        self._heap:delete(indx)
    end
    list[name] = self:append(elapse,count,call,...)
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
---@param timeID    timeID      @定时器ID
function timer:remove(timeID)
    local heap  = self._heap
    local list  = heap.list
    local store = self._store
    for index,node in ipairs(list) do
        if node.auto == timeID then
            --每次只能删除一个
            heap:delete(index)
            store:set(node.data)
            break
        end
    end
end

---剩余时间
---@param timeID timeID
function timer:remaining(timeID)
    local now = self._pauset or os.getmillisecond()
    for _,item in ipairs(self._heap.list) do
        if item.auto == timeID then
            return now - item.ticks
        end
    end
    return 0
end

---剩余时间
---@param name name @定时名字
function timer:remainingBy(name)
    local list = self._list
    local iden = list[name]
   return self:remaining(iden)
end

---暂停定时
function timer:pause()
    if not self._pauset then
        self._pauset = os.getmillisecond()
    end
end

---暂停取消
function timer:uPause()
    local pause = self._pauset
    if pause then
        self._pauset = nil
        local now = os.getmillisecond()
        local dif = now - pause
        for _,item in ipairs(self._heap.list) do
            item.ticks = item.ticks + dif
        end
        --启动轮询
        self:poling()
    end
end


---定时轮询
function timer:poling()
    if self._pauset then
        return
    end
    skynet.timeout(10,self._poling)
    --循环执行
    while self:execute() do end
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
    local alter = os.getmillisecond()
    local ticks = rede.ticks
    if ticks > alter then
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

     ---下次触发
     rede.ticks = ticks + item.elapse
     ---调整位置
     heap:adjust(rede,1)

    if 0 == item.count then
        ---移除事件
        heap:fetch()
        ---回收数据
        local store = self._store
        store:set(item)
    end

    ---每次只调用一个定时
    local args = item.args
    item.call(table.unpack(args))
    return true
end

return timer

---@class tagTimer              @定时数据
---@field elapse    MS          @间隔时间
---@field count     count       @回调次数
---@field call      function    @回调函数
---@field args      any[]       @回调参数