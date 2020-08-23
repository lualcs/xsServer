--[[
    file:heap.lua
    desc:�����ݽṹ -> ���ȶ��У����ѣ�
]]

local is_function = require("is_function")
local is_number = require("is_number")
local is_table = require("is_table")
local is_string = require("is_string")
local class = require("class")
local table = require("table")
local math = require("math")

local heap = class('heap')

function heap:ctor(comp_fun)
    if not is_function(comp_fun) then
        print("head:ctor error not compare function(a{ticks},b{ticks})")
        return
    end
    self.size = 0--��С
    self.list = table.fortab()--����
    self.comp = comp_fun
    self.gid = 0--�������ݲ���
end

--����ڵ�
function heap:insert(ticks,node)
    self.size = self.size + 1
    self.gid = self.gid + 1
    self.list[self.size] = {ticks=ticks,data = node,gid = self.gid}--����Ƚ�����Ч�� �Ժ��Ż�
    self:siftUp(self.size)
    return self.gid
end
--���ҽڵ�
function heap:find(gid)
    list = self.list
    for _pos,_date in pairs(list) do
        if is_number(_pos) and is_table(_date) then
            if gid == _date.gid then
                return _pos
            end
        end
    end
end

--����������
function heap:adjust(event)
    if not is_table(event) then return end


    self.size = self.size + 1
    self.list[self.size] = event
    self:siftUp(self.size)
    return event.gid
end
--ȡ���ѽڵ�
function heap:extractMin()
    local list = self.list
    local val = list[1]
    if not val then return end
    self.size = self.size - 1
    self:siftDown(1)
    return val
end
--�鿴�ѽڵ�
function heap:peek()
    return self.list[1]
end
--ɾ���ѽڵ�
function heap:delete(pos)
    local list = self.list
    local del_val = list[pos]
    if not del_val then return end

    local last_val = list[self.size]
    list[self.size] = nil

     --ֻ��һ���¼�
    if 1 < self.size then
        list[pos] = last_val
        self:siftDown(pos)
    end
    self.size = self.size - 1
    return del_val
end


--һ���Ǹ�������
function heap:siftUp(pos)
    local list = self.list
    local child = list[pos]
    local super_pos
    while pos > 1 do
        super_pos = math.floor(pos / 2)
        if 1 ~= self.comp(list[super_pos],child) then
            break
        end
        list[pos] = list[super_pos]
        pos = super_pos
    end
    list[pos] = child
end

function heap:siftDown(pos)
    local list = self.list
    local pos_val = list[pos]
    local l_child,r_child
    local size = self.size
    local bottom_first_child = math.floor(size / 2)--�ײ��һ���ڵ�
    while pos < bottom_first_child do
        l_child = math.floor(pos * 2)
        r_child = l_child + 1
        if r_child < size and 1 == self.comp(list[l_child],list[r_child]) then
            l_child = l_child + 1
        end
        if 1 ~= self.comp(pos_val,list[l_child]) then
            break;
        end
        list[pos] = list[l_child]
        pos = l_child
    end
    list[pos] = pos_val
end

--�������
function heap:clear()
    self.size = 0
    table.clearEx(self.list)
end