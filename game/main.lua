local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
skynet.start(function()
	skynet.error("Server start")

	for k,v in pairs(package.loaded) do
		print(k,v)
	end

end)
