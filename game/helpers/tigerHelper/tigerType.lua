--[[
    file:tigerType.lua 
    desc:类型
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("gameType")
---@class tigerType:gameType @桌子
local tigerType = class(gameType)

---构造函数
function tigerType:ctor()
end

return tigerType