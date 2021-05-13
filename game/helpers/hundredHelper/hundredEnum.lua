--[[
    desc:枚举
    auth:Carol Luo
]]

local class = require("class")
local gameEnum = require("gameEnum")
---@class hundredEnum:gameEnum
local hundredEnum = class(gameEnum)

---构造 
function hundredEnum:ctor()
end

---游戏开始
---@return senum 
function hundredEnum.gameStart()
    return "gameStart"
end

---游戏下注
---@return senum 
function hundredEnum.gameBetting()
    return "gameBetting"
end

---游戏结算
---@return senum 
function hundredEnum.gameSettle()
    return "gameBetting"
end

return hundredEnum