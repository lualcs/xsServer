--[[
	desc:��׼����չ
]]

local table = table
local select = select
local math = math
local pairs,ipairs = pairs,ipairs
local setmetatable = setmetatable
local print = print
local next = next

local is_table = require("is_table")
local is_string = require("is_string")
local is_function = require("is_function")


---@field copy ǳ��������û������
---@param t Ҫ�����ı�
---@return ����һ���µ�ǳ�����ı�
function table.copy(t)
	local new = table.fortab()
	for k,v in pairs(t) do
		new[k]=v
	end
	return new
end

--���:����úܶ�
function table.copy_deep(t,out)
	local new = out or table.fortab()
	for k,v in pairs(t) do
		if is_table(v) then
			new[k]=table.copy_deep(v)
		else
			new[k]=v
		end
	end
	return new
end

---@field 	exchange ֵ����
---@param	t һ����
---@param	a �����ļ�
---@param	b �����ļ�
function table.exchange(t,a,b)
	local old = t[a]
	t[a] = t[b]
	t[b] = old
end

---@field	push 	���tβ������v
---@param	maxlen  �̶�����
function table.push(t, v, maxlen)
	local len = #t
	if maxlen then
		if  len > maxlen then
			local pos = maxlen-len
			table.remove_chun(t,1,pos)
		end
	end
	table.insert(t,v)
end

---@field 	insert_repeat β���ظ����ͬһ��ֵ
---@param	t һ����
---@param	a �����ļ�
---@param	b �����ļ�
function table.push_repeat(t,v,_count)
	for i = 1,_count do
		table.insert(t,v)
	end
end

---@field remove_card �Ƴ�pos��ֵ
---@return �����Ƴ���ֵ
function table.remove_pos(t,pos)
	local len = #t
	local val = t[pos]
	t[pos] = t[len]
	t[len] = nil
	return val
end

---@field	�Ƴ�t star��close����
---@param	star  ��ʼλ��
---@param	close ����λ��
function table.remove_chun(t,star,close)
	
	local len = #t
	--ɾ������
	for i = star,close do
		t[i] = nil
	end
	--������λ
	local num = len - star + 1
	for i = 0,num - 1 do
		t[star + i] = t[star + i]
	end
	--�����������
	for i = len,len - num,-1 do
		t[i] = nil
	end
end

---@field check_v_count �������ֵ����
---@param t 			����
---@param v				��ֵ
---@param c				����
function table.check_v_count(t,v,c)
	for _,_v in ipairs(t) do
		if _v == v then
			c = c - 1
		end
		if c <= 0 then
			return true
		end
	end
	return false
end

---@field find_remove 	�����Ƴ�
---@param tab 			�б�
---@param v   			�Ƴ���ֵ
---@param c		   		�Ƴ�����Ĭ��ֵΪ1
---@return  			ʧ������û�б�
---@return  			�ɹ��������Ƴ�
function table.find_remove(t,v,c)

	c = c or 1
	if table.check_v_count(t,v,c) then
		return false
	end

	local len = #t

	--ɾ������
	local del = c
	for _k,_v in ipairs(t) do
		if del > 0 then
			if _v == v then
				t[_k] = nil
				del = del - 1
			end
		else
			break
		end
	end

	--����nil
	local remove = c
	for i1=1,len do
		if nil == t[i1] then
			for i2=i1+1,len do
				if nil ~= t[i2] then
					t[i1] = t[i2]
					t[i2] = nil
					remove = remove - 1
					if remove <= 0 then
						return true
					end
					break
				end
			end
		end
	end
	
	return true
end

---@field absorb ����
function table.absorb(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)+v
	end
end

---@field ventgas �³�
function table.ventgas(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)-v
	end
end


---@field clear ���table
function table.clear(t)
    for k,v in pairs(t) do
        t[k] = nil
    end
end

---@field clearEmpty ��շ�table
local function clearEmpty(t)
    if not is_table(t) then return end
	for k,v in pairs(t) do
		if not is_table(v) then
			t[k] = nil
		else
			clearEmpty(v)
		end
	end
end

table.clearEmpty = clearEmpty

local uv_fortab = {} --���ձ�
local uv_waitls = {} --������
local uv_waitrecycle = false

---@field fortab ����һ���ձ�
function table.fortab()
    --ȥ������
	local idx = #uv_fortab
	local tab = uv_fortab[idx] or {}
	uv_fortab[idx] = nil
	
	for k,v in pairs(tab) do
		tab[k] = nil
	end
	
	if uv_waitrecycle then
		uv_waitls[tab] = true
	end
	return tab
end

---@field recycle ǳ���� �����������ֻ���ڷ�table.fortab����Ľ��л���
function table.recycle(t)
    local count = #uv_fortab
    if count >= 10000 then
        print('warning table.recycle:',count)
    end
	uv_fortab[count + 1] = t
	uv_waitls[t] = nil

end

---@field recycle ����� �����������ֻ���ڷ�table.fortab����Ľ��л���
function table.recycle_deep(t)
	for k,v in pairs(t) do
		if is_table(v) then
			table.recycle_deep(v)
		end
	end
	table.recycle(t)
end

---@field wait_fortab  ��ʼ��ǻ���
function table.wait_fortab()
	uv_waitrecycle = true
end

---@field wait_recycle �������б��
function table.wait_recycle()
	for _t,_ in pairs(uv_waitls) do
		table.recycle(_t)
	end
	uv_waitrecycle = false
end



---@field empty �ж�table�Ƿ�ձ�
function table.empty(t)
	return nil == next(t)
end


--�˿˿���
function table.copy_card(GetArray,OtherArray,OtherB,OtherE)
	OtherE = math.min(OtherE,#OtherArray)
	for i=OtherB,OtherE do
		GetArray[#GetArray + 1] = OtherArray[i]
	end
end


local _read_only_tm = {
	__newindex = function(t,k,v)
		print('__newindex:Read - only table read - write failed')
	end,
	
	__assign = function(t,k,v)
		print('__assign:The reassignment failed')
	end
}

--����һ��ֻ����
function table.read_only(tab)
	setmetatable(tab,_read_only_tm)
	return tab
end

--����ֻ�����ñ�ݹ�
function table.read_only_deep(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.read_only(v)
		end
	end
	table.read_only(tab)
end

local _noassign_tm = {
	__assign = function(t,k,v)
		print('__assign:The reassignment failed')
	end
}
--���ò����ٴθ��ǵı�
function table.noassign(tab)

    for k,v in pairs(tab) do
        if is_table(v) then
            table.noassign(v)
        end
    end

	setmetatable(tab,_noassign_tm)
	return tab
end

--���ò��ɸ������ñ�ݹ�
function table.noassign_deep(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.noassign(v)
		end
	end
	table.noassign(tab)
end


local _zero_mt = {
	__index = function(t,k)
		return 0
	end
}

--����Ĭ��ֵ0��
function table.default_zero(tab)
    setmetatable(tab,_zero_mt)
end

--����Ĭ��ֵ0�� 
function table.default_zero_deep(tab)
    for k,v in pairs(tab) do
		if is_table(v) then
			table.default_zero(v)
		end
	end
	table.default_zero(tab)
end


function table.empty(tab)
	return nil == next(tab)
end

--ͳ�Ʊ�Ԫ�ظ���
function table.element_count(tab)
	local nCount = 0
	for k,v in pairs(tab) do
		nCount = nCount + 1
	end
	return nCount
end

--���һ����ϣԪ��
function table.random_hash(tab)
	if table.empty(tab) then return end

	local nRand = math.random(1,table.element_count(tab))
	for k,v in pairs(tab) do
		nRand = nRand - 1
		if nRand <= 0 then
			return k,v
		end
	end
end

--ѭ��ִ��һ������
function table.forFunction(tabs,...)
    for k,v in pairs(tabs) do
        if is_function(v) then
            v(...)
        end
    end
end

--ͳ�Ʊ��
function table.sum_has(t)
	local sum = 0
	for _,v in pairs(t) do
		sum = sum + v
	end
	return sum
end

--ͳ�Ʊ��
function table.sum_has_k(t)
	local sum = 0
	for k,_ in pairs(t) do
		sum = sum + k
	end
	return sum
end

--ͳ�������
function table.sum_arr(t)
	local sum = 0
	for _,v in ipairs(t) do
		sum = sum + v
	end
	return sum
end

--table����
function table.has_count(t)
	local has = table.fortab()
	for k,v in pairs(t) do
		has[v] = (has[v] or 0) + 1
	end
	return has
end

return table

--[[
	ϵͳ��׼���벻Ҫ����
	{
        insert = function: 0x560b976e4790,	
        sort = function: 0x560b976e4e80,
        pack = function: 0x560b976e4280,
        concat = function: 0x560b976e48a0,
        move = function: 0x560b976e44b0,
        remove = function: 0x560b976e4680,
        unpack = function: 0x560b976e4180,
}
]]