--[[
    file:pokerType.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("gameType")
---@class pokerType:gameType
local pokerType = class(gameType)

---构造函数
function pokerType:ctor()
end

---获取牌型
---@param hands pkCard[] @手牌 
---@return senum
function pokerType:getCardType(hands)
end

return pokerType