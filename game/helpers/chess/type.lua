--[[
    desc:类型
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("game.type")
---@class chessType:gameType @桌子
local type = class(gameType)

---构造函数
function type:ctor()
end

return type