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

local tostring = require("tostring")
local is_table = require("is_table")
local is_string = require("is_string")
local is_function = require("is_function")

--table 中的值交换
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

--desc:	将v压入t的尾部
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

--合并 at[k] += bt[k] 然后 bt[k] = 0
function table.mergeNumber(at,bt)
	for k,v in pairs(bt) do
		at[k] = (at[k] or 0)+v
		bt[k] = 0
	end
end

--移除函数修改
function table.removeEx(tab,b_idx,e_idx)
	if not is_table(tab) then return end
	
	local len = #tab
	--删除数据
	for i = b_idx,e_idx do
		tab[i] = nil
	end
	--数据移位
	local num = len - e_idx + 1
	for i = 0,num - 1 do
		tab[b_idx + i] = tab[e_idx + i]
	end
	--清楚残留数据
	for i = len,len - num,-1 do
		tab[i] = nil
	end
end

--查找移除
function table.find_remove(tab,v)
	for _inx,_v in ipairs(tab) do
		if v == _v then
			table.remove(tab,_inx)
			return
		end
	end
end

--深度拷贝
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

--深度拷贝 v:跳过的值 nil 不起作用 c 跳过次数
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

--不会递归拷贝 不会拷贝重复的值
--GetValue 计算值得方法
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

--清空数据包装
function table.clear(t)
	--直接进行数据清空
	if not is_table(t) then
		return
	end
    for k,v in pairs(t) do
        t[k] = nil
    end
end
--清空数据(不删除tab)
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

local uv_fortab = {} --回收表
local uv_waitls = {} --待回收
local uv_waitrecycle = false

--直接回收
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

--直接回收
function table.recycles(...)
	for k,v in pairs(...) do
		recycle(v)
	end
end

--等待回收：之后所有新申请的table into uv_waitls
function table.wait_fortab()
	uv_waitrecycle = true
end

--等待回收：之后回收所有临时表
function table.wait_recycle()
	for _t,_ in pairs(uv_waitls) do
		recycle(_t)
	end
	uv_waitrecycle = false
end

--从缓存表中申请一个空表 bRecycle:true 表示待回收
function table.fortab()
    --去除数据
	local idx = #uv_fortab
	local tab = uv_fortab[idx] or {}
    uv_fortab[tab] = nil
	
	if uv_waitrecycle then
		uv_waitls[tab] = true
	end
	return tab
end


--判断空表
function table.empty(t)
	return nil == next(t)
end

--获取通用方法
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

--通用设置数据
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

--通用设置数据
function table.default(t,k)
	if not is_table(t[k]) then
		t[k] = table.fortab()
	end
	return t[k]
end

--抽牌
function table.remove_card(array,pos)
	table.exchange(array,pos,#array)
	local oval = array[#array]
	array[#array] = nil
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
		print('__newindex:Read - only table read - write failed')
	end,
	
	__assign = function(t,k,v)
		print('__assign:The reassignment failed')
	end
}

--设置一个只读表
function table.read_only(tab)
	setmetatable(tab,_read_only_tm)
	return tab
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


local _zero_mt = {
	__index = function(t,k)
		return 0
	end
}

--设置默认值0表
function table.default_zero(tab)
    setmetatable(tab,_zero_mt)
end

--设置只读配置表递归
function table.only_read(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.only_read(v)
		end
	end
	table.only_read(tab)
end

--设置不可覆盖配置表递归
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

--统计表和
function table.sum_has(t)
	local sum = 0
	for _,v in pairs(t) do
		sum = sum + v
	end
	return sum
end

--统计数组和
function table.sum_arr(t)
	local sum = 0
	for _,v in ipairs(t) do
		sum = sum + v
	end
	return sum
end

--table计数
function table.has_count(t)
	local has = table.fortab()
	for k,v in pairs(t) do
		has[v] = (has[v] or 0) + 1
	end
	return has
end

return table