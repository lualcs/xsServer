--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
local senum = require("hundredHelper.hundredEnum")
---@class hundredStatus:gameStatus @状态机
local hundredStatus = class(gameStatus)

---构造 
function hundredStatus:ctor()
end


return hundredStatus