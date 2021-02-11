--[[
    file:cx_system.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local pokerSystem = require("pokerSystem")

---@class cx_system:pokerSystem
local cx_system = class(pokerSystem)
local this = cx_system


---构造
function cx_system:ctor()
end

return cx_system