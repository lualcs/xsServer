local skynet = require "skynet"
local tostring = require("tostring")
local tostring_outer = require("tostring_outer")
skynet.start(function()
	-- skynet.error("Server start")
	-- local table = require("extend_table")
	-- local mjHelper = require("mahjongHelper")
	-- local mjCards = require("mahjongCardsXZ")
	-- local hasMahjongFull = require("mahjongHasCardXZ")
	-- local start = os.time()
	-- mjHelper.start_dg_count()
	-- local ting
	-- local count = 100000
	-- local test = 0
	-- for i=1,count do
	-- 	-- table.wait_fortab()
	-- 	-- ting = mjHelper.getTingInfo(
	-- 	-- 	{
	-- 	-- 		0x01,0x02,0x03,
	-- 	-- 		0x04,0x05,0x06,
	-- 	-- 		0x07,0x08,0x09,
	-- 	-- 		0x01,0x02,0x03,
	-- 	-- 		0x01,0x01
	-- 	-- 	},
	-- 	-- 	hasMahjongFull)
	-- 	-- table.wait_recycle()
	-- 	-- if 0 == i % 100 then
	-- 	-- 	skynet.error(i/count*100)
	-- 	-- end
	-- 	test = test + 1
	-- end

	-- local close = os.time()
	-- local pass = close-start
	-- skynet.error("秒:",tostring(pass),"次数：",test)
	-- --mjHelper.Look_dg_count()
	-- --skynet.error("ting",tostring(ting))
	-- -- if mjHelper.checkAbleHu({
	-- -- 	0x01,0x02,0x03,
	-- -- 	0x04,0x05,0x06,
	-- -- 	0x07,0x08,0x09,
	-- -- 	0x11,0x12,0x13,
	-- -- 	0x01,0x01
	-- -- }) then
	-- -- 	skynet.error("胡牌")

	-- -- end

	skynet.error("测试 print r")

	for i = 1,10 do
		skynet.error(string.format("i=%d /r",i))
	end


	skynet.error("测试 table.pack")

	skynet.error(tostring(table.pack(1,2,3,4,5,6)))


	skynet.error("测试 table.unpack")

	skynet.error(table.unpack({1,2,3,4,5,6,7,8,9}))

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