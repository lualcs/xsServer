--[[
    file:gameLogic.lua 
    desc:游戏扑克
    auth:Caorl Luo
]]

local class = require("class")

---@class gameLogic @游戏逻辑
local logic = class()
local this = logic

---构造
---@param table gameCompetition @游戏桌子
function logic:ctor(table)
    self._table = table
end

---重启
function logic:dataReboot()
    ---游戏算法
    self._gor = self._table._gor
    ---游戏策略
    self._sys = self._table._sys
    ---类型判断
    self._tye = self._table._tye
    ---游戏辅助
    self._hlp = self._table._hlp
    ---游戏状态
    self._stu = self._table._stu
    ---游戏定时
    self._tim = self._table._tim
end

---桌子
---@return gameCompetition
function logic:getgame.competition()
    return self._table
end

---当前玩家
---@return slotsPlayer
function logic:getCurPlayer()
    return self._table:getCurPlayer()
end

---获取游戏信息
---@return gameInfo
function logic:getGameInfo()
    return self._table:getGameInfo()
end

---获取游戏配置
---@return table
function logic:getGameConf()
    return self._table:getGameConf()
end

return logic