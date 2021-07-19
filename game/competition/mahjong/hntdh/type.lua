--[[
    file:hntdhType.lua 
    desc:类型
    auth:Carol Luo
]]

local class = require("hntdhType")
local mahjongType = require("mahjong.type")
---@class hntdhType:mahjongType @类型
local hntdhType = class(mahjongType)

---构造
function hntdhType:ctor()
end

return hntdhType