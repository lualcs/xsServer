--[[
    file:gameHelper.lua 
    desc:游戏辅助 
    auth:Caorl Luo
]]

local class = require("class")

---@class gameHelper
local gameHelper = class()

---构造
---@param table gameTable @游戏桌子
function gameHelper:ctor(table)
    ---游戏桌子
    ---@type gameTable
    self._table = table
end

---重启
function gameHelper:dataReboot()
    ---游戏算法
    ---@type gameAlgor
    self._gor = self._table._gor
    ---游戏策略
    ---@type gameSystem
    self._sys = self._table._sys
    ---类型判断
    ---@type gameType
    self._tye = self._table._tye
    ---游戏逻辑
    ---@type gameLogic
    self._lgc = self._table._lgc
end

---游戏配置 
---@return table
function gameHelper:getGameConf()
    return self._table:getGameConf()
end

return gameHelper