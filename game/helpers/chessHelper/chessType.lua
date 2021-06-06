--[[
    desc:类型
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("gameType")
---@class chessType:gameType @桌子
local chessType = class(gameType)

---构造函数
function chessType:ctor()
end

return chessType