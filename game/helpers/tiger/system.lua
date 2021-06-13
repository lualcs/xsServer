--[[
    file:tigerSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local gameSystem = require("game.system")
---@class tigerSystem:gameSystem @策略
local system = class(gameSystem)

---构造函数
function system:ctor()
end

return system