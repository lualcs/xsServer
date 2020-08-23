--[[
	desc:��׼����չ
]]

local table = table
local select = select
local math = math
local is_nil,is_number,is_string,is_table = is_nil,is_number,is_string,is_table
local pairs,ipairs = pairs,ipairs
local setmetatable = setmetatable
--table �е�ֵ����
function table.exchange(tab,idx1,idx2)
	local temp = tab[idx1]
	tab[idx1] = tab[idx2]
	tab[idx2] = temp
end

--���������װ
function table.concatEx(...)
	
	local _concat_tab = table.fortab()
	local uv_arg
	for i = 1,select('#',...) do
		uv_arg = select(i,...)
		--�������nilҲҪ���ϳ��ַ���
		if nil == uv_arg then
			uv_arg = tostring(uv_arg) .. ' '
		elseif is_table(uv_arg) then
			uv_arg = toinfo(uv_arg)
		elseif not is_string(uv_arg) then
			uv_arg = tostring(uv_arg)
		end
		_concat_tab[#_concat_tab + 1] = uv_arg
	end
	local str = table.concat(_concat_tab)
	table.clr(_concat_tab)
	return str
end

--desc:	��dataѹ��t��β��
function table.push(t, data, maxNum)
	if maxNum == nil or #t < maxNum then
		t[#t+ 1] = data
	else
		for i = 1, #t - 1 do
			t[i] = t[i + 1]
		end
		t[maxNum] = data
	end
	return t
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

--��ȿ���
function table.copy(tab)
	if not is_table(tab) then
		return -1
	end
	local new_tab = table.fortab()
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
    if not is_table(t) then return end
    for k,v in pairs(t) do
        t[k] = nil
    end
end
--�������(��ɾ��tab)
function table.clearEx(t)
    if not is_table(t) then return end
	for k,v in pairs(t) do
		if not is_table(v) then
			t[k] = nil
		else
			table.clearEx(v)
		end
	end
	return t
end
local uv_fortab = {}
--������ղ��һ���
function table.clr(t)
	if not is_table(t) then return end
    for k,v in pairs(t) do
		if is_table(v) then
			table.clr(v)
			uv_fortab[#uv_fortab + 1] = v
		end
		t[k] = nil
	end
end
--ֱ�ӻ���
function table.recycle(t)
	if not is_table(t) then
        return 
    end

    local count = #uv_fortab
    if count >= 1000 then
        errorEx('table.recycle:'..count)
        look(t)
    end

	table.clr(t)
    
	uv_fortab[count + 1] = t

end

--ֱ�ӻ���
function table.recycles(...)
	for k,v in pairs(...) do
		table.recycle(v)
	end
end

--�ӻ����������һ���ձ�
function table.fortab()
    --ȥ������
	local idx = #uv_fortab
	local tab = uv_fortab[idx]
    uv_fortab[idx] = nil
	
	--���û����table �򴴽�һ��
	return tab or {}
end
--�жϿձ�
function table.empty(t)
	if is_table(t) then
		for k,v in pairs(t) do
			return false
		end
	else
		return false
	end
	return true
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
		errorEx('__newindex:Read - only table read - write failed')
	end,
	
	__assign = function(t,k,v)
		errorEx('__assign:The reassignment failed')
	end
}

--����һ��ֻ����
function table.read_only(tab)
	setmetatable(tab,_read_only_tm)
	return tab
end

local _noassign_tm = {
	__assign = function(t,k,v)
		errorEx('__assign:The reassignment failed')
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
function table.zeroRead(tab)
    setmetatable(tab,_zero_mt)
end

--����ֻ�����ñ�ݹ�
function table.read_onlyS(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.read_onlyS(v)
		end
	end
	table.read_only(tab)
end

--���ò��ɸ������ñ�ݹ�
function table.noassignS(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.noassignS(v)
		end
	end
	table.noassign(tab)
end



function table.empty(tab)
	for k,v in pairs(tab) do
		return false
	end
	return true
end

function table.element_count(tab)
	local nCount = 0
	for k,v in pairs(tab) do
		nCount = (nCount or 0) + 1
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

return table