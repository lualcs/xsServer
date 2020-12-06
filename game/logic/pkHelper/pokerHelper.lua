--[[
    file:pokerHelper.lua 
    desc:只做最简单的功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")

---@class pokerHelper @扑克辅助
local pokerHelper = class()

---构造函数
---@param mapNames table<cardPoker,name>
function pokerHelper:ctor(mapNames)
    self.mapNames = mapNames
end

---获取名字
---@param card cardPoker @扑克牌值
---@return name
function pokerHelper:getName(card)
    return self.mapNames[card]
end

local names = {}
---获取名字
---@param cards cardPoker[] @扑克牌值
---@return name
function pokerHelper:getNames(cards)
    table.clear(names)
    for _,card in ipairs(cards) do
        local name = self:getName(card)
        table.insert(names,name)
    end
    return table.concat(names)
end

---获取牌值
---@param card pokerCard @扑克
---@return pokerValue
function pokerHelper:getValue(card)
    return (card & 0x0f)
end

---获取花色
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper:getColor(card)
    return (card & 0xf0) >> 4
end

---扑克牌值
---@param color cardColor @花色
---@param value cardValue @牌值
---@return cardPoker
function pokerHelper:getCardPoker(color,value)
    return (color<<4) + value
end

---是否方块
---@param card cardPoker @牌值
---@return boolean
function pokerHelper:is_fk(card)
    return 1 == self:getColor(card)
end

---是否梅花
---@param card cardPoker @牌值
---@return boolean
function pokerHelper:is_fk(card)
    return 2 == self:getColor(card)
end

---是否红桃
---@param card cardPoker @牌值
---@return boolean
function pokerHelper:is_fk(card)
    return 3 == self:getColor(card)
end

---是否黑桃
---@param card cardPoker @牌值
---@return boolean
function pokerHelper:is_fk(card)
    return 4 == self:getColor(card)
end

return pokerHelper