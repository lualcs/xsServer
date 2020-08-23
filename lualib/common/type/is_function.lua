
local type = type
return function(v)
	return 'function' == type(v)
end