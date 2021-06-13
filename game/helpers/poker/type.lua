--[[
    file:pokerType.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("game.type")
---@class pokerType:gameType
local type = class(gameType)

---构造函数
function type:ctor()
end

---获取牌型
---@param hands pkCard[] @手牌 
---@return senum
function type:getCardType(hands)
end

return type