--[[
    file:heap.lua
    desc:����
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

---@class heap @����
local heap = class()

---@param   aNode heapNode @�ڵ�
---@param   bNdoe heapNode @�ڵ�
---@return  number    @��С
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

---���캯��
---@param comp function @�ȽϺ���
function heap:ctor(comp)
    ---@type heapNode[]     @�б�
    self.list = {nil}--����
    ---@type function       @�Ƚ�
    self.comp = comp or default_compare
    ---@type function       @�Զ�
    self.fauto = fauto()
    ---@type reusable       @�ֿ�
    self.store = reusable.new()
end

---��ӽڵ�
---@param   ticks     number      @���
---@param   data      table       @����
---@return  number                @�Զ�
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

---��ӽڵ�
---@param   ticks     number      @���
---@param   data      table       @����
---@return  number                @�Զ�
function heap:appendBy(ticks,atuo,data)
    local store = self.store
    local list  = self.list
    local node  = store:get()
    node.ticks  = ticks
    node.data   = data
    node.auto   = atuo
    return self:insert(node)
end

---����ڵ�
---@param node heapNode  @�ڵ�
---@return number   @��ʾ
function heap:insert(node)
    local list = self.list
    insert(list,node)
    self:upward(#list)
    return node.auto
end

---�����ڵ�
---@param node  heapNode @�仯
---@param pos   index    @λ��
function heap:adjust(node,pos)
    self:upward(pos)
    self:downward(pos)
end

---�����ڵ�
---@param node  heapNode @�仯
function heap:adjustByFirst(node)
    self:adjust(node,1)
end

---�����ڵ�
---@param auto  number   @��ʶ
---@param tick  number   @����
function heap:adjustBy(auto,tick)
    local index,node = self:search(auto)
    if node then
        node.ticks = tick
        self:adjust(node,index)
    end
end

---���ҽڵ�
---@param   auto    number      @Ψһ��ʶ
---@return  index,heapNode      @�ڵ�
function heap:search(auto)
    local list = self.list
    for index,node in ipairs(list) do
        if auto == node.auto then
            return index,node
        end
    end
end

---�鿴�ڵ�
---@return heapNode
function heap:reder()
    local list = self.list
    return list[1]
end

---ȡ���ڵ�
---@return heapNode @�ѽڵ�
function heap:fetch()
    return self:delete(1)
end

---ɾ���ѽڵ�
---@return heapNode @�ѽڵ�
function heap:delete(pos)
    ---���ڵ�
    local list = self.list
    local node = list[pos]
    if node then
        --ȡ�����
        local last = remove(list)
        --����λ��
        if list[pos] then
            list[pos] = last
            self:downward(pos)
        end
    end
    local store = self.store
    store:set(node)
    return node
end

---ɾ���ѽڵ�
---@param auto any @��ʶ
---@return heapNode @�ѽڵ�
function heap:deleteBy(auto)
    local index,node = self:search(auto)
    self:delete(index)
    return node
end


---����-��С-��С
function heap:upward(pos)
    ---@type heapNode[]     @���нڵ�
    local list = self.list
    ---@type heapNode       @�����ڵ�
    local node = list[pos]
    ---@type function       @�ȽϺ���
    local comp = self.comp
    ---@type boolean        @����߲�
    while pos > 1 do
        ---@type index      @�ϲ�λ��
        local uos = pos // 2
        ---@type boolean    @�����
        if 1 == pos % 2 then
            local los = pos - 1 
            if -1 == comp(node,list[los]) then
                uos = los
            end
        end
        ---@type boolean    @���ϲ�
        if -1 ~= comp(node,list[uos]) then
            break
        end
        list[pos] = list[uos]
        pos = uos
    end
    list[pos] = node
end

---�½�-�´�-�Ҵ�
function heap:downward(pos)
    ---@type heapNode[]     @���нڵ�
    local list = self.list
    ---@type heapNode       @�½��ڵ�
    local node = list[pos]
    ---@type function       @�ȽϺ���
    local comp = self.comp
    ---@type index          @���ڵ�
    local last = #list
    ---@type boolea         @�ڵ�����
    while pos < last do
        ---@type index      @�ҽڵ�
        local ros = pos * 2
        ---@type index      @��ڵ�
        local los = ros - 1
        ---@type boolea     @������
        if los > last then
           break
        end
        ---@type boolean    @���ұ�
        if ros <= last then
            if 1 == comp(node,list[ros]) then
                los = ros
            end
        end
        ---@type boolean    @���²�
        if 1 ~= comp(node,list[los]) then
            break
        end
        list[pos] = list[los]
        pos = los
    end
    list[pos] = node
end
--�������
function heap:clear()
    local list = self.list
    table.clear(list)
end

return heap

---@class heapNode @���ѽڵ�
---@field   ticks   number  @΢��
---@field   auto    number  @����
---@field   data    table   @����