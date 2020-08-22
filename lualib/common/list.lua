--[[
	desc:双向链表
	结点
	node = {
		data = 数据,
		pre  = 指向上一个结点,
		next = 指向下一个结点,
	}
	链表
	list = {
		b_node = 指向头结点,
		e_node = 指向尾节点
		size = 链表长度,
	}
	
	--新加值不可以为nil
	--但是赋值可以为nil
	--赋值类型判断这个没有解决
]]
local tostring = tostring
local is_number,is_string,is_table,is_function = is_number,is_string,is_table,is_function

local function is_data(v)
	return is_table(v) or is_number(v) or is_string(v)
end
--链表结点部分
local node_keys = {data=is_data,pre=is_table,next=is_table}
local function is_node_kv(k,v)
	return node_keys[k] and node_keys[k](v)
end
local met_node = {
	__newindex = function(t,k,v)
		if not is_node_kv(k,v) then
			return errorEx('链表结点不可添加其他键值 ',tostring(k),tostring(v))
		end
		rawset(t,k,v)
	end,
}
node = class('node',met_node)

function node:ctor(data)
    self.data = data
end

function node:insert(nwe_node)
    --不允许在尾部插入
    if not self.next then return end

	nwe_node.pre = self
    nwe_node.next = self.next

    self.next = nwe_node
    return nwe_node
end

function node:remove()
     --不许移除尾部
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

--链表部分
local list_keys = {
	--字段键值
	head = is_table,size=is_number,
	--函数键值
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
			return errorEx('链表不可添加非法键值 ',tostring(k),tostring(v))
		end
		rawset(t,k,v)
	end,
}

list = class('list')

function list:ctor()
	--初始化链表长度
	self.size = 0
end

function list:begin()
	return self.b_node
end

function list:_end()
	return self.e_node
end

--处理没有头结点的情况
function list:first_node(node)
	local b_node = self.b_node
    --没有头节点
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
	--修改新节点的指向
	node.pre = nil
	node.next = b_node
	--修改头节点的指向
	b_node.pre = node

	--新节点变成头结点
	self.b_node = node
end

function list:back_push(node)
	
	if self:first_node(node) then
		return 
	end
	
	local e_node = self.e_node
	--修改新节点的指向
	node.pre = e_node
	node.next = nil
	--修改尾节点的指向
	e_node.next = node

	--新节点变成尾结点
	self.e_node = node
	
end

function list:insert(node)
end

function list:fron_pop()
	local b_node = self.b_node
	if not b_node then return end
	self.b_node = b_node.next
	--断头
	if self.b_node then
		self.b_node.pre = nil
	end
end


function list:back_pop()
	local e_node = self.e_node
	if not e_node then return end
	self.e_node = e_node.pre
	--断尾
	if self.e_node then
		self.e_node.next = nil
	end
end




