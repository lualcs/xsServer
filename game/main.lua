local skynet = require "skynet"
local tostring = require("extend_tostring")
local tostring_outer = require("tostring_outer")
local table = require("extend_table")
local sort = require("extend_sort")
local mjHelper = require("mahjongHelper")


skynet.start(function()
	
	local start = os.time()
	local arithmetic = require("mahjongArithmetic")
	local close = os.time()
	local passd = close - start

	skynet.error("经过时间",passd)

	local hand = {0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x11,0x12,0x13,0x14,0x15,0x16}

	arithmetic.inittialize({
		{color=1,start=1,close=9},
		{color=2,start=1,close=9},
		{color=3,start=1,close=9},
	})

	if arithmetic.ableHu(hand) then
		skynet.error("允许胡牌")
	else
		skynet.error("不能胡牌")
	end

	local start = os.time()
	for i=1,100000 do
		arithmetic.ableHu(hand)
	end

	local close = os.time()
	local passd = close - start

	skynet.error("经过时间",passd)
	
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