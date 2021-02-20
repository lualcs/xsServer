--[[
    file:scxzSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("scxzSystem")
local mahjongSystem = require("mahjongSystem")
---@class scxzSystem:mahjongSystem @策略
local scxzSystem = class(mahjongSystem)

---构造
function scxzSystem:ctor()
end

return scxzSystem