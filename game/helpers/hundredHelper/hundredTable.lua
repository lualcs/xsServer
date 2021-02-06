--[[
    file:hundredTable.lua
    desc:桌子
    auth:Caorl Luo
]]
local class = require("class")
local ranking  = require("ranking")
local gameTable = require("gameTable")
---@class hundredTable:gameTable
local hundredTable = class(gameTable)

---构造 
function hundredTable:ctor()
    ---神算子排行榜
    ---@type ranking
    self._ssz_rank = ranking.new(10)
    ---大富豪排行榜
    ---@type ranking
    self._dfh_rank = ranking.new(10)
end

return hundredTable