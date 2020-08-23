local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local tostring = require("tostring")
local class = require("class")
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

	local a = class('test')
	function a.a()end
	function a.a()end

end)
