--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class pokerStatus:gameStatus
local mahjongStatus = class(gameStatus)

---构造 
function mahjongStatus:ctor()
end

return mahjongStatus