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

local tostring = require("tostring")
local is_table = require("is_table")
local is_string = require("is_string")
local is_function = require("is_function")

--table �е�ֵ����
function table.exchange(tab,idx1,idx2)
	local temp = tab[idx1]
	tab[idx1] = tab[idx2]
	tab[idx2] = temp
end

function table.insertEx(t,v,_count)
	for i = 1,_count do
		table.insert(t,v)
	end
end

--desc:	��vѹ��t��β��
function table.push(t, v, maxNum)
	if maxNum == nil or #t < maxNum then
		t[#t+ 1] = v
	else
		for i = 1, #t - 1 do
			t[i] = t[i + 1]
		end
		t[maxNum] = v
	end
	return t
end

--�ϲ� at[k] += bt[k] Ȼ�� bt[k] = 0
function table.mergeNumber(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)+v
		bt[k] = 0
	end
end

--�Ƴ������޸�
function table.removeEx(tab,b_idx,e_idx)
	if not is_table(tab) then return end
	
	local len = #tab
	--ɾ������
	for i = b_idx,e_idx do
		tab[i] = nil
	end
	--������λ
	local num = len - e_idx + 1
	for i = 0,num - 1 do
		tab[b_idx + i] = tab[e_idx + i]
	end
	--�����������
	for i = len,len - num,-1 do
		tab[i] = nil
	end
end

--�����Ƴ�
function table.find_remove(tab,v)
	for _inx,_v in ipairs(tab) do
		if v == _v then
			table.remove(tab,_inx)
			return
		end
	end
end

--��ȿ���
function table.copy(tab,new)
	if not is_table(tab) then
		return -1
	end
	local new_tab = new or table.fortab()
	for _k,_v in pairs(tab) do

        if not is_table(_v) then
			    new_tab[_k] = _v
		else
			new_tab[_k] = table.copy(tab)
		end
	end
	return new_tab
end

--��ȿ��� v:������ֵ nil �������� c ��������
function table.copy_arr(tab,v,c)
	if not is_table(tab) then
		return -1
	end
	local new_tab = table.fortab()
	for _k,_v in ipairs(tab) do

        if v == _v and c > 0 then
            c = c - 1
        else
            if not is_table(_v) then
			    new_tab[#new_tab+1] = _v
		    else
			    new_tab[#new_tab+1] = table.copy_arr(_v)
		    end
        end
	end
	return new_tab
end

--����ݹ鿽�� ���´���ظ���ֵ
--GetValue ����ֵ�÷���
function table.copy_sole(tab,GetValue)
	local new_tab = table.fortab()
	local chk_map = table.fortab()
	local swithVal
	for _k,_v in pairs(tab) do
		swithVal = GetValue(_v)
		if not chk_map[swithVal] then
			new_tab[#new_tab + 1] = _v
			chk_map[swithVal] = true
		end
	end
	table.recycle(chk_map)
	return new_tab
end

--������ݰ�װ
function table.clear(t)
	--ֱ�ӽ����������
	if not is_table(t) then
		return
	end
    for k,v in pairs(t) do
        t[k] = nil
    end
end
--�������(��ɾ��tab)
local function clearEmpty(t)
    if not is_table(t) then return end
	for k,v in pairs(t) do
		if not is_table(v) then
			t[k] = nil
		else
			clearEmpty(v)
		end
	end
	return t
end

table.clearEmpty = clearEmpty

local uv_fortab = {} --���ձ�
local uv_waitls = {} --������
local uv_waitrecycle = false

--ֱ�ӻ���
local function recycle(t)
	if not is_table(t) then
        return 
	end
	
	for k,v in pairs(t) do
		t[k] = nil
	end

    local count = #uv_fortab
    if count >= 1000 then
        print('warning table.recycle:',count)
    end
	uv_fortab[count + 1] = t
	uv_waitls[t] = nil

end

table.recycle = recycle

--ֱ�ӻ���
function table.recycles(...)
	for k,v in pairs(...) do
		recycle(v)
	end
end

--�ȴ����գ�֮�������������table into uv_waitls
function table.wait_fortab()
	uv_waitrecycle = true
end

--�ȴ����գ�֮�����������ʱ��
function table.wait_recycle()
	for _t,_ in pairs(uv_waitls) do
		recycle(_t)
	end
	uv_waitrecycle = false
end

--�ӻ����������һ���ձ� bRecycle:true ��ʾ������
function table.fortab()
    --ȥ������
	local idx = #uv_fortab
	local tab = uv_fortab[idx] or {}
    uv_fortab[tab] = nil
	
	if uv_waitrecycle then
		uv_waitls[tab] = true
	end
	return tab
end


--�жϿձ�
function table.empty(t)
	return nil == next(t)
end

--��ȡͨ�÷���
function table.get(tab,...)
	if not is_table(tab) then
        return
    end

    local tem = tab
    local key
    for i=1,select('#',...) do
        key = select(i,...)
        if not is_table(tem) then
            return
        end
        tem = tem[key]
    end

    return tem
end

--ͨ����������
function table.set(tab,val,...)
	if not is_table(tab) then
        return
    end

    local tem = tab
    local count = select('#',...)

    for i=1,count - 1 do
        tem = tem[select(i,...)]
    end
    tem[select(count,...)] = val
end

--ͨ����������
function table.default(t,k)
	if not is_table(t[k]) then
		t[k] = table.fortab()
	end
	return t[k]
end

--����
function table.remove_card(array,pos)
	table.exchange(array,pos,#array)
	local oval = array[#array]
	array[#array] = nil
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


local _zero_mt = {
	__index = function(t,k)
		return 0
	end
}

--����Ĭ��ֵ0��
function table.default_zero(tab)
    setmetatable(tab,_zero_mt)
end

--����ֻ�����ñ�ݹ�
function table.only_read(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.only_read(v)
		end
	end
	table.only_read(tab)
end

--���ò��ɸ������ñ�ݹ�
function table.noassigns(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.noassigns(v)
		end
	end
	table.noassign(tab)
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