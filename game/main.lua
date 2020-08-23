local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local myLibrary = require("myLibrary")

skynet.start(function()
	skynet.error("Server start")
	for k,v in pairs(_G) do
		print(k,v)
	end
end)
