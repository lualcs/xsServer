--[[
	desc:调试扩展
]]

local is_number,is_table = is_number,is_table

local pairs = pairs

local print = print

local string = string
local debug = debug
local table = table
local isdummy = false


--舍弃原来的报错函数
function errorEx(...)
	print(...)--还是需要打印出来
	local tracebackinfo = table.concatEx(debug.traceback(),'\r\n',...)
	return Log('脚本错误日志.lua',tracebackinfo)
end

local max_depth = 10
local stack_check = {}
function toinfo(val,level,key,ex_cm)
    local str = ''
    if is_number(level) and level > max_depth then
        return str--避免堆栈溢出
    end
    --特殊数据结构检查避免循环
    if not is_number(level) then
        table.clearEx(stack_check)
    elseif is_number(level) and is_table(val) then
        if stack_check[val] and stack_check[val] > 1 and level > 3 then
            return str--遇到循环表
        end
        stack_check[val] = (stack_check[val] or 0) + 1
    end
	if nil == ex_cm then
		ex_cm = ' = '
	end
	if not is_table(val) then
		str = tostring(val)
	end
	level = level or 0
	local indent
	if level > 0 then
		indent = string.rep('\t',level)
	else
		indent = ' '
	end
	if is_string(key) then
		str = table.concatEx(str,'\r\n',indent,key,ex_cm,'{')
	elseif is_number(key) then
		str = table.concatEx(str,'\r\n',indent,'[',key,']',ex_cm,'{')
	elseif is_table(val) then
		str = table.concatEx(str,'\r\n',indent,'{')
	else
		return str
	end
	
	for k,v in pairs(val) do
		--不打印哑元
		if '' ~= k or isdummy then
			if is_table(v) then
				str = table.concatEx(str,toinfo(v, level + 1,k))
			else
				if is_string(k) then
					if is_string(v) then
						str = table.concatEx(str,'\r\n',indent,'\t',k,ex_cm,'"',v,'",')
					else
						str = table.concatEx(str,'\r\n',indent,'\t',k,ex_cm,tostring(v),',')
					end
				else
					if is_string(v) then
						str = table.concatEx(str,'\r\n',indent,'\t','[',tostring(k),']',ex_cm,'"',v,'",')
					else
						str = table.concatEx(str,'\r\n',indent,'\t','[',tostring(k),']',ex_cm,tostring(v),',')
					end
				end
			end
		end
	end
	if level > 1 then
		str  = table.concatEx(str,'\r\n',indent,'},')
	else
		str  = table.concatEx(str,'\r\n',indent,'},')
	end
	return str
end

function look(val,not_time)
	toinfo(val)
	local now_date_str = (not not_time) and os.date("%Y-%m-%d %H:%M:%S",os.time())
	print(table.concatEx(toinfo(val),'\r\n',now_date_str or ''))
end
function lookEx(val,...)
	local str = val
	if is_string(val) then
		str = string.formatEx(str,...)
	end
	print(str)
end

function Log(_path,val,ex_cm)
	local now_date_str = os.date("%Y-%m-%d-%H:%M:%S",os.time())
	local loginfo = table.concatEx('\r\n',toinfo(val,nil,nil,ex_cm),'\r\n',now_date_str)
	local file = io.open(_path,'a+')
	file:write(loginfo)
	io.close(file)
end
function LogEx(_path,val,...)
	local str = val
	if is_string(val) then
		str = string.formatEx(str,...)
	end
	Log(_path,str)
end
--打印一个数组
function Log_array(file,w,h)
    local str_array = '{\r\n'
    for pos=1,w*h do
        if pos < 10 then
            str_array = table.concatEx(str_array , '[0' , pos,"]='xxx',")
        else                                                         
            str_array = table.concatEx(str_array , '['  , pos,"]='xxx',")
        end
        if pos % w == 0 then
            str_array = str_array .. '\r\n'
        end
    end
    table.concatEx(str_array,'\r\n}')
    Log(file,str_array)
end


function debug.open_dummy()
	isdummy = true
end

function debug.close_dummy()
	isdummy = false
end