--[[
    file:mahjongSystem.lua 
    desc:麻将自动AI
    auth:Carol Luo
]]

local class = require("class")

local gameSystem = require("gameSystem")
---@class mahjongSystem:gameSystem
local mahjongSystem = class(gameSystem)
local this = mahjongSystem

---构造
function mahjongSystem:ctor()
end

---出牌

---吃牌

---碰牌

---暗杠

---饶杠

---直杠

return mahjongSystem