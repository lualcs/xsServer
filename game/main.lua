local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
require("type")

skynet.start(function()
	skynet.error("Server start")
	for k,v in pairs(_G) do
		print(k,v)
	end
end)
