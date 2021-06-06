local ifInt = require("ifInt")
return function(v)
	return ifInt(v) and v >= 1 and v <= 7
end