--[[
	desc:排序方法
	有的时候希望对排序会有特殊需求
	比如在排行排序的时候 按照比较函数 返回false 交换原则
]]

local is_number = require("is_number")
local is_table = require("is_table")
local table = require("extend_table")
local math = require("extend_math")

local sort = {nil}

---冒泡排序
---@param arr any[] @数组
---@param comp function  @比较函数
---@param num number  @结束位置
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

---选择排序
---@param arr any[] @数组
---@param comp function  @比较函数
---@param num number  @结束位置
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

---插入排序
---@param arr any[] @数组
---@param comp function  @比较函数
---@param val any  @插入值
function sort.insert_sort(arr,comp,val)  
	local len = #arr
    for i = 1,len do
       if not comp(arr[i],val) then  
		   table.insert(arr,i,val)
		   return
       end  
	end
	
	--到这里直接添加到末尾
	table.insert(arr,val)
end

---快速排序
---@param arr any[] @数组
---@param comp function @比较函数
---@param left number @开始位置
---@param right number @结束位置
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

---归并排序
---@param arr any[] @数组
---@param comp function @比较方法
---@param left number @开始位置
---@param right number @结束位置
---@param help any[] @外部传入数据保存
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

---洗牌乱序
---@param list any[] @数组
function sort.shuffle(list)
	local len = #list
	for i=1,len do
		local pos = math.random(i,len)
		list[i],list[pos] = list[pos],list[i]
	end
	return list
end

---反序排序
---@param list any[] @数组
function sort.reverse(list)
	local leng = #list
	local half = leng // 2
	for i=1,half do
		table.exchange(list,i,leng-i+1)
	end
	return list
end

return sort