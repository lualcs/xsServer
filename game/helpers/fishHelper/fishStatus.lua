--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class fishStatus:gameStatus
local fishStatus = class(gameStatus)

---构造 
function fishStatus:ctor()
end

return fishStatus