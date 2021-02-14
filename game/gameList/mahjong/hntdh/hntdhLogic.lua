--[[
    file:hntdhLogic.lua 
    desc:扑克
    auth:Carol Luo
]]

local class = require("hntdhLogic")
local mahjongLogic = require("mahjongLogic")
---@class hntdhLogic:mahjongLogic @扑克
local hntdhLogic = class(mahjongLogic)

---构造
function hntdhLogic:ctor()
end

return hntdhLogic