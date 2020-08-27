local table = require("table")
local string = require("string")
local is_number = require("is_number")
local is_table = require("is_table")
local is_string = require("is_string")

local tostring = tostring
local print = print
local pairs = pairs

local strlist = {}
local function _tablestring(val,level,key)
	
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
		table.insert( strlist,key)
		table.insert( strlist," = ")
		table.insert( strlist,"{")
	elseif is_number(key) then
		table.insert( strlist,"\r\n")
		table.insert( strlist,"[")
		table.insert( strlist,key)
		table.insert( strlist,"]")
		table.insert( strlist," = ")
		table.insert( strlist,"{")
	elseif is_table(val) then
		table.insert( strlist,"\r\n")
		table.insert( strlist,indent)
		table.insert( strlist,"{")
	else
		return
	end
	
	for k,v in pairs(val) do
		if is_table(v) then
			_tablestring(v, level + 1,k)
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
					table.insert( strlist,k)
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
					table.insert( strlist,v)
				end
			end

			table.insert( strlist,",")
		end
	end

	table.insert( strlist,"\r\n")
	table.insert( strlist,indent)

	if level > 0 then
		table.insert( strlist,"},")
	else
		table.insert( strlist,"}")
	end
end


return function(v)
	if is_table(v) then
		table.clear(strlist)
		_tablestring(v,0)
		return table.concat(strlist)
	end
	return tostring(v)
end

