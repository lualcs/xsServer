--[[
	desc:���ݽ�������
]]

--[[
file: include.lua
desc: �����¸�ʽ1
author:	lcs
update:2018-7-15
]]--


local is_bool,is_number,is_string,is_table = is_bool,is_number,is_string,is_table
local is_datak,is_datav = is_datak,is_datav
local type,tostring = type,tostring
local getmetatable = getmetatable
local setmetatable = setmetatable
local table = table
local math = math

data = {}

local function numbersize(v)
	if is_int(v) then
		if v < 0 then
			v = -v
		end
		for i = 1,64 do
			if v < (2^i) - 1 then
				return math.ceil(i / 8) - 1--����һ���ֽڣ����ô��С��Ϣ��
			end
		end
	end
	return 8
end

local function _ksize(v)
	if is_bool(v) then
		return -1--����Ҫ�洢��С��Ϣ
	elseif 0 == v then
		return -1--����Ҫ�洢��С��Ϣ
	elseif is_number(v) then
		return numbersize(v)
	elseif is_string(v) then
		return string.len(v) + 1
	end
	return -2--ֻ��������3�ּ�ֵ����
end
function data.ksize(v)
	if nil == v then
		return 0;
	end
	return _ksize(v) + 2--(һ�������8bit��������8bit�洢��С��Ϣ)
end

local function _vsize(v)
	if is_bool(v) then
		return -1--����Ҫ�洢��С��Ϣ
	elseif 0 == v then
		return -1--����Ҫ�洢��С��Ϣ
	elseif is_number(v) then
		return numbersize(v)
	elseif is_string(v) then
		return string.len(v)
	elseif is_table(v) then
		return 0
	end
	return -2----ֻ��������4��ֵ����
end
function data.vsize(v)
	if nil == v then
		return 0;
	end
	return _vsize(v) + 2--(һ�������8bit��������8bit�洢��С��Ϣ)
end

--�ж����ݴ�С
function data.datasize(v)
	if not is_table(v) then
		return data.vsize(v)--ֱ�ӷ������ݴ�С
	end
	local isize = data.vsize(v)--���ص�һ��μ�¼�����ݴ�С
	for _k,_v in pairs(v) do
		isize = isize + data.ksize(_k)--�������С
		isize = isize + data.vsize(_v)--����ֵ��С
		if (is_bool(_k) or is_number(_k) or is_string(_k)) and is_table(_v) then
			isize = isize + data.datasize(_v)--�ݹ�ͳ��Ƕ��table��С
		end
	end
	return isize
end

--�������ݴ�С����
function vksize(v,k)
	if is_function(CI_vksize) then
		return CI_vksize(v,k)
	end
	return data.vsize(v) + data.ksize(k)
end


