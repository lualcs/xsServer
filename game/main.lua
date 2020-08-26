local skynet = require "skynet"
skynet.start(function()
	skynet.error("Server start")
	local mjHelper = require("mahjongHelper")
	local mjCards = require("mahjongCardsXZ")
	local hasMahjongFull = require("mahjongHasCardXZ")
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

	skynet.error(require("tostring")(ting))
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