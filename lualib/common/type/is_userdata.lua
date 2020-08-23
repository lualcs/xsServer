
local type = type
return function(v)
	return 'userdata' == type(v)
end