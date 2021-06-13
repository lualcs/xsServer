--[[
    file:pokerEnum.lua 
    desc:扑克枚举
    auth:Caorl Luo
]]

local class = require("class")
local gameEnum = require("game.enum")
---@class pokerEnum:gameEnum
local enum = class(gameEnum)
local this = enum

---构造
function enum:ctor()
end

return enum