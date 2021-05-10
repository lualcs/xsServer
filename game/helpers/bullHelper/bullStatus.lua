--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class bullStatus:gameStatus
local bullStatus = class(gameStatus)

---构造 
function bullStatus:ctor()
end

return bullStatus