local skynet = require "skynet"
skynet.start(function()
	skynet.error("Server start")
	local table = require("extend_table")
	local mjHelper = require("mahjongHelper")
	local mjCards = require("mahjongCardsXZ")
	local hasMahjongFull = require("mahjongHasCardXZ")
	local start = os.time()
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
		if 0 == i % 1000 then
			skynet.error(require("tostring")(ting))
			local close = os.time()
			skynet.error("elapsed time:"..tostring(close-start))
		end
		table.wait_recycle()
	end
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