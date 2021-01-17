--[[
    file:mahjongEnum.lua 
    desc:麻将枚举
    auth:Caorl Luo
]]

local class = require("class")
local gameEnum = require("gameEnum")

---@class mahjongEnum:gameEnum @麻将枚举
local mahjongEnum = class(gameEnum)
local this = mahjongEnum

---构造 
function mahjongEnum:ctor()
end


return mahjongEnum