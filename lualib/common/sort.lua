--[[
	desc:排序方法
	有的时候希望对排序会有特殊需求
	比如在排行排序的时候 按照比较函数 返回false 交换原则
]]

--[[函数列表
	sort.bubble(arr,comp,num)--冒泡排序
	sort.select(arr,comp,num)--选择排序
	sort.insert(arr,comp,num)--插入排序
	sort.quick(arr,comp,num)--快速排序
	sort.merge(arr,comp,num)--归并排序
	sort.shuffle(arr)--洗牌乱序
]]

local is_number = require("is_number")
local is_table = require("is_table")
local table = require("extend_table")
local math = require("extend_math")

local sort = {}
--冒泡排序
function sort.bubble(arr,comp,num)  
	local uv_len = #arr
	if not is_number(num) then
		num = uv_len - 1
	elseif num > uv_len then
		num = uv_len - 1--避免不必呀的循环
	end
    for i = 1,num do
        for j = i + 1,uv_len do  
            if not comp(arr[i],arr[j]) then  
                table.exchange(arr,i,j)
            end  
        end  
    end  
end

--选择排序（num = 这个可以选择只排多少个比较适合）
local uv_k
function sort.select(arr,comp,num)  
	local uv_len = #arr
	if not is_number(num) then
		num = uv_len - 1
	elseif num > uv_len then
		num = uv_len - 1--避免不必呀的循环
	end
    for i = 1,num do
		uv_k = i
        for j = i + 1,uv_len do  
            if not comp(arr[uv_k],arr[j]) then  
                uv_k = j
            end  
        end
		if uv_k ~= i then
			table.exchange(arr,i,uv_k)
		end
    end  
end

--插入排序（适合棋牌摸牌插入 默认是对一个有序的数组进行插入）
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

--快排序(快排序不支持 限制数量排序)
local uv_help
function sort.quick(arr,comp,left,right)
	if left < right then
		uv_help = left
		for i = left + 1,right do
			if not comp(arr[i],arr[left]) then
				uv_help = uv_help + 1
				if uv_help ~= i then
					table.exchange(arr,uv_help,i)
				end
			end
		end
		--基准点 = arr[left] 纠正基准值
		if uv_help ~= left then
			table.exchange(arr,uv_help,left)
		end
		sort.quick(arr,comp,left,uv_help - 1)
		sort.quick(arr,comp,uv_help + 1,right)
	end
end

--归并排序
local uv_half
local i1,i2,i3
function sort.merge(arr,comp,left,right,help)
	if left < right then
		uv_half = math.floor((left + right) / 2)
		sort.merge(arr,comp,left,right,uv_half)
		sort.merge(arr,comp,uv_half + 1,right,help)
		
		i1,i2,i3 = left,uv_half + 1,left;
		while i1 <= uv_half and i2 <= right do
			if not comp(arr[i1],arr[i2]) then
				help[i3] = arr[i1]
				i1 = i1 + 1
			else
				help[i3] = arr[i2]
				i2 = i2 + 1
			end
			i3 = i3 + 1
		end
		while (i1 <= uv_half) do
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


--洗牌乱序
function sort.shuffle(list)
	if not is_table(list) then
		return 
	end
	
	local size = #list
	local r_idx
	for i=1,size do
		r_idx = math.random(i,size)
		table.exchange(list,i,r_idx)
	end
end
-- file end
