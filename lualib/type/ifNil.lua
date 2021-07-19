
local type = type
return function(v)
	return 'nil' == type(v)
end