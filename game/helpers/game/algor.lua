--[[
    desc:游戏算法 
    auth:Carol Luo
]]

local sort = require("sort")
local table = require("extend_table")
local class = require("class")

---@class gameAlgor
local algor = class()
local this = algor

---构造函数
---@param table gameCompetition @游戏桌子
function algor:ctor(table)
    ---游戏桌子
    ---@type gameCompetition
    self._competition = table
end

---重启
function algor:dataReboot()
    ---游戏辅助
    self._hlp = self._competition._hlp
    ---游戏策略
    self._sys = self._competition._sys
    ---游戏类型
    self._tye = self._competition._tye
    ---游戏逻辑
    self._lgc = self._competition._lgc
    ---游戏状态
    self._stu = self._competition._stu
    ---游戏定时
    self._tim = self._competition._tim
    ---错误编码
    self._err = self._competition._err
    ---消息处理
    self._msg = self._competition._msg
end

---清除数据
function algor:dataClear()
end

---扑克比较
---@param aCard number
---@param bCard number
---@param fall  boolean     @是否降序
---@param self  gameAlgor   @对象引用
function algor.cardCompart(aCard,bCard,fall,self)
    local hlp = self._hlp
    return hlp:getLogicValue(aCard) > hlp:getLogicValue(bCard)
end
---排序
---@param hands number[] @牌列表
---@param fall  boolean  @是降序
function algor:cardSort(hands,fall)
    sort.quick(hands,self.cardCompart,1,#hands,fall,self)
end

return algor