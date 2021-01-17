--[[
    file:gameSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")

---@class gameSystem
local gameSystem = class()
local this = gameSystem

---构造函数
---@param table gameTable
function gameSystem:ctor(table)
    self._table = table
end

---重启
function gameSystem:dataReboot()
end

return gameSystem