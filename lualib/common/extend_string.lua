--[[
	file:string.lua
	desc:string 标准库扩展
	auto:Carol Luo
]]
local string = string
local table = table
local select = select
local pcall = pcall
local pairs,ipairs = pairs,ipairs
local __G = _G
local print = print
local tostring = tostring


--[[
	字符串分割 支持正则
	param:	s	被拆分的string	
			p	分隔符(可以是正则表达式)
	return: {}拆分出来的序列表
]]
function string.gsplit(s, p)
	local init = 1
	local ret = table.fortab()

	repeat
		local bpos, epos, cap = string.find( s, p, init)
		if nil ~= bpos then
			if bpos~=init then
				local preP = string.sub(s, init, bpos-1)
				table.insert( ret, preP)
			end

			if cap then
				table.insert( ret, cap)
			end
			init = epos+1
		elseif string.len(s)>=init then
			table.push( ret, string.sub(s,init) )
		end
	until nil==bpos
	return ret
end


return string

--[[
	--标准库 请不要覆盖
	{
        char = function: 0x556008af6330,
        byte = function: 0x556008af8030,
        format = function: 0x556008af64a0,
        len = function: 0x556008af59b0,
        dump = function: 0x556008af7e60,
        upper = function: 0x556008af5c50,
        match = function: 0x556008af8ab0,
        pack = function: 0x556008af7670,
        gsub = function: 0x556008af8ad0,
        gmatch = function: 0x556008af6260,
        rep = function: 0x556008af5db0,
        sub = function: 0x556008af7f20,
        unpack = function: 0x556008af72d0,
        packsize = function: 0x556008af7180,
        reverse = function: 0x556008af5d00,
        lower = function: 0x556008af5f40,
        find = function: 0x556008af8ac0,
}
]]