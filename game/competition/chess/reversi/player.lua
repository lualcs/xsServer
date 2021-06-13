--[[
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("game.player")
---@class chessHelper:gamePlayer @玩家
local player = class(gamePlayer)

---构造函数
function player:ctor()
end

return player