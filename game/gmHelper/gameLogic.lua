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
---@param table gameTable
function gameLogic:ctor(table)
    self._table = table
end

---重启
function gameLogic:dataReboot()
    self._gor = self._table._gor
    self._sys = self._table._sys
    self._tye = self._table._tye
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