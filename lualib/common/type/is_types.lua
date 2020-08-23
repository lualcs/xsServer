local select = select
return function(fun,...)
	for i = 1,select('#',...) do
		if not fun(select(i,...)) then
			return false,i
		end
	end
	return true
end