--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("game.status")
---@class pokerStatus:gameStatus
local status = class(gameStatus)

---构造 
function status:ctor()
end

return status