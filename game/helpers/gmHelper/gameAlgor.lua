--[[
    file:gameAlgor.lua 
    desc:游戏算法 
    auth:Carol Luo
]]

local sort = require("sort")
local table = require("extend_table")
local class = require("class")

---@class gameAlgor
local gameAlgor = class()
local this = gameAlgor

---构造函数
---@param table gameTable @游戏桌子
function gameAlgor:ctor(table)
    ---游戏桌子
    ---@type gameTable
    self._table = table
end

---重启
function gameAlgor:dataReboot()
    self._hlp = self._table._hlp
    self._sys = self._table._sys
    self._tye = self._table._tye
    self._lgc = self._table._lgc
end

---扑克比较
---@param aCard number
---@param bCard number
---@param fall  boolean  @是降序
function gameAlgor.cardCompart(aCard,bCard,fall)
    local aValue = (aCard & 0xf0) >> 4
    local bValue = (bCard & 0xf0) >> 4

    local bFlag
    if aValue ~= bValue then
        bFlag = aValue > bValue
    else
        bFlag = aCard > bCard
    end
    if not fall then
        return bFlag
    else
        return not bFlag
    end
end
---排序
---@param hands number[] @牌列表
---@param fall  boolean  @是降序
function gameAlgor:cardSort(hands,fall)
    sort.sort(hands,self.cardCompart,1,#hands,fall)
end

return gameAlgor