--[[
    file:hntdhAlgor.lua 
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local mahjongAlogor = require("mahjong.algor")
---@class hntdhAlgor:mahjongAlogor @河南推倒胡
local hntdhAlgor = class(mahjongAlogor)

---构造函数
function hntdhAlgor:ctor()
end

return hntdhAlgor