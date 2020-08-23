
local type = type
return function(v)
	return 'table' == type(v)
end