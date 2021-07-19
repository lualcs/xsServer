--[[
    desc:扑克桌子
    auth:Carol Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local bullEnum = require("bullEnum")
local pokerCompetition = require("poker.competition")
---@class bullTable:pokerCompetition
local competition = class(pokerCompetition)
local this = competition


---构造
function competition:ctor()
end

return competition