--[[
    desc:策略
    auth:Carol Luo
]]
local class = require("class") 
local gameSystem = require("gameSystem")
---@class hundredSystem:gameSystem
local hundredSystem = class(gameSystem)
local this = hundredSystem

---构造 
function hundredSystem:ctor()
end

return hundredSystem