--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class pokerStatus:gameStatus
local pokerStatus = class(gameStatus)

---构造 
function pokerStatus:ctor()
end

return pokerStatus