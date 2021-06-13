--[[
    file:pokerCompetition.lua 
    desc:扑克桌子
    auth:Carol Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local pokerEnum = require("poker.enum")
local gameCompetition= require("game.competition")
---@class pokerCompetition:gameCompetition
local competition = class(gameCompetition)
local this = competition


---构造
function competition:ctor()
end

return competition