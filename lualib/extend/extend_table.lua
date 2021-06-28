--[[
	desc:标准库扩展
]]

local table = table
local select = select
local math = math
local type = type
local ipairs = ipairs
local pairs = pairs
local setmetatable = setmetatable
local print = print
local next = next
local ifTable = require("ifTable")
local ifString = require("ifString")
local ifFunction = require("ifFunction")

---浅拷贝
---@param t table @要拷贝的表
---@param out table @外带表
---@return table @新表
function table.copy(t,out)
	if out then
		table.clear(out) 
	end
	local new = out or {nil}
	for k,v in pairs(t) do
		new[k]=v
	end
	return new
end

---深拷贝
---@param t 要拷贝的表
---@param out table @外带表
---@return table 新表
function table.copy_deep(t,out)
	if out then
		table.clear(out) 
	end
	local new = out or {nil}
	for k,v in pairs(t) do
		if ifTable(v) then
			new[k]=table.copy_deep(v)
		else
			new[k]=v
		end
	end
	return new
end

---过滤拷贝
---@param t any[] @要拷贝的表
---@param out table @外带表
---@param filter function|nil @过滤函数
function table.copy_filter(t,filter,out)
	if out then
		table.clear(out) 
	end
	local new =  out or {nil}
	for k,v in ipairs(t) do
		if not filter or filter(k,v) then
			table.insert(new,v)
		end
	end
	return new
end

---处理成连续表
---@param t table @表
---@return any[]
function table.copy_line(t)
	local new =  {nil}
	for k,v in pairs(t) do
		table.insert(new,v)
	end
	return new
end



---值交换
---@param	t any @一个表
---@param	a any @交换的键
---@param	b any @交换的键
function table.exchange(t,a,b)
	t[a],t[b] = t[b],t[a]
end

---添加t尾部数据v
---@param	t any[]  @数组
---@param	v any	@数值
---@param	maxlen number @最大位置
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

---尾部重复添加同一个值
---@param t 		any[] @一个表
---@param v 		any   @添加值
---@param _count 	count @添加几次
function table.push_repeat(t,v,_count)
	for i = 1,_count do
		table.insert(t,v)
	end
end

---移除pos的值
---@param t 		table @一个表
---@param pos 		any   @一个键
---@return any
function table.remove_pos(t,pos)
	local len = #t
	local val = t[pos]
	t[pos] = t[len]
	t[len] = nil
	return val
end

---移除star到close数据
---@param	star  index @开始位置
---@param	close index @结束位置
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

---检查数组值个数
---@param t any[]	@数组
---@param v any		@查值
---@param c count	@个数
---@return boolean
function table.existCount(t,v,c)
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

---是否存在某个值
---@param t  table<any,any> @表数据
---@param v  any 			@值数据
---@return boolean
function table.exist(t,v)
	for _k,_v in pairs(t) do
		if _v == v then
			return _k
		end
	end
	return false
end

---是否存在某个值
---@param t   	any		 @表数据
---@param list  any[]	 @值数据
---@return boolean
function table.existVals(t,list)
	for _,v in ipairs(list) do
		if not table.exist(t,v) then
			return false
		end
	end
	return true
end


---删除
---@param t table @表数据
---@param k any	  @任意数据
---@return V
function table.delete(t,k)
	local v = t[k]
	t[k] = nil
	return v
end

---数组查找移除
---@param t any[] 		@数组
---@param v any	  		@移除的值
---@param c count 		@移除个数默认值为1
---@param no boolean 	@不检查
---@return  boolean
function table.find_remove(t,v,c,no)
	c = c or 1
	if not no then
		if not table.existCount(t,v,c) then
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

---删除列表
---@param t any[] @数组
---@param ... any[] @变长参数
function table.remove_args(t,...)
	for i=1,select("#",...) do
		local v = select(i,...)
		if not table.find_remove(t,v) then
			return false
		end
	end
	return true
end

---删除列表
---@param t any[] @数组
---@param ... any[] @变长参数
function table.remove_list(t,lis)
	for _,v in ipairs(lis) do
		if not table.find_remove(t,v) then
			return false
		end
	end
	return true
end

---添加列表
---@param t any[] @数组
---@param ... any[] @变长参数
function table.push_args(t,...)
	for i=1,select("#",...) do
		local v = select(i,...)
		table.insert(t,v)
	end
	return true
end

---添加列表
---@param t any[] @数组
---@param ... any[] @变长参数
function table.push_list(t,lis)
	for _,v in ipairs(lis) do
		table.insert(t,v)
	end
end

---添加列表
---@param t any[] @数组
---@param ... any[] @变长参数
function table.push_maps(t,lis)
	for _,v in pairs(lis) do
		table.insert(t,v)
	end
end

---吸收另一个表的值 at[k] = at[k] + bt[k]
---@param at table<any,count> @表1
---@param bt table<any,count> @表2
function table.absorb(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)+v
	end
end

---吐出另一个表的值 at[k] = at[k] - bt[k]
---@param at table<any,count> @表1
---@param bt table<any,count> @表2
function table.ventgas(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)-v
	end
end


---清空table {a={1}} to {nil}
---@param t table @表
---@return table|nil
function table.clear(t)
	if not ifTable(t) then
		return
	end

    for k,v in pairs(t) do
        t[k] = nil
	end
	return t
