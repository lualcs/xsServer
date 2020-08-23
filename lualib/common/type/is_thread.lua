
local type = type
return function(v)
	return 'thread' == type(v)
end