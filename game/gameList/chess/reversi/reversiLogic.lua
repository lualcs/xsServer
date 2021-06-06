--[[
    desc:逻辑
    auth:Carol Luo
]]

local class = require("class")
local gameLogic = require("gameLogic")
---@class chessLogic:gameLogic @逻辑
local chessLogic = class(gameLogic)

---构造函数
function chessLogic:ctor()
end

return chessLogic