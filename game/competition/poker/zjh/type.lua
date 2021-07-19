--[[
    file:zjh_type.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local table = require("extend_table")
local pokerType = require("poker.type")
---@class zjhType:pokerType
local type = class(pokerType)

---构造 
function type:ctor()
end

---豹子
---@param hands pkCard[] @玩家手牌
---@return bool
function type:isBaoZi(hands)
    ---@type zjhAlgor @游戏算法
    local algor = self._gor
    local method = algor:getLayout(hands)
    return not table.empty(method.triples)
end

---同花顺
---@param hands pkCard[] @玩家手牌
---@return bool
function type:isTongHuaShun(hands)
    return self:isTongHua(hands) and self:isShunZi(hands)
end

---同花
---@param hands pkCard[] @玩家手牌
---@return bool
function type:isTongHua(hands)
    ---@type zjhHelper
    local h = self._hlp
    local a,b,c = h.getColor(hands[1]),h.getColor(hands[2]),h.getColor(hands[3])
    return a == b and b == c
end

---顺子
---@param hands pkCard[] @玩家手牌
---@return bool
function type:isShunZi(hands)
    ---@type zjhHelper
    local h = self._hlp
    local s = table.sort({h.getValue(hands[1]),h.getValue(hands[2]),h.getValue(hands[3])})
    local a,b,c = s[1],s[2],s[3]
    return (a+1==b and b+1==c)(1==a and b == 0x0c and c == 0x0d)
end

---对子
---@param hands pkCard[] @玩家手牌
---@return bool
function type:isDuiZi(hands)
    ---@type zjhHelper
    local h = self._hlp
    local a,b,c = h.getValue(hands[1]),h.getValue(hands[2]),h.getValue(hands[3])
    return a == b or a == c or b == c
end

---高牌
---@param hands pkCard[] @玩家手牌
---@return bool
function type:isGaoPai(hands)
   return true
end

return type