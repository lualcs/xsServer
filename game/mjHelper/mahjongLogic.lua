--[[
    file:mahjongLogic.lua 
    desc:麻将扑克
    auth:Carol Luo
]]

local class = require("class")

local gameLogic = require("gameLogic")
---@class mahjongLogic:gameLogic @麻将扑克
local mahjongLogic = class(gameLogic)

---构造
---@param table mahjongTable
function mahjongLogic:ctor(table)
    self._table = table
end

return mahjongLogic