--[[
    file:jjbx_system.lua 
    desc:游戏操作
    auth:Carol Luo
]]

local class = require("class")
local slotsSystem = require("slotsSystem")
---@class jjbxSystem:slotsSystem @策略
local jjbxSystem = class(slotsSystem)
local this = jjbxSystem

---构造函数
function jjbxSystem:ctor()
end

return jjbxSystem