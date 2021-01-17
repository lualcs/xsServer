--[[
    file:mahjongLogic.lua 
    desc:麻将逻辑
    auth:Carol Luo
]]

local class = require("class")
local gameTable = require("gameTable")
---@class mahjongTable:gameTable @麻将桌子
local mahjongTable = class(gameTable)

--构造函数
function mahjongTable:ctor()
end


return mahjongTable