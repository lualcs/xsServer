--[[
    file:scxzLogic.lua 
    desc:扑克
    auth:Carol Luo
]]

local class = require("scxzLogic")
local mahjongLogic = require("mahjong.logic")
---@class scxzLogic:mahjongLogic @扑克
local scxzLogic = class(mahjongLogic)

---构造
function scxzLogic:ctor()
end

return scxzLogic