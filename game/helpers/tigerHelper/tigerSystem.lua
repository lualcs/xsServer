--[[
    file:tigerSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local gameSystem = require("gameSystem")
---@class tigerSystem:gameSystem @策略
local tigerSystem = class(gameSystem)

---构造函数
function tigerSystem:ctor()
end

return tigerSystem