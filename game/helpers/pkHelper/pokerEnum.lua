--[[
    file:pokerEnum.lua 
    desc:扑克枚举
    auth:Caorl Luo
]]

local class = require("class")
local gameEnum = require("gameEnum")
---@class pokerEnum:gameEnum
local pokerEnum = class(gameEnum)
local this = pokerEnum

---构造
function pokerEnum:ctor()
end

return pokerEnum