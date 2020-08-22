--[[
	desc:数据解析功能
]]

--[[
file: include.lua
desc: 配置新格式1
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
				return math.ceil(i / 8) - 1--至少一个字节（不用存大小信息）
			end
		end
	end
	return 8
end

local function _ksize(v)
	if is_bool(v) then
		return -1--不需要存储大小信息
	elseif 0 == v then
		return -1--不需要存储大小信息
	elseif is_number(v) then
		return numbersize(v)
	elseif is_string(v) then
		return string.len(v) + 1
	end
	return -2--只考虑以上3种键值类型
end
function data.ksize(v)
	if nil == v then
		return 0;
	end
	return _ksize(v) + 2--(一般情况下8bit数据类型8bit存储大小信息)
end

local function _vsize(v)
	if is_bool(v) then
		return -1--不需要存储大小信息
	elseif 0 == v then
		return -1--不需要存储大小信息
	elseif is_number(v) then
		return numbersize(v)
	elseif is_string(v) then
		return string.len(v)
	elseif is_table(v) then
		return 0
	end
	return -2----只考虑以上4种值类型
end
function data.vsize(v)
	if nil == v then
		return 0;
	end
	return _vsize(v) + 2--(一般情况下8bit数据类型8bit存储大小信息)
end

--判断数据大小
function data.datasize(v)
	if not is_table(v) then
		return data.vsize(v)--直接返回数据大小
	end
	local isize = data.vsize(v)--返回第一层次记录的数据大小
	for _k,_v in pairs(v) do
		isize = isize + data.ksize(_k)--计算键大小
		isize = isize + data.vsize(_v)--计算值大小
		if (is_bool(_k) or is_number(_k) or is_string(_k)) and is_table(_v) then
			isize = isize + data.datasize(_v)--递归统计嵌套table大小
		end
	end
	return isize
end

--计算数据大小重载
function vksize(v,k)
	if is_function(CI_vksize) then
		return CI_vksize(v,k)
	end
	return data.vsize(v) + data.ksize(k)
end


