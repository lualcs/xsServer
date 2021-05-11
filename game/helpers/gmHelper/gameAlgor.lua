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
    ---游戏辅助
    self._hlp = self._table._hlp
    ---游戏策略
    self._sys = self._table._sys
    ---游戏类型
    self._tye = self._table._tye
    ---游戏逻辑
    self._lgc = self._table._lgc
    ---游戏状态
    self._stu = self._table._stu
    ---游戏定时
    self._tim = self._table._tim
end

---扑克比较
---@param aCard number
---@param bCard number
---@param fall  boolean     @是否降序
---@param self  gameAlgor   @对象引用
function gameAlgor.cardCompart(aCard,bCard,fall,self)
    local hlp = self._hlp
    return hlp:getLogicValue(aCard) > hlp:getLogicValue(bCard)
end
---排序
---@param hands number[] @牌列表
---@param fall  boolean  @是降序
function gameAlgor:cardSort(hands,fall)
    sort.quick(hands,self.cardCompart,1,#hands,fall,self)
end

return gameAlgor