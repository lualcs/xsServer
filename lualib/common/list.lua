--[[
	desc:˫������
	���
	node = {
		data = ����,
		pre  = ָ����һ�����,
		next = ָ����һ�����,
	}
	����
	list = {
		b_node = ָ��ͷ���,
		e_node = ָ��β�ڵ�
		size = ������,
	}
	
	--�¼�ֵ������Ϊnil
	--���Ǹ�ֵ����Ϊnil
	--��ֵ�����ж����û�н��
]]
local tostring = tostring
local is_number,is_string,is_table,is_function = is_number,is_string,is_table,is_function

local function is_data(v)
	return is_table(v) or is_number(v) or is_string(v)
end
--�����㲿��
local node_keys = {data=is_data,pre=is_table,next=is_table}
local function is_node_kv(k,v)
	return node_keys[k] and node_keys[k](v)
end
local met_node = {
	__newindex = function(t,k,v)
		if not is_node_kv(k,v) then
			return errorEx('�����㲻�����������ֵ ',tostring(k),tostring(v))
		end
		rawset(t,k,v)
	end,
}
node = class('node',met_node)

function node:ctor(data)
    self.data = data
end

function node:insert(nwe_node)
    --��������β������
    if not self.next then return end

	nwe_node.pre = self
    nwe_node.next = self.next

    self.next = nwe_node
    return nwe_node
end

function node:remove()
     --�����Ƴ�β��
    if not self.next then return end

	self.pre.next = self.next
	self.pre.pre = self.pre

    self.next = nil
    self.pre = nil
    return true
end

function node:get_next()
    return self.next
end
function node:get_pre()
    return self.pre
end

--������
local list_keys = {
	--�ֶμ�ֵ
	head = is_table,size=is_number,
	--������ֵ
	begin=is_function,_end=is_function,
	fron_push=is_function,back_push=is_function,
	fron_pop=is_function,back_pop=is_function,
	insert=is_function,
}
local function is_list_kv(k,v)
	return list_keys[k] and list_keys[k](v)
end
local met_list = {__newindex = function(t,k,v)
		if not is_list_kv(k,v) then
			return errorEx('��������ӷǷ���ֵ ',tostring(k),tostring(v))
		end
		rawset(t,k,v)
	end,
}

list = class('list')

function list:ctor()
	--��ʼ��������
	self.size = 0
end

function list:begin()
	return self.b_node
end

function list:_end()
	return self.e_node
end

--����û��ͷ�������
function list:first_node(node)
	local b_node = self.b_node
    --û��ͷ�ڵ�
    if not b_node then
        self.b_node = node
        self.e_node = node
        return true
    end
end

function list:fron_push(node)

	if self:first_node(node) then
		return 
	end
	
	local b_node = self.b_node
	--�޸��½ڵ��ָ��
	node.pre = nil
	node.next = b_node
	--�޸�ͷ�ڵ��ָ��
	b_node.pre = node

	--�½ڵ���ͷ���
	self.b_node = node
end

function list:back_push(node)
	
	if self:first_node(node) then
		return 
	end
	
	local e_node = self.e_node
	--�޸��½ڵ��ָ��
	node.pre = e_node
	node.next = nil
	--�޸�β�ڵ��ָ��
	e_node.next = node

	--�½ڵ���β���
	self.e_node = node
	
end

function list:insert(node)
end

function list:fron_pop()
	local b_node = self.b_node
	if not b_node then return end
	self.b_node = b_node.next
	--��ͷ
	if self.b_node then
		self.b_node.pre = nil
	end
end


function list:back_pop()
	local e_node = self.e_node
	if not e_node then return end
	self.e_node = e_node.pre
	--��β
	if self.e_node then
		self.e_node.next = nil
	end
end




