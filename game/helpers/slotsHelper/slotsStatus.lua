--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class slotsStatus:gameStatus
local slotsStatus = class(gameStatus)

---构造 
function slotsStatus:ctor()
end

return slotsStatus