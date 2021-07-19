--[[
    desc:类型判断 
    auth:Carol Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local pokerType = require("poker.type")
---@class dzType:pokerType
local type = class(pokerType)

---构造 
function type:ctor()
end

---同花顺
---@param hands pkCard[] @牌
---@return boolean
function type:isTongHuaShun(hands)
    return self:isTongHua(hands) and self:isShunZi()
end

---炸弹
---@param hands pkCard[] @牌
---@return boolean
function type:isZhaDan(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    ---德州算法
    ---@type dz_algor
    local algor = self._gor
    local method = algor:getLayout(cards)
    return not table.empty(method.tetrads)
end

---葫芦
---@param hands pkCard[] @牌
---@return boolean
function type:isHuLu(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    ---德州算法
    ---@type dz_algor
    local algor = self._gor
    local method = algor:getLayout(cards)
    local trips,doubles = method.triples,method.doubles
    return not table.empty(trips) and not table.empty(doubles)
end

---同花
---@param hands pkCard[] @牌
---@return boolean
function type:isTongHua(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    ---统计花色
    local colors = {}
    ---德州辅助
    ---@type dzHelper
    local hlp = self._hlp
    for _,card in ipairs(cards) do
        local color = hlp.getColor(card)
        local count = colors[colors] or 0 
        colors[colors] = count + 1
        if 4 == count then
            return true
        end
    end
    return false
end

---顺子
---@param hands pkCard[] @牌
---@return boolean
function type:isShunZi(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    table.sort(cards)
    ---德州辅助
    ---@type dzHelper
    local hlp = self._hlp
    local last = nil
    local szls = nil
    local cont = 0
    local list = {}
    for _,card in ipairs(cards) do
        if last then
            local value = hlp.getValue(card)
            if value - 1 == last then
                cont = cont + 1
                table.insert(list,value)
                szls = value
            elseif value ~= last then
                cont = 0
                table.clear(list)
            end
            last = value
        end
    end
    if cont >= 5 then
        return true
    end
    if 4 == cont then
        return 0x0d == szls and 0x01 == cards[1]
    end
    return false
end

---三条
---@param hands pkCard[] @牌
---@return boolean
function type:isSanTiao(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    ---德州算法
    ---@type dz_algor
    local algor  = self._gor
    local method = algor:getLayout(cards)
    local trips  = method.triples
    return not table.empty(trips)
end

---两对
---@param hands pkCard[] @牌
---@return boolean
function type:isLiangDui(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    ---德州算法
    ---@type dz_algor
    local algor  = self._gor
    local method = algor:getLayout(cards)
    local doubles  = method.doubles
    return table.arrElementtCount(doubles) >= 2
end

---对子
---@param hands pkCard[] @牌
---@return boolean
function type:isDuiZi(hands)
    ---德州桌子
    ---@type dzCompetition
    local game = self._competition
    local gongs = game:getGongPai()
    local cards = table.copy(gongs)
    table.push_list(cards,hands)
    ---德州算法
    ---@type dz_algor
    local algor  = self._gor
    local method = algor:getLayout(cards)
    local doubles  = method.doubles
    return not table.empty(doubles)
end

---高牌
---@param hands pkCard[] @牌
---@return boolean
function type:isGaoPai(hands)
    return true
end

return type