--[[
    file:scxzAlgor.lua 
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local mahjongAlogor = require("mahjongAlgor")
---@class scxzAlgor:mahjongAlogor @河南推倒胡
local scxzAlgor = class(mahjongAlogor)

---构造函数
function scxzAlgor:ctor()
end

return scxzAlgor