--[[
    file:slotsType.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("game.type")
---@class slotsType:gameType
local type = class(gameType)

---构造 
function type:ctor()
end

return type