--[[
	desc:数据类型检测
]]

local type = type
--需要序列化的数据类型判断
local is_datak_list = {['boolean']=true,['number']=true,['string']=true,['table']=true,}
local is_datav_list = {['boolean']=true,['number']=true,['string']=true,['nil'] = true}
function is_datak(v)
	return is_datak_list[type(v)]
end

function is_datav(v)
	return is_datav_list[type(v)]
end


--基础数据类型判断
function is_nil(v)
	return nil == v
end

function is_bool(v)
	return 'boolean' == type(v)
end

function is_number(v)
	return 'number' == type(v)
end

function is_string(v)
	return 'string' == type(v)
end

function is_function(v)
	return 'function' == type(v)
end

function is_table(v)
	return 'table' == type(v)
end

function is_userdata(v)
	return 'userdata' == type(v)
end

function is_thread(v)
	return 'thread' == type(v)
end

local is_nil,is_bool,is_string,is_table,is_function,is_userdata,is_thread = is_nil,is_bool,is_string,is_table,is_function,is_userdata,is_thread

--number 数值判断
--整数
function is_int(v)
	return is_number(v) and v % 1 == 0
end

--无符号整数
function is_uint(v)
	return is_int(v) and v >= 0
end

--正数
function is_positiveNumber(v)
	return is_number(v) and v > 0
end

--正整数
function is_positiveInteger(v)
	return is_int(v) and v > 0
end

--负数
function is_negativeNumber(v)
	return is_number(v) and v < 0
end

--负整数
function is_negativeInteger(v)
	return is_int(v) and v < 0
end

--浮点数
function is_float(v)
	return is_number(v) and v % 1 ~= 0
end

local uv_lowercase = {
	a=true,b=true,c=true,d=true,e=true,f=true,g=true,h=true,i=true,j=true,
	k=true,l=true,m=true,n=true,o=true,p=true,q=true,r=true,s=true,t=true,
	u=true,v=true,w=true,x=true,y=true,z=true,
}

--判断是否是小写字母
function is_lowercase(v)
	return uv_lowercase[v]
end

local uv_uppercase = {
	A=true,B=true,C=true,D=true,E=true,F=true,G=true,H=true,I=true,J=true,
	K=true,L=true,M=true,N=true,O=true,P=true,Q=true,R=true,S=true,T=true,
	U=true,V=true,W=true,X=true,Y=true,Z=true,
}
--判断是否是大写字母
function is_uppercase(v)
	return uv_uppercase[v]
end

local is_lowercase,is_uppercase = is_lowercase,is_uppercase

--判断是否是字母
function is_letter(v)
	return is_lowercase(v) or is_uppercase(v)
end

--判断字符是否是ascii码表
function is_ASCII(v)
	if not is_string(v) then return end
	if 1 ~= #v then return end
	
	local vchar = string.byte(v)
	return is_string(v) and 0 <= vchar and 255 >= vchar
end

--判断是否是周1 到周7的值
function is_week(v)
	return is_int(v) and v >= 1 and v <= 7
end

--同一类型多个参数判断
function is_types(fun,...)
	for i = 1,select('#',...) do
		if not fun(select(i,...)) then
			return false,i
		end
	end
	return true
end

--返回一个对象--用于模块标记已加载 避免报错
return {}


