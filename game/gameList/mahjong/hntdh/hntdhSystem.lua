--[[
    file:hntdhSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("hntdhSystem")
local mahjongSystem = require("mahjongSystem")
---@class hntdhSystem:mahjongSystem @策略
local hntdhSystem = class(mahjongSystem)

---构造
function hntdhSystem:ctor()
end

return hntdhSystem