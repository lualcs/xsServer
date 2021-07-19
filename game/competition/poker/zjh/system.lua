--[[
    file:zjh_system.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local pokerSystem = require("poker.system")

---@class zjhSystem:pokerSystem
local statuys = class(pokerSystem)
local this = statuys


---构造
function statuys:ctor()
end

return statuys