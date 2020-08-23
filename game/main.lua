local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local tostring = require("tostring")
skynet.start(function()
	skynet.error("Server start")
	skynet.error(tostring(_G))
end)