end

---清空数据 {a={1}} to {a={nil}}
---@param t table @表
function table.clearEmpty(t)
    if not ifTable(t) then return end
	for k,v in pairs(t) do
		if not ifTable(v) then
			t[k] = nil
		else
			table.clearEmpty(v)
		end
	end
	return t
end

---是否空表 {nil} or nil
---@return boolean
function table.empty(t)
	if not t then
		return true
	end
	return nil == next(t)
end

local _read_only_tm = {
	__newindex = function(t,k,v)
		print(t,k,v)
	end,
	
	__assign = function(t,k,v)
		print(t,k,v)
	end
}

---设置一个只读表
---@param tab table @表
function table.read_only(tab)
	setmetatable(tab,_read_only_tm)
	return tab
end

---设置只读配置表递归
---@param tab table @表
function table.read_only_deep(tab)
	for k,v in pairs(tab) do
		if ifTable(v) then
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
---设置不可再次覆盖的表
---@param tab table @表
function table.noassign(tab)

    for k,v in pairs(tab) do
        if ifTable(v) then
            table.noassign(v)
        end
    end

	setmetatable(tab,_noassign_tm)
	return tab
end

---设置不可覆盖配置表递归
---@param tab table @表
function table.noassign_deep(tab)
	for k,v in pairs(tab) do
		if ifTable(v) then
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

---设置默认值0表
---@param tab table @表
function table.default_zero(tab)
    setmetatable(tab,_zero_mt)
end

---设置默认值0表
---@param tab table @表
function table.default_zero_deep(tab)
    for k,v in pairs(tab) do
		if ifTable(v) then
			table.default_zero(v)
		end
	end
	table.default_zero(tab)
end

---统计表元素个数
---@param tab table @表
---@return count
function table.element_count(tab)
	local nCount = 0
	for k,v in pairs(tab) do
		nCount = nCount + 1
	end
	return nCount
end

---数组元素个数
---@param t any[] @数组a
---@return count 
function table.arrElementtCount(t)
	return #t
end

---哈希元素个数
---@param t any[] @数组a
---@return count 
function table.hasElementtCount(t)
	local count = 0
	for _,_ in pairs(t) do
		count = count + 1
	end
	return count
end

---随机一个哈希元素
---@param tab table @表
---@return any,any @key,val
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

---循环执行一个函数
function table.forFunction(tabs,...)
    for k,v in pairs(tabs) do
        if ifFunction(v) then
            v(...)
        end
    end
end

---哈希总和v
---@param t table @表
---@return number @sum(v)
function table.sum_has(t)
	local sum = 0
	for _,v in pairs(t) do
		sum = sum + v
	end
	return sum
end

---哈希总和k
---@param t table @表
---@return number @sum(k)
function table.sum_has_k(t)
	local sum = 0
	for k,_ in pairs(t) do
		sum = sum + k
	end
	return sum
end

---数组总和v
---@param t table @表
---@return number @sum(v)
function table.sum_arr(t)
	local sum = 0
	for _,v in ipairs(t) do
		sum = sum + v
	end
	return sum
end

---转哈希
---@param 	arr 	any[]				@数组表
---@param 	out 	any[]				@外传表
---@return  table<any,count> 			@哈希表
function table.arrToHas(arr,out)
	if out then
		table.clear(out) 
	end
	local has = out or {nil}
	for k,v in pairs(arr) do
		has[v] = (has[v] or 0) + 1
	end
	return has
end

---转数组有重复
---@param 	has table<any,count>	@统计表
---@param 	out 	any[]			@外传表
---@return 	any[] @数组表 有重复
function table.hasToArr(has,out)
	if out then
		table.clear(out) 
	end
	local arr = out or {nil}
	for k,count in pairs(has) do
		table.push_repeat(arr,k,count)
	end
	return arr
end

---转数组无重复
---@param 	has table<any,count>	@统计表
---@param 	out 	any[]			@外传表
---@return 	any[] @数组表 无重复
function table.hasToArrEx(has,out)
	if out then
		table.clear(out) 
	end
	local arr = out or {nil}
	for k,count in pairs(has) do
		table.insert(arr,k)
	end
	return arr
end

---包含 a{c={1}} b{c={1,2,3}} to true
---@param a any @值1
---@param b any @值2
---@return boolean
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
	if not ifTable(a) then
		return false
	end

	--不是table
	if not ifTable(b) then
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


---深比较
function table.compare_deep(a,b)
	--正向比较
	if not table.include(a,b) then
		return false
	end

	--反向比较
	if not table.include(b,a) then
		return false
	end
	return true
end


---数组反
---@param t any[] @数组
---@param count count @倒数第几
---@return any
function table.last(t,count)
	return t[#t+1-(count or 1)]
end

---gc获取空表
---@param gcs any[] @数组
function table.gcforget(gcs)
	local len = #gcs
	local tab = gcs[len] or {nil}
	gcs[len] = nil
	table.clear(tab)
	return tab
end

---gc回收空表
---@param gcs any[]
---@param t any
function table.gcforset(gcs,t)
	gcs[#gcs] = t
end

---gc回收空表
---@param gcs any[]
---@param t any
function table.gcforsets(gcs,ts)
	for _,t in pairs(ts) do
		gcs[#gcs] = t
	end
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