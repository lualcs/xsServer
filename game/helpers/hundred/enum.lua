--[[
    desc:枚举
    auth:Carol Luo
]]

local class = require("class")
local gameEnum = require("game.enum")
---@class hundredEnum:gameEnum
local enum = class(gameEnum)

---构造 
function enum:ctor()
end

---游戏开始
---@return senum 
function enum.gameStart()
    return "gameStart"
end

---游戏下注
---@return senum 
function enum.gameBetting()
    return "gameBetting"
end

---游戏结算
---@return senum 
function enum.gameSettle()
    return "gameBetting"
end

return enum