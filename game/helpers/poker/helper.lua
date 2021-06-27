--[[
    desc:扑克辅助
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")
local mapColors = require("poker.games.cx")
local mapNames  = require("poker.mapNames")
local gameHelper = require("game.helper")
---@class pokerHelper:gameHelper @扑克辅助
local helper = class(gameHelper)
local this = helper

---构造函数
function helper:ctor()
end

---获取名字
---@param card cardPoker @扑克牌值
---@return name
function helper.getName(card)
    return mapNames[card]
end

local copy1 = {nil}
---获取名字
---@param cards cardPoker[] @扑克牌值
---@return name
function helper.getNames(cards)
    local names = table.clear(copy1)
    for _,card in ipairs(cards) do
        local name = this.getName(card)
        table.insert(names,name)
    end
    return table.concat(names)
end

---获取牌值
---@param card pokerCard @扑克
---@return pokerValue
function helper.getValue(card)
    return (card & 0x0f)
end

---获取花色
---@param card pokerCard @扑克
---@return pokerColor
function helper.getColor(card)
    return mapColors[card]
end

---扑克牌值
---@param color cardColor @花色
---@param value cardValue @牌值
---@return cardPoker
function helper.makePoker(color,value)
    return (color<<4) + value
end

---比较牌值
---@param card cardPoker @花色
---@return number
function helper.getLogicValue(card)
    local value = this.getValue(card)
    if 1 == value then
        return 13
    end
    return value - 1
end

---是否方块
---@param card cardPoker @牌值
---@return boolean
function helper.ifDiamond(card)
    return 1 == this.getColor(card)
end

---是否梅花
---@param card cardPoker @牌值
---@return boolean
function helper.ifPlumBlossom(card)
    return 2 == this.getColor(card)
end

---是否红桃
---@param card cardPoker @牌值
---@return boolean
function helper.ifHearts(card)
    return 3 == this.getColor(card)
end

---是否黑桃
---@param card cardPoker @牌值
---@return boolean
function helper.ifSpade(card)
    return 4 == this.getColor(card)
end

---是否黑色
---@param card cardPoker @牌值
---@return boolean
function helper.ifBlackColor(card)
    local color = this.getColor(card)
    return 1 == color or 3 == color
end

---是否红色
---@param card cardPoker @牌值
---@return boolean
function helper.ifRedColor(card)
    local color = this.getColor(card)
    return 0 == color or 2 == color
end

---是否王牌
---@param card cardPoker @牌值
---@return boolean
function helper.ifKing(card)
    return 0x4e == card or 0x4f == card
end

---是否小王
---@param card cardPoker @牌值
---@return boolean
function helper.ifLittleKing(card)
    return 0x4e == card
end

---是否大王
---@param card cardPoker @牌值
---@return boolean
function helper.ifLargeKing(card)
    return 0x4f == card
end

return helper