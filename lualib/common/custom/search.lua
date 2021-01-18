--[[
	查找算法
]]

local is_number = require("is_number")
local is_string = require("is_string")
local is_table = require("is_table")
local math = math
local pairs = pairs

local search = {}

---折半查找函数
---@param arr any[] @数组
---@param comp function @比较函数
---@param val any @查找值
---@return INDEX
function search.binart(arr,comp,val)

	local start = 1
	local close = #arr

	while start < close do
		local half = math.floor((start + close) / 2)
		if 1 == comp(arr[half],val) then
			start = half + 1
		elseif -1 == comp(arr[half],val) then
			start = half - 1
		else
			return half
		end
	end
end

---@field traverse 遍历查找
---@param arr 数组
---@param val 查找值
function search.traverse(arry,val,key)
	for _k,_v in pairs(arry) do
		if _v == val then
			return _k
		end
	end
end

return search