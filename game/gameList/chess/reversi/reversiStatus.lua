--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local gameStatus = require("gameStatus")
---@class chessStatus:gameStatus
local chessStatus = class(gameStatus)

---构造 
function chessStatus:ctor()
end

return chessStatus