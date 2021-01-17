--[[
    file:mahjongLogic.lua 
    desc:麻将扑克
    auth:Carol Luo
]]

local class = require("class")


---@class mahjongLogic @麻将扑克
local mahjongLogic = class()

---构造
---@param gameTable slotsTable
function mahjongLogic:ctor(gameTable)
    self._table = gameTable
end

return mahjongLogic