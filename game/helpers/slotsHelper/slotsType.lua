--[[
    file:slotsType.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("gameType")
---@class slotsType:gameType
local slotsType = class(gameType)

---构造 
function slotsType:ctor()
end

return slotsType