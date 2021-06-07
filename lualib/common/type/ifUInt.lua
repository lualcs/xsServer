local ifInt = require("ifInt")
return function(v)
	return ifInt(v) and 0 == v%1 and v >= 0
end