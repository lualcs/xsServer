--[[
	desc:面向对象代码设计
	考虑代码的简洁性
	考虑代码运行效率
]]
--[[面向对象代码设计
	ctor = 构造函数关键字
	super = 继承对象关键字
]]
local _G = _G
local tostring = tostring
local error,select = error,select
local is_table,is_function  = is_table,is_function
--类对象库
local class_list = {}
local single_list = {}
local class_keyword = {--A global public method for editable modifications
    new = true,
}

local keyword = {--Special field check filtering
	__index = true,
	__newindex = true,
	__assign = true,
	__classname = true,
}

local function class_chack_undefine(name,superS)
	if not is_table(superS) then return end

	local tabResult = {}

	for _,_obj in ipairs(superS) do
		if is_table(_obj) then
			for memberName,memberValue in pairs(_obj) do
				if nil == tabResult[memberName] then
					tabResult[memberName] = memberValue
				elseif not keyword[memberName] then
					errorEx('class:',name,' memberName:',memberName,' warning:undfine If you rewrite it yourself, ignore it')
				end
			end
		end
	end
	return true
end
--[[对象创建
]]
function class(name,...)
	if not is_string(name) then
		errorEx('the class name is not a string:',tostring(name))
		return
	end

	if class_list[name] then
		errorEx('the class redefine：',name)
		return
	end
	local met = {}
	local super
	for i = 1,select('#',...) do
		super = select(i,...)
		if is_table(super) and super ~= _G then
			met[#met + 1] = super
		end
	end

	if not class_chack_undefine(name,met) then return end

	local obj = {
		__classname = name,
	}
	--访问继承对象成员 字段
	local uv_met
	function met.__index(t_v,t_k)
		if class_keyword[t_k] and _G[t_k] then
			return _G[t_k]
		end
		uv_met = getmetatable(t_v)
		for _idx,_super in ipairs(uv_met) do
			if _super[t_k] then
				return _super[t_k]
			end
		end
		return nil
	end
	--用于检测覆盖函数
	function met.__assign(t,k,v)
		if is_function(t[k]) or is_function(v) then
			errorEx('new or old value is function Please check yours class:',name,':',tostring(k))
			return
		end
		rawset(t, k, v)
	end

	class_list[name] = obj
	setmetatable(obj,met)
	--这句代码可以保证新实例可以访问父对象
	obj.__index = obj
	
	return obj
end

--声明单例内
function single_class(name,...) 
	local obj = class(name,...)
	obj.single = true
	single_list[#single_list+1]=obj
    return obj
end


--[[创建实例
    single = true --设置了这个字节标志是一个单例类
]]
function new(self,...)
    if self.single then
        errorEx('class->',self.name,'error:this class is a singe')
        os.execute('pause')
    end
	local new_obj = table.fortab()
	setmetatable(new_obj,self)
	
	--自动调用构造函数
	new_obj:ctor(...)
	return new_obj
end

--调用单例构造
function constructor_single()
	for k,v in ipairs(single_list) do
		v.ctor()
	end
end