
--[[
file: include.lua
desc: 随机函数
author:	lcs
update:2018-7-15
]]--

local table = table
local is_number,is_string,is_table,is_types = is_number,is_string,is_table,is_types
local ipairs,pairs = ipairs,pairs

local math = math

random = {}

--[[随机出不重复随机数     常用版本
    random_list:传入一个tab 存放随机出来的随机数下标
    random_lib:传入一个tab 是一个随机库
    num：需要的随机数数量
	exclude:传入一个tab 是一个排除列表{[排除k] = true}

]]
function random.no_repetiton(random_list,random_lib,num,exclude)
	 --参数检查
	if not is_table(random_list) then return -1 end
	if not is_table(random_lib) then return -2 end
	if not is_number(num) then return -3 end
	table.clr(random_list)
	--筛选随机索引
	if not exclude then
        --没有排除项
		for k,v in pairs(random_lib) do
			if is_number(k) then
				random_list[#random_list + 1] = k
			end
		end
	else
        --有排除项
		for k,v in pairs(random_lib) do
			if is_number(k) and not exclude[k] then
				random_list[#random_list + 1] = k
			end
		end
	end
	
	--随机数据
	local b_idx,e_idx = 1,#random_list
	local r_idx
	for i = 1,num do
		if b_idx > e_idx then return -4 end
		r_idx = math.random(b_idx,e_idx)
		table.exchange(random_list,r_idx,i)
		b_idx = b_idx + 1
	end
	table.removeEx(random_list,b_idx,e_idx)--只保留随机的数据
	return random_list
end

--[[随机出不重复随机数     分段版本
   min_num ~ max_num 随机 get_num 个不重复随机数
   
   list：保存随机数

]]
function random.no_repetition_sub(min_num,max_num,get_num,list)
	 --参数检查
	if not min_num or not max_num or not get_num or not list then
		return
	end
	local i_sub = math.floor((max_num - min_num) / get_num)
	local i_mod = (max_num - min_num) % get_num
	local b_idx = min_num
	local e_idx = b_idx + i_sub
	for i=1,get_num do
		list[i] = math.random(b_idx,e_idx)
		b_idx,e_idx = e_idx,e_idx + i_sub
		if i_mod > 0 then
			e_idx = e_idx + 1
			i_mod = i_mod - 1
		end
	end
	--判断乱序
	return sort.shuffle(list)
end

--抽牌
function random.out_card(arrayCard)
	local count = #arrayCard
	local rand = math.random(1,count)
	local value = arrayCard[rand]
	
	table.exchange(arrayCard,rand,count)
	arrayCard[count] = nil

	return value
end