--[[
    file:sg_system.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local pokerSystem = require("pokerSystem")

---@class sg_system:pokerSystem
local sg_system = class(pokerSystem)
local this = sg_system


---构造
function sg_system:ctor()
end

return sg_system