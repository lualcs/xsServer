--[[
    file:gameSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")

---@class gameSystem
local gameSystem = class()
local this = gameSystem

---构造函数
---@param table gameTable
function gameSystem:ctor(table)
    self._table = table
end

---重启
function gameSystem:dataReboot()
    ---游戏算法
    self._gor = self._table._gor
    ---游戏类型
    self._tye = self._table._tye
    ---游戏辅助
    self._hlp = self._table._hlp
    ---游戏逻辑
    self._lgc = self._table._lgc
    ---游戏状态
    self._stu = self._table._stu
end

return gameSystem