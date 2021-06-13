--[[
    desc:桌子
    auth:Carol Luo
]]

local class = require("class")
local gameCompetition = require("game.competition")
---@class chessTable:gameCompetition @桌子
local competition = class(gameCompetition)

---构造函数
function competition:ctor()
end

return competition