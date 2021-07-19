--[[
    file:mahjongHelper.lua 
    desc:只做最简单的功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")
local gameHelper = require("game.helper")
---@class mahjongHelper:gameHelper @扑克辅助
local helper = class(gameHelper)
local this = helper

---构造函数
---@param mapNames table<cardPoker,name>
function helper:ctor(mapNames)
    self.mapNames = mapNames
end

---获取名字
---@param mjCard cardPoker @扑克牌值
---@return name
function helper:getName(mjCard)
    return self.mapNames[mjCard]
end

local names = {}
---获取名字
---@param cards cardPoker[] @扑克牌值
---@return name
function helper:getNames(cards)
    table.clear(names)
    for _,mjCard in ipairs(cards) do
        local name = self:getName(mjCard)
        table.insert(names,name)
    end
    return table.concat(names)
end

---获取整副牌
---@param infos mjFill[]
---@return mjCard[]
function helper.getCards(infos)
    local cards = {nil}
    for _,item in ipairs(infos) do
        for value=item.start,item.close do
            local mj = this.getCard(item.color,value)
            for i=1,item.again do
                table.insert(cards,mj)
            end
        end
    end
    return cards
end

---获取牌值
---@param mjCard mjCard @扑克
---@return mjValue
function helper.getValue(mjCard)
    return mjCard % 16
end

---获取花色
---@param mjCard mjCard @扑克
---@return mjColor
function helper.getColor(mjCard)
    return mjCard // 16
end

---获取麻将
---@param color mjColor   @花色
---@param value mjValue   @牌值
---@return mjColor
function helper.getCard(color,value)
    return color * 16 + value
end

---是否万
---@param mj mjCard
---@return boolean
function helper.isWang(mj)
    return mj and mj >= 0x01 and mj <= 0x09
end

---是否条
---@param mj mjCard
---@return boolean
function helper.isTiao(mj)
    return mj and mj >= 0x11 and mj <= 0x19
end

---是否筒
---@param mj mjCard
---@return boolean
function helper.isTong(mj)
    return mj and mj >= 0x21 and mj <= 0x29
end

---是否风
---@param mj mjCard
---@return boolean
function helper.isFeng(mj)
    return mj and mj >= 0x31 and mj <= 0x34
end

---是否箭
---@param mj mjCard
---@return boolean
function helper.isJian(mj)
    return mj and mj >= 0x35 and mj <= 0x37
end

---是否字
---@param mj mjCard
---@return boolean
function helper.isFont(mj)
    return mj and mj >= 0x31 and mj <= 0x37
end

---是否花
---@param mj mjCard
---@return boolean
function helper.isFlower(mj)
    return mj and mj >= 0x41 and mj <= 0x48
end

return helper