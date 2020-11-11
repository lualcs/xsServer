local skynet = require "skynet"
local tostring = require("extend_tostring")
local table = require("extend_table")
local sort = require("extend_sort")
local mjHelper = require("mahjongHelper")


skynet.start(function()
	
	local a = {test=2}
	table.read_only(a)
	a.test = 1
	a.test = 1
	
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