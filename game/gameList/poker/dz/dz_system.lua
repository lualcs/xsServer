--[[
    file:dz_system.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local pokerSystem = require("pokerSystem")

---@class dz_system:pokerSystem
local dz_system = class(pokerSystem)
local this = dz_system


---构造
function dz_system:ctor()
end

return dz_system