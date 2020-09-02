--[[
	desc:排序方法
	有的时候希望对排序会有特殊需求
	比如在排行排序的时候 按照比较函数 返回false 交换原则
]]

local is_number = require("is_number")
local is_table = require("is_table")
local table = require("extend_table")
local math = require("extend_math")

local sort = {}
---@field bubble 冒泡排序
function sort.bubble(arr,comp,num)  
	local len = #arr
	if not is_number(num) then
		num = len - 1
	elseif num > len then
		num = len - 1--避免不必呀的循环
	end
    for i = 1,num do
        for j = i + 1,len do  
            if not comp(arr[i],arr[j]) then  
                table.exchange(arr,i,j)
            end  
        end  
    end  
end

---@field bubble 选择排序
function sort.select(arr,comp,num)  
	local len = #arr
	if not is_number(num) then
		num = len - 1
	elseif num > len then
		num = len - 1--避免不必呀的循环
	end

	local sk
    for i = 1,num do
		sk = i
        for j = i + 1,len do  
            if not comp(arr[sk],arr[j]) then  
                sk = j
            end  
        end
		if sk ~= i then
			table.exchange(arr,i,sk)
		end
    end  
end

---@field insert_sort 查入排序
function sort.insert_sort(arr,comp,num,val)  
	local len = #arr
	local is_insert = false

	local is_limit = true
	if not is_number(num) then
		num = len - 1
		is_limit = false
	elseif num > len then
		num = len - 1--避免不必的循环
	end
    for i = 1,num do
       if not comp(arr[i],val) then  
		   table.insert(arr,i,val)
		   is_insert = true
		   break
       end  
	end
	
	--一个 空数组 或者 插入末尾位置
	if not is_insert then
		arr[len+1] = val
	end

	if is_limit then
		arr[num + 1] = nil--避免有多余必须要的数据
	end
end

---@field insert_sort 快速排序
function sort.quick(arr,comp,left,right)
	if left < right then
		local help = left
		for i = left + 1,right do
			if not comp(arr[i],arr[left]) then
				help = help + 1
				if help ~= i then
					table.exchange(arr,help,i)
				end
			end
		end
		--基准点 = arr[left] 纠正基准值
		if help ~= left then
			table.exchange(arr,help,left)
		end
		sort.quick(arr,comp,left,help - 1)
		sort.quick(arr,comp,help + 1,right)
	end
end

---@field insert_sort 归并排序
function sort.merge(arr,comp,left,right,help)
	if left < right then
		local half = math.floor((left + right) / 2)
		sort.merge(arr,comp,left,right,half)
		sort.merge(arr,comp,half + 1,right,help)
		
		local i1,i2,i3 = left,half + 1,left;
		while i1 <= half and i2 <= right do
			if not comp(arr[i1],arr[i2]) then
				help[i3] = arr[i1]
				i1 = i1 + 1
			else
				help[i3] = arr[i2]
				i2 = i2 + 1
			end
			i3 = i3 + 1
		end
		while (i1 <= half) do
			help[i3] = arr[i1]
			i3,i1 = i3 + 1,i1 + 1
		end
		while (i2 <= right)	do
			help[i3] = arr[i2]
			i3,i2 = i3 + 1,i2 + 1
		end
		for i = left,right do
			arr[i] = help[i]
		end
	end
end

---@field shuffle 洗牌乱序
function sort.shuffle(list)
	local len = #list
	for i=1,len do
		local pos = math.random(i,len)
		list[i],list[pos] = list[pos],list[i]
	end
end


return sort