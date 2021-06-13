--[[
    file:gameHelper.lua 
    desc:游戏辅助 
    auth:Caorl Luo
]]

local class = require("class")

---@class gameHelper
local helper = class()

---构造
---@param table gameCompetition @游戏桌子
function helper:ctor(table)
    ---游戏桌子
    ---@type gameCompetition
    self._table = table
end

---重启
function helper:dataReboot()
    ---游戏算法
    self._gor = self._table._gor
    ---游戏策略
    self._sys = self._table._sys
    ---类型判断
    self._tye = self._table._tye
    ---游戏逻辑
    self._lgc = self._table._lgc
    ---游戏状态
    self._stu = self._table._stu
    ---游戏定时
    self._tim = self._table._tim
end

---游戏配置 
---@return table
function helper:getGameConf()
    return self._table:getGameConf()
end

return helper