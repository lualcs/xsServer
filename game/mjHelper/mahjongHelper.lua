--[[
    file:mahjongHelper.lua 
    desc:只做最简单的功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")

---@class mahjongHelper @扑克辅助
local mahjongHelper = class()

---构造函数
---@param mapNames table<cardPoker,name>
function mahjongHelper:ctor(mapNames)
    self.mapNames = mapNames
end

---获取名字
---@param mjCard cardPoker @扑克牌值
---@return name
function mahjongHelper:getName(mjCard)
    return self.mapNames[mjCard]
end

local names = {}
---获取名字
---@param cards cardPoker[] @扑克牌值
---@return name
function mahjongHelper:getNames(cards)
    table.clear(names)
    for _,mjCard in ipairs(cards) do
        local name = self:getName(mjCard)
        table.insert(names,name)
    end
    return table.concat(names)
end

---获取牌值
---@param mjCard mjCard @扑克
---@return pokerValue
function mahjongHelper:getValue(mjCard)
    return (mjCard & 0x0f)
end

---获取花色
---@param mjCard mjCard @扑克
---@return pokerColor
function mahjongHelper:getColor(mjCard)
    return (mjCard & 0xf0) >> 4
end

---扑克牌值
---@param color cardColor @花色
---@param value cardValue @牌值
---@return cardPoker
function mahjongHelper:getCardPoker(color,value)
    return (color<<4) + value
end

---是否方块
---@param mjCard cardPoker @牌值
---@return boolean
function mahjongHelper:is_fangKuai(mjCard)
    return 1 == self:getColor(mjCard)
end

---是否梅花
---@param mjCard cardPoker @牌值
---@return boolean
function mahjongHelper:is_meiHua(mjCard)
    return 2 == self:getColor(mjCard)
end

---是否红桃
---@param mjCard cardPoker @牌值
---@return boolean
function mahjongHelper:is_hongTao(mjCard)
    return 3 == self:getColor(mjCard)
end

---是否黑桃
---@param mjCard cardPoker @牌值
---@return boolean
function mahjongHelper:is_heiTao(mjCard)
    return 4 == self:getColor(mjCard)
end

---是否黑色
---@param mjCard cardPoker @牌值
---@return boolean
function mahjongHelper:is_black(mjCard)
    local color = self:getColor(mjCard)
    return 1 == color or 3 == color
end

---是否红色
---@param mjCard cardPoker @牌值
---@return boolean
function mahjongHelper:is_red(mjCard)
    local color = self:getColor(mjCard)
    return 0 == color or 2 == color
end

return mahjongHelper