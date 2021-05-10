--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class tigerStatus:gameStatus
local tigerStatus = class(gameStatus)

---构造 
function tigerStatus:ctor()
end

return tigerStatus