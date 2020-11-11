--[[
	desc:标准库扩展
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


---@field copy 浅拷贝好像没有意义
---@param t 要拷贝的表
---@return 返回一个新的浅拷贝的表
function table.copy(t)
	local new = table.fortab()
	for k,v in pairs(t) do
		new[k]=v
	end
	return new
end

--深拷贝:这个用很多
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

--过滤拷贝:这个用很多
function table.copy_filter(t,filter)
	local new =  table.fortab()
	for k,v in ipairs(t) do
		if not filter or filter(k,v) then
			table.insert(new,v)
		end
	end
	return new
end

---@field copy_line 不连续数组 拷贝成连续数组
function table.copy_line(t)
	local new =  table.fortab()
	for k,v in pairs(t) do
		table.insert(new,v)
	end
	return new
end



---@field 	exchange 值交换
---@param	t 一个表
---@param	a 交换的键
---@param	b 交换的键
function table.exchange(t,a,b)
	t[a],t[b] = t[b],t[a]
end

---@field	push 	添加t尾部数据v
---@param	maxlen  固定长度
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

---@field 	insert_repeat 尾部重复添加同一个值
---@param	t 一个表
---@param	a 交换的键
---@param	b 交换的键
function table.push_repeat(t,v,_count)
	for i = 1,_count do
		table.insert(t,v)
	end
end

---@field remove_card 移除pos的值
---@return 返回移除的值
function table.remove_pos(t,pos)
	local len = #t
	local val = t[pos]
	t[pos] = t[len]
	t[len] = nil
	return val
end

---@field	移除t star到close数据
---@param	star  开始位置
---@param	close 结束位置
function table.remove_chun(t,star,close)
	
	local len = #t
	--删除数据
	for i = star,close do
		t[i] = nil
	end
	--数据移位
	local num = len - star + 1
	for i = 0,num - 1 do
		t[star + i] = t[star + i]
	end
	--清楚残留数据
	for i = len,len - num,-1 do
		t[i] = nil
	end
end

---@field check_v_count 检查数组值个数
---@param t 			数组
---@param v				查值
---@param c				个数
function table.check_v_count(t,v,c)
	c = c or 1
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

---@field exist 是否存在某个值
---@param t		表数据
---@param v		值数据
function table.exist(t,v)
	for _,_v in pairs(t) do
		if _v == v then
			return true
		end
	end
	return false
end

---@field find_remove 	数组查找移除
---@param tab 			列表
---@param v   			移除的值
---@param c		   		移除个数默认值为1
---@param no		   	不检查
---@return  false		失败数据没有变
---@return  true		成功数据已移除
function table.find_remove(t,v,c,no)
	c = c or 1
	if not no then
		if not table.check_v_count(t,v,c) then
			return false
		end
	end

	local len = #t
	--删除数据
	local i = 1
	while t[i] do
		if c > 0 then
			if t[i] == v then
				table.remove(t,i)
				c = c - 1
			else
				i=i+1
			end
		else
			break
		end
	end
	return true
end

---@field absorb 吸收
function table.absorb(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)+v
	end
end

---@field ventgas 吐出
function table.ventgas(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)-v
	end
end


---@field clear 清空table
function table.clear(t)
	if not is_table(t) then
		return
	end
    for k,v in pairs(t) do
        t[k] = nil
    end
end

---@field clearEmpty 清空非table
function table.clearEmpty(t)
    if not is_table(t) then return end
	for k,v in pairs(t) do
		if not is_table(v) then
			t[k] = nil
		else
			table.clearEmpty(v)
		end
	end
end

---@field empty 判断table是否空表
function table.empty(t)
	if not t then
		return true
	end
	return nil == next(t)
end


--扑克拷贝
function table.copy_card(GetArray,OtherArray,OtherB,OtherE)
	OtherE = math.min(OtherE,#OtherArray)
	for i=OtherB,OtherE do
		GetArray[#GetArray + 1] = OtherArray[i]
	end
end


local _read_only_tm = {
	__newindex = function(t,k,v)
		print('只读表不能新增加值')
	end,
	
	__assign = function(t,k,v)
		print('只读表不能修改此值')
	end
}

--设置一个只读表
function table.read_only(tab)
	setmetatable(tab,_read_only_tm)
	return tab
end

--设置只读配置表递归
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
--设置不可再次覆盖的表
function table.noassign(tab)

    for k,v in pairs(tab) do
        if is_table(v) then
            table.noassign(v)
        end
    end

	setmetatable(tab,_noassign_tm)
	return tab
end

--设置不可覆盖配置表递归
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

--设置默认值0表
function table.default_zero(tab)
    setmetatable(tab,_zero_mt)
end

--设置默认值0表 
function table.default_zero_deep(tab)
    for k,v in pairs(tab) do
		if is_table(v) then
			table.default_zero(v)
		end
	end
	table.default_zero(tab)
end

--统计表元素个数
function table.element_count(tab)
	local nCount = 0
	for k,v in pairs(tab) do
		nCount = nCount + 1
	end
	return nCount
end

--随机一个哈希元素
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

--循环执行一个函数
function table.forFunction(tabs,...)
    for k,v in pairs(tabs) do
        if is_function(v) then
            v(...)
        end
    end
end

---@field sum_has 哈希总和v
function table.sum_has(t)
	local sum = 0
	for _,v in pairs(t) do
		sum = sum + v
	end
	return sum
end

---@field sum_has 哈希总和k
function table.sum_has_k(t)
	local sum = 0
	for k,_ in pairs(t) do
		sum = sum + k
	end
	return sum
end

---@field sum_arr 数组总和v
function table.sum_arr(t)
	local sum = 0
	for _,v in ipairs(t) do
		sum = sum + v
	end
	return sum
end
 
---@field 	arrToHas  转哈希
---@param 	arr 	  数组表
---@return  table	  哈希表
function table.arrToHas(arr)
	local has = table.fortab()
	for k,v in pairs(arr) do
		has[v] = (has[v] or 0) + 1
	end
	return has
end

---@field 	hasToArr 	转数组
---@param 	has 	    统计表
---@return 	table		数组表
function table.hasToArr(has)
	local arr = table.fortab()
	for k,count in pairs(has) do
		table.push_repeat(arr,k,count)
	end
	return arr
end

---@field 	hasToArr 	转数组
---@param 	has 	    统计表
---@return 	table		数组表
function table.hasToArrEx(has)
	local arr = table.fortab()
	for k,count in pairs(has) do
		table.insert(arr,k)
	end
	return arr
end

---@field include 包含
function table.include(a,b)

	--数据对比
	if a == b then
		return true
	end

	--类型检查
	if type(a) ~= type(b) then
		return false
	end

	--不是table
	if not is_table(a) then
		return false
	end

	--不是table
	if not is_table(b) then
		return false
	end

	for ak,av in pairs(a) do
		local bv = b[ak]
		--数据不同
		if av ~= bv then
			if not table.include(av,bv) then
				return false
			end
		end
	end
	return true
end


---@field compare_table 对比表数据是否一样
function table.compare(a,b)
	if not table.include(a,b) then
		return false
	end

	if not table.include(b,a) then
		return false
	end
	return true
end

---@field customMerge 	数组定制合并
function table.customMerge(arr,iKey,aVal,bVal)
	local has = {}
	--填充has
	for _,item in ipairs(arr) do
		local k = item[iKey]
		if not has[k] then
			has[k] = {
				[iKey] = k,
				[aVal] = 0,
				[bVal] = 0,
			}
		end
	end
	--合并数据
	for _,item in ipairs(arr) do
		local k = item[iKey]
		local v = item[aVal]
		has[k][aVal] = has[k][aVal] + v
		local v = item[bVal]
		has[k][bVal] = has[k][bVal] + v
	end
	--格式还原
	local new = {}
	for _,item in pairs(has) do
		table.insert(new,item)
	end

	return new
end

return table

--[[
	系统标准库请不要覆盖
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