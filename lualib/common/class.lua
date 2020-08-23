local table = require("table")

--[[class �� 
	
]]
--������
local class_list = {}
local single_object= {}
local class_keyword = {--A global public method for editable modifications
    new = true,
}

local keyword = {--Special field check filtering
	__index = true,
	__newindex = true,
	__assign = true,
	__classname = true,
	new = true		
}

local function check_supers(className,supers)
	local has = {}
	for _,_obj in ipairs(supers) do
		for _name,_value in pairs(_obj) do
			if nil == has[_name] then
				has[_name] = _value
			elseif not keyword[_name] then
				print(false,string.format("class:%s member:%s warning:undfine If you rewrite it yourself, ignore it",className,tostring(_name)))
				return false
			end
		end
	end
	return true
end


--[[����ʵ��
    single = true --����������ֽڱ�־��һ��������
]]
local function new(self,...)

	local name = self.__classname
	if self.single and single_object[name] then
		return single_object[name]
	end
	
	local new_obj = table.fortab()
	setmetatable(new_obj,self)
	
	--�Զ����ù��캯��
	new_obj:ctor(...)
	if self.single then
		single_object[self.__classname] = new_obj
	end
	return new_obj
end

local function class(name,...)
	if not is_string(name) then
		print('the class name is not a string:',tostring(name))
		return
	end

	if class_list[name] then
		print('the class redefine��',name)
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

	if not check_supers(name,met) then
		return 
	end

	local obj = {
		__classname = name,
		new = new
	}
	--���ʼ̳ж����Ա �ֶ�
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
	--���ڼ�⸲�Ǻ���
	function met.__assign(t,k,v)
		if is_function(t[k]) or is_function(v) then
			print('new or old value is function Please check yours class:',name,':',tostring(k))
			return
		end
		rawset(t, k, v)
	end

	class_list[name] = obj
	setmetatable(obj,met)
	--��������Ա�֤��ʵ�����Է��ʸ�����
	obj.__index = obj
	
	return obj
end

return class
