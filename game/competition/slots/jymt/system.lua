--[[
    desc:游戏操作
    auth:Carol Luo
]]

local class = require("class")
local slotsSystem = require("slots.System")
---@class jymtSystem:slotsSystem
local system = class(slotsSystem)
local this = system

---构造函数
function system:ctor()
end

return system