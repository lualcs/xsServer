--[[
    file:heap.lua
    desc:最大堆
    auth:Caorl Luo
]]

local next = next
local pairs = pairs
local ipairs = ipairs
local insert = table.insert
local remove = table.remove
local ifFunction = require("ifFunction")
local ifNumber = require("ifNumber")
local ifTable = require("ifTable")
local ifString = require("ifString")
local fauto = require("fauto")
local reusable = require("reusable")
local class = require("class")
local table = require("table")
local math = require("math")

---@class heap @最大堆
local heap = class()

---@param   aNode heapNode @节点
---@param   bNdoe heapNode @节点
---@return  number    @大小
local function default_compare(aNode,bNdoe)
    local a = aNode.ticks
    local b = bNdoe.ticks
    if a > b then
        return 1
    elseif a < b then
        return -1
    end
    return 0
end

---构造函数
---@param comp function @比较函数
function heap:ctor(comp)
    ---@type heapNode[]     @列表
    self.list = {nil}--数据
    ---@type function       @比较
    self.comp = comp or default_compare
    ---@type function       @自动
    self.fauto = fauto()
    ---@type reusable       @仓库
    self.store = reusable.new()
end

---添加节点
---@param   ticks     number      @标记
---@param   data      table       @数据
---@return  number                @自动
function heap:append(ticks,data)
    local auto  = self.fauto()
    local store = self.store
    local list  = self.list
    local node  = store:get()
    node.ticks  = ticks
    node.data   = data
    node.auto   = auto
    return self:insert(node)
end

---添加节点
---@param   ticks     number      @标记
---@param   data      table       @数据
---@return  number                @自动
function heap:appendBy(ticks,atuo,data)
    local store = self.store
    local list  = self.list
    local node  = store:get()
    node.ticks  = ticks
    node.data   = data
    node.auto   = atuo
    return self:insert(node)
end

---插入节点
---@param node heapNode  @节点
---@return number   @标示
function heap:insert(node)
    local list = self.list
    insert(list,node)
    self:upward(#list)
    return node.auto
end

---调整节点
---@param node  heapNode @变化
---@param pos   index    @位置
function heap:adjust(node,pos)
    self:upward(pos)
    self:downward(pos)
end

---调整节点
---@param node  heapNode @变化
function heap:adjustByFirst(node)
    self:adjust(node,1)
end

---调整节点
---@param auto  number   @标识
---@param tick  number   @调整
function heap:adjustBy(auto,tick)
    local index,node = self:search(auto)
    if node then
        node.ticks = tick
        self:adjust(node,index)
    end
end

---查找节点
---@param   auto    number      @唯一标识
---@return  index,heapNode      @节点
function heap:search(auto)
    local list = self.list
    for index,node in ipairs(list) do
        if auto == node.auto then
            return index,node
        end
    end
end

---查看节点
---@return heapNode
function heap:reder()
    local list = self.list
    return list[1]
end

---取出节点
---@return heapNode @堆节点
function heap:fetch()
    return self:delete(1)
end

---删除堆节点
---@return heapNode @堆节点
function heap:delete(pos)
    ---检查节点
    local list = self.list
    local node = list[pos]
    if node then
        --取出最后
        local last = remove(list)
        --调整位置
        if list[pos] then
            list[pos] = last
            self:downward(pos)
        end
    end
    local store = self.store
    store:set(node)
    return node
end

---删除堆节点
---@param auto any @标识
---@return heapNode @堆节点
function heap:deleteBy(auto)
    local index,node = self:search(auto)
    self:delete(index)
    return node
end


---上升-上小-左小
function heap:upward(pos)
    ---@type heapNode[]     @所有节点
    local list = self.list
    ---@type heapNode       @上升节点
    local node = list[pos]
    ---@type function       @比较函数
    local comp = self.comp
    ---@type boolean        @非最高层
    while pos > 1 do
        ---@type index      @上层位置
        local uos = pos // 2
        ---@type boolean    @比左边
        if 1 == pos % 2 then
            local los = pos - 1 
            if -1 == comp(node,list[los]) then
                uos = los
            end
        end
        ---@type boolean    @比上层
        if -1 ~= comp(node,list[uos]) then
            break
        end
        list[pos] = list[uos]
        pos = uos
    end
    list[pos] = node
end

---下降-下大-右大
function heap:downward(pos)
    ---@type heapNode[]     @所有节点
    local list = self.list
    ---@type heapNode       @下降节点
    local node = list[pos]
    ---@type function       @比较函数
    local comp = self.comp
    ---@type index          @最后节点
    local last = #list
    ---@type boolea         @节点向下
    while pos < last do
        ---@type index      @右节点
        local ros = pos * 2
        ---@type index      @左节点
        local los = ros - 1
        ---@type boolea     @该跳出
        if los > last then
           break
        end
        ---@type boolean    @比右边
        if ros <= last then
            if 1 == comp(node,list[ros]) then
                los = ros
            end
        end
        ---@type boolean    @比下层
        if 1 ~= comp(node,list[los]) then
            break
        end
        list[pos] = list[los]
        pos = los
    end
    list[pos] = node
end
--清空数据
function heap:clear()
    local list = self.list
    table.clear(list)
end

return heap

---@class heapNode @最大堆节点
---@field   ticks   number  @微秒
---@field   auto    number  @计数
---@field   data    table   @数据