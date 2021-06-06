--[[
    desc:桌子
    auth:Carol Luo
]]

local class = require("class")
local gameTable = require("gameTable")
---@class chessTable:gameTable @桌子
local chessTable = class(gameTable)

---构造函数
function chessTable:ctor()
end

return chessTable