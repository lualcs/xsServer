--[[
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("gamePlayer")
---@class chessHelper:gamePlayer @玩家
local chessPlayer = class(gamePlayer)

---构造函数
function chessPlayer:ctor()
end

return chessPlayer