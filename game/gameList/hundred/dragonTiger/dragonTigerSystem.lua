--[[
    file:jjbx_system.lua 
    desc:游戏操作
    auth:Carol Luo
]]

local class = require("class")
local hundredSystem = require("hundredSystem")
---@class dragonTigerSystem:hundredSystem
local dragonTigerSystem = class(hundredSystem)
local this = dragonTigerSystem

---构造函数
function dragonTigerSystem:ctor()
end

return dragonTigerSystem