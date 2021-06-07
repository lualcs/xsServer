local ifNumber = require("ifNumber")
return function(v)
	return ifNumber(v) and 0 == v%1
end