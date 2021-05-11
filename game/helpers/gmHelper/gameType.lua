--[[
    file:gameType.lua 
    desc:类型 
    auth:Carol Luo
]]

local class = require("class")
---@class gameType @游戏类型
local gameType = class()

---构造
---@param table gameTable
function gameType:ctor(table)
    self._table = table
end

---重启
function gameType:dataReboot()
    ---游戏算法
    self._gor = self._table._gor
    ---游戏辅助
    self._hlp = self._table._hlp
    ---游戏策略
    self._sys = self._table._sys
    ---游戏逻辑
    self._lgc = self._table._lgc
    ---游戏状态
    self._stu = self._table._stu
    ---游戏定时
    self._tim = self._table._tim
end

return gameType