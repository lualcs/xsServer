local skynet = require "skynet"
local tostring = require("tostring")
skynet.start(function()
	skynet.error("Server start")
	local table = require("extend_table")
	local mjHelper = require("mahjongHelper")
	local mjCards = require("mahjongCardsXZ")
	local hasMahjongFull = require("mahjongHasCardXZ")
	local start = os.time()
	local last = 0
	for i=1,100000 do
		table.wait_fortab()
		local ting = mjHelper.getTingInfo(
			{
				0x01,0x02,0x03,
				0x04,0x05,0x06,
				0x07,0x08,0x09,
				0x01,0x02,0x03,
				0x01,0x01
			},
			mjCards,
			hasMahjongFull)

		local close = os.time()
		local pass = close-start
		if pass > (last + 10) then
			skynet.error("秒:",tostring(pass),"次数：",pass)
			last = pass
		end
		table.wait_recycle()
	end


	-- if mjHelper.checkAbleHu({
	-- 	0x01,0x02,0x03,
	-- 	0x04,0x05,0x06,
	-- 	0x07,0x08,0x09,
	-- 	0x11,0x12,0x13,
	-- 	0x01,0x01
	-- }) then
	-- 	skynet.error("胡牌")

	-- end

end)


--[[
	game = {
		lualib = {
			mahjongHelper = 麻将辅助
			pokerHelper = 扑克辅助
		},

		service = {
			wswatchdog
		},

	}
]]