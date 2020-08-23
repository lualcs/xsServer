--[[
	desc:标准库扩展
]]

local table = table
local select = select
local math = math
local is_nil,is_number,is_string,is_table = is_nil,is_number,is_string,is_table
local pairs,ipairs = pairs,ipairs
local setmetatable = setmetatable
--table 中的值交换
function table.exchange(tab,idx1,idx2)
	local temp = tab[idx1]
	tab[idx1] = tab[idx2]
	tab[idx2] = temp
end

--联合数组包装
function table.concatEx(...)
	
	local _concat_tab = table.fortab()
	local uv_arg
	for i = 1,select('#',...) do
		uv_arg = select(i,...)
		--特殊情况nil也要联合成字符串
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

--desc:	将data压入t的尾部
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

--深度拷贝
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
    if not is_table(t) then return end
    for k,v in pairs(t) do
        t[k] = nil
    end
end
--清空数据(不删除tab)
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
--数据清空并且回收
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
--直接回收
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

--直接回收
function table.recycles(...)
	for k,v in pairs(...) do
		table.recycle(v)
	end
end

--从缓存表中申请一个空表
function table.fortab()
    --去除数据
	local idx = #uv_fortab
	local tab = uv_fortab[idx]
    uv_fortab[idx] = nil
	
	--如果没有新table 则创建一个
	return tab or {}
end
--判断空表
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
		errorEx('__newindex:Read - only table read - write failed')
	end,
	
	__assign = function(t,k,v)
		errorEx('__assign:The reassignment failed')
	end
}

--设置一个只读表
function table.read_only(tab)
	setmetatable(tab,_read_only_tm)
	return tab
end

local _noassign_tm = {
	__assign = function(t,k,v)
		errorEx('__assign:The reassignment failed')
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
function table.zeroRead(tab)
    setmetatable(tab,_zero_mt)
end

--设置只读配置表递归
function table.read_onlyS(tab)
	for k,v in pairs(tab) do
		if is_table(v) then
			table.read_onlyS(v)
		end
	end
	table.read_only(tab)
end

--设置不可覆盖配置表递归
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

return table