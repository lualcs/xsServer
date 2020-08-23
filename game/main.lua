local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local tostring = require("tostring")
skynet.start(function()
	skynet.error("Server start")
	-- skynet.error(tostring({
	-- 	lcs = {
	-- 		base = {
	-- 			job = "game develop",
	-- 			name = "carol",
	-- 			wechat = "ZCQ-2020520",
	-- 			girlfrendly = {
	-- 				name = "张彩琴",
	-- 				frame = "资中",
	-- 				live = "资阳"
	-- 			}
	-- 		}
	-- 	}
	-- }))

	for k,v in pairs(_G.package) do
		print(k,v)
	end

end)
