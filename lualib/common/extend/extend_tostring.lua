--[[
    file:tostring.lua
    desc:table 转字符串
    auto:Carol Luo
]]

local table = require("extend_table")
local string = require("extend_string")
local is_boolean = require("is_boolean")
local is_number = require("is_number")
local is_table = require("is_table")
local is_string = require("is_string")

local tostring = tostring
local print = print
local pairs = pairs

local function _tablestring(strlist,val,level,key)
	if is_string(val) then
		table.insert( strlist,val)
	elseif not is_table(val) then
		table.insert(strlist,tostring(val))
	end

	level = level or 0
	local indent
	if level > 0 then
		indent = string.rep("\t",level)
	else
		indent = ""
	end

	if is_string(key) then
		table.insert( strlist,"\r\n")
		table.insert( strlist,indent)
		table.insert( strlist,key)
		table.insert( strlist," = ")
		table.insert( strlist,"{")
	elseif is_number(key) then
		table.insert( strlist,"\r\n")
		table.insert( strlist,indent)
		table.insert( strlist,"[")
		table.insert( strlist,tostring(key))
		table.insert( strlist,"]")
		table.insert( strlist," = ")
		table.insert( strlist,"{")
	elseif is_table(key) then
		_tablestring(strlist,key,level)
		table.insert( strlist,"\r\n")
		table.insert( strlist,"\r\n")
		table.insert( strlist,indent)
		table.insert( strlist," = ")
		table.insert( strlist,"\r\n")
	elseif is_boolean(key) then
		table.insert( strlist,"[")
		table.insert(strlist,tostring(key))
		table.insert( strlist,"]")
	else
		table.insert( strlist,"{")
	end
	
	if is_table(val) then
		table.insert( strlist,"\r\n")
		table.insert( strlist,indent)
	else
		return
	end
	
	for k,v in pairs(val) do
		--v是table k非table
		if is_table(v) then
			_tablestring(strlist,v, level + 1,k)
		else
			table.insert( strlist,"\r\n")
			table.insert( strlist,indent)
			table.insert( strlist,"\t")

			if is_string(k) then
				table.insert( strlist,k)
				table.insert( strlist," = ")
				if is_string(v) then
					table.insert( strlist,"\"")
					table.insert( strlist,v)
					table.insert( strlist,"\"")
				else
					table.insert( strlist,tostring(v))
				end
			else
				table.insert( strlist,"[")
				table.insert( strlist,tostring(k))
				table.insert( strlist,"]")
				table.insert( strlist," = ")
				if is_string(v) then
					table.insert( strlist,"\"")
					table.insert( strlist,v)
					table.insert( strlist,"\"")
				else
					table.insert( strlist,tostring(v))
				end
			end

			table.insert( strlist,",")
		end
	end
	
	table.remove( strlist)
	table.insert( strlist,"\r\n")
	table.insert( strlist,indent)

	if level > 0 then
		table.insert( strlist,"},")
	else
		table.insert( strlist,"}")
	end
end


local strlist = {}
return function(v)
	if is_table(v) then
		table.clear(strlist)
		_tablestring(strlist,v,0)
		return table.concat(strlist)
	end
	return tostring(v)
end

