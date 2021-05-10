--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class hundredStatus:gameStatus
local hundredStatus = class(gameStatus)

---构造 
function hundredStatus:ctor()
end

return hundredStatus