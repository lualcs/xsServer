--[[
    file:游戏状态机
    auth:Carol Luo
]]

local class = require("class")
local senum = require("gameEnum")
---@class gameStatus @游戏状态机
local gameStatus = class()

---构造
---@param table gameTable @游戏桌子
function gameStatus:ctor(table)
    ---游戏桌子
    ---@type gameTable
    self._table = table
end

---重启
function gameStatus:dataReboot()
    ---游戏算法
    self._gor = self._table._gor
    ---游戏策略
    self._sys = self._table._sys
    ---类型判断
    self._tye = self._table._tye
    ---游戏逻辑
    self._lgc = self._table._lgc
    ---游戏辅助
    self._hlp = self._table._hlp
    ---游戏定时
    self._tim = self._table._tim
end

---游戏状态跳转
function gameStatus:jumpGameStatus()
    local status = self._table:getGameStatus()
    local timer = self._t
end

return gameStatus