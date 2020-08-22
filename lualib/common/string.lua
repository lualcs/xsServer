--[[
	file:string.lua
	desc:string ��׼����չ �� ʹ��˵��
]]
local string = string
local table = table
local select = select
local pcall = pcall
local pairs,ipairs = pairs,ipairs
local __G = _G

function string.formatEx(str,...)
	local args = table.fortab()
	local arg_val
	for i = 1,select('#',...) do
		arg_val = select(i,...)
		args[i] = tostring(arg_val)
	end
	return string.format(str,args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10])
end

--[[
	�ַ����ָ� ֧������
	param:	s	����ֵ�string	
			p	�ָ���(������������ʽ)
	return: {}��ֳ��������б�
]]
function string.gsplit(s, p)
	local init = 1
	local ret = table.fortab()

	repeat
		local bpos, epos, cap = string.find( s, p, init)
		if nil ~= bpos then
			if bpos~=init then
				local preP = string.sub(s, init, bpos-1)
				table.push( ret, preP)
			end

			if cap then
				table.push( ret, cap)
			end
			init = epos+1
		elseif string.len(s)>=init then
			table.push( ret, string.sub(s,init) )
		end
	until nil==bpos
	return ret
end

--[[
	�ص���Ա����
]]

function string.pcall(str,VarTab)
	local array = string.gsplit(str, ':')
	local object = __G[array[1]]
	local fun = object[array[2]]
	local ret,info = pcall(fun,object,VarTab)
	if not ret then
		errorEx(ret,'string.MemberCall',info)
	end
	table.recycle(array)
end

function string.call(str,VarTab)
	local fun = __G[str]
	return fun(VarTab)
end