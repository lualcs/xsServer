--[[
    file:mahjongSystem.lua 
    desc:麻将自动AI
    auth:Carol Luo
]]

local class = require("class")

local gameSystem = require("game.system")
---@class mahjongSystem:gameSystem
local system = class(gameSystem)
local this = system

---构造
function system:ctor()
end

---出牌

---吃牌

---碰牌

---暗杠

---饶杠

---直杠

return system