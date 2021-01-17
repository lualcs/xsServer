--[[
    file:mahjongHelper.lua 
    desc:只做最简单的功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")
local gameHelper = require("gameHelper")
---@class mahjongHelper @扑克辅助
local mahjongHelper = class(gameHelper)
local this = mahjongHelper

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

---获取整副牌
---@param infos mjFill[]
---@return mjCard[]
function mahjongHelper.getCards(infos)
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
function mahjongHelper.getValue(mjCard)
    return mjCard % 16
end

---获取花色
---@param mjCard mjCard @扑克
---@return mjColor
function mahjongHelper.getColor(mjCard)
    return mjCard // 16
end

---获取麻将
---@param color mjColor   @花色
---@param value mjValue   @牌值
---@return mjColor
function mahjongHelper.getCard(color,value)
    return color * 16 + value
end

---是否万
---@param mj mjCard
---@return boolean
function mahjongHelper.isWang(mj)
    return mj and mj >= 0x01 and mj <= 0x09
end

---是否条
---@param mj mjCard
---@return boolean
function mahjongHelper.isTiao(mj)
    return mj and mj >= 0x11 and mj <= 0x19
end

---是否筒
---@param mj mjCard
---@return boolean
function mahjongHelper.isTong(mj)
    return mj and mj >= 0x21 and mj <= 0x29
end

---是否风
---@param mj mjCard
---@return boolean
function mahjongHelper.isFeng(mj)
    return mj and mj >= 0x31 and mj <= 0x34
end

---是否箭
---@param mj mjCard
---@return boolean
function mahjongHelper.isJian(mj)
    return mj and mj >= 0x35 and mj <= 0x37
end

---是否字
---@param mj mjCard
---@return boolean
function mahjongHelper.isFont(mj)
    return mj and mj >= 0x31 and mj <= 0x37
end

---是否花
---@param mj mjCard
---@return boolean
function mahjongHelper.isFlower(mj)
    return mj and mj >= 0x41 and mj <= 0x48
end

return mahjongHelper