--[[
    file:timer.lua 
    desc:定时器
    auth:Carol Luo
]]

local ipairs = ipairs
local table = table
local skynet = require("skynet")
local class = require("class")
local heap = require("heap")
local reusable = require("reusable")

---cpu时间
---@return number @毫秒
local function clock()
    local ms = os.clock()
    return ms * 1000 // 1
end

---@class timer
local timer = class()
---构造 
function timer:ctor()
    ---@type heap           @最大堆
    self._heap   = heap.new()
    ---@type reusable       @回收库
    self._store  = reusable.new()
    ---@type function       @轮询函数
    self._poling = function(_)
        self:poling()
    end
end

---定时回调
---@param  elapse   MS          @流逝时间
---@param  count    count       @回调次数
---@param  obj      class       @回调对象
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:append(elapse,count,obj,call,...)
    local store = self._store
    ---@type tagTimer @定时数据
    local item = store:get()
    item.elapse = elapse
    item.count  = count
    item.obj    = obj
    item.call   = call
    item.args   = {...}
    local ulti = clock() + elapse
    local head = self._heap
    return head:append(ulti,item)
end

---无限回调
---@param  elapse   MS          @流逝时间
---@param  obj      class       @回调对象
---@param  call     function    @回调函数
---@return timeID @定时ID
function timer:appendEver(elapse,obj,call,...)
    return self:append(elapse,nil,obj,call,...)
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

---清空定时
function timer:clear()
    self._heap:clear()
end

---定时轮询
function timer:poling()
    
    skynet.timeout(10,self._poling)
    ---@type heap       @最大堆
    local heap = self._heap
    ---@type heapNode   @第一个
    local rede = heap:reder()

    if not rede then
        --没有数据
        return
    end

    ---@type MS         @时间
    local alter = clock()
    local ticks = rede.ticks
    if ticks > alter then
        --未到时间
        return 
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
     heap:adjust(item.elapse,1)

    if 0 == item.count then
        ---移除事件
        heap:fetch()
        ---回收数据
        local store = self._store
        store:set(item)
    end

    ---每次只调用一个定时
    local args = item.args
    local obj = item.obj
    item.call(obj,table.unpack(args))
end

return timer

---@class tagTimer              @定时数据
---@field elapse    MS          @间隔时间
---@field count     count       @回调次数
---@field obj       class       @回调对象
---@field call      function    @回调函数
---@field args      any[]      @回调参数