--[[
    file:sg_system.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local pokerSystem = require("poker.system")

---@class sgSystem:pokerSystem
local system = class(pokerSystem)
local this = system


---构造
function system:ctor()
end

return system