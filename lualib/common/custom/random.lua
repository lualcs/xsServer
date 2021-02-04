
--[[
file: include.lua
desc: �������
author:	lcs
update:2018-7-15
]]--

local table = table
local math = math
local ipairs,pairs = ipairs,pairs

local is_number = require("is_number")
local is_string = require("is_string")
local is_table = require("is_table")
local is_types = require("is_types")

local sort = require("sort")

local random = {}

--[[��������ظ������     ���ð汾
    random_list:����һ��tab ������������������±�
    random_lib:����һ��tab ��һ�������
    num����Ҫ�����������
	exclude:����һ��tab ��һ���ų��б�{[�ų�k] = true}

]]
function random.no_repetiton(random_list,random_lib,num,exclude)
	 --�������
	if not is_table(random_list) then return -1 end
	if not is_table(random_lib) then return -2 end
	if not is_number(num) then return -3 end
	table.clr(random_list)
	--ɸѡ�������
	if not exclude then
        --û���ų���
		for k,v in pairs(random_lib) do
			if is_number(k) then
				random_list[#random_list + 1] = k
			end
		end
	else
        --���ų���
		for k,v in pairs(random_lib) do
			if is_number(k) and not exclude[k] then
				random_list[#random_list + 1] = k
			end
		end
	end
	
	--�������
	local b_idx,e_idx = 1,#random_list
	local r_idx
	for i = 1,num do
		if b_idx > e_idx then return -4 end
		r_idx = math.random(b_idx,e_idx)
		table.exchange(random_list,r_idx,i)
		b_idx = b_idx + 1
	end
	table.removeEx(random_list,b_idx,e_idx)--ֻ�������������
	return random_list
end

--[[��������ظ������     �ֶΰ汾
   min_num ~ max_num ��� get_num �����ظ������
   
   list�����������

]]
function random.no_repetition_sub(min_num,max_num,get_num,list)
	 --�������
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
	--�ж�����
	return sort.shuffle(list)
end

---���һ��
---@param t any[]	@����
---@return any
function random.remove(t)
	local count = #t
	local rand = math.random(1,count)
	table.exchange(t,rand,count)
	return table.remove(t)
end

---Ȩ�����
---@param t table<index,number> @ӳ��
---@param s number				@�ܺ�
---@return index
function random.weight(t,s)
	local is = {}
	for i,_ in pairs(t) do
		table.insert(is,i)
	end
	table.sort(is)
	local r = math.random(1,s)
	for _,i in ipairs(is) do
		r = r - t[i]
		if r <= 0 then
			return i
		end
	end
end

return random