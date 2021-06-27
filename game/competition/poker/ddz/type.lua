--[[
    file:ddzType.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local table = require("extend_table")
local pokerType = require("poker.type")
---@class ddzType:pokerType
local type = class(pokerType)

---构造 
function type:ctor()
end

---获取牌型
---@param hands pkCard[] @手牌 
---@return senum
function type:getPokerType(hands)
    local len = #hands
end

---王炸
---@param  hands pkCard[] @手牌 
---@return boolean
function type:IfKingBomb(hands)
    if 2 ~= #hands then
        return false
    end

    if hands[0] == hands[1] then
        return false
    end

    ---@type pokerHelper
    local h = self._hlp
    if not h.ifKing(hands[0])then
        return false
    end

    if not h.ifKing(hands[1])then
        return false
    end

    return true
end

return type