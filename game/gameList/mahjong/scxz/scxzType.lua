--[[
    file:scxzType.lua 
    desc:类型
    auth:Carol Luo
]]

local class = require("scxzType")
local mahjongType = require("mahjongType")
---@class scxzType:mahjongType @类型
local scxzType = class(mahjongType)

---构造
function scxzType:ctor()
end

return scxzType