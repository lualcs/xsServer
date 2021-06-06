--[[
    desc:桌子
    auth:Carol Luo
]]

local class = require("class")
local chessTable = require("chessTable")
---@class fiveTable:gameTable @桌子
local fiveTable = class(chessTable)

---构造函数
function fiveTable:ctor()
end

return fiveTable