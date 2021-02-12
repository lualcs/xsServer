--[[
    file:gameLogic.lua 
    desc:游戏扑克
    auth:Caorl Luo
]]

local class = require("class")

---@class gameLogic @游戏逻辑
local gameLogic = class()
local this = gameLogic

---构造
---@param table gameTable @游戏桌子
function gameLogic:ctor(table)
    self._table = table
end

---重启
function gameLogic:dataReboot()
    ---游戏算法
    ---@type gameAlgor
    self._gor = self._table._gor
    ---游戏策略
    ---@type gameSystem
    self._sys = self._table._sys
    ---类型判断
    ---@type gameType
    self._tye = self._table._tye
    ---游戏辅助
    ---@type gameHelper
    self._hlp = self._table._hlp
end

---桌子
---@return gameTable
function gameLogic:getGameTable()
    return self._table
end

---当前玩家
---@return slotsPlayer
function gameLogic:getCurPlayer()
    return self._table:getCurPlayer()
end

---获取游戏信息
---@return gameInfo
function gameLogic:getGameInfo()
    return self._table:getGameInfo()
end

---获取游戏配置
---@return table
function gameLogic:getGameConf()
    return self._table:getGameConf()
end

return gameLogic