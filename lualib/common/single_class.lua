local class = require("class")

local single_list = {}
--声明单例内
local function single_class(name,...) 
	local obj = class(name,...)
	obj.single = true
	single_list[#single_list+1]=obj
    return obj
end


return single_class