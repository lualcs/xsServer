--[[
    file:fishTable.lua
    desc:桌子
    auth:Caorl Luo
]]
local class = require("class")
local gameCompetition = require("game.competition")
---@class fishCompetition:gameCompetition
local competition = class(gameCompetition)

---构造 
function competition:ctor()
end

return competition