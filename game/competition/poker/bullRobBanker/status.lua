--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local pokerStatus = require("poker.status")
---@class bullStatus:gameStatus
local status = class(pokerStatus)

---构造 
function status:ctor()
end

return status