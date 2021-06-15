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
    self._competition = table
end

---重启
function logic:dataReboot()
    ---游戏算法
    self._gor = self._competition._gor
    ---游戏策略
    self._sys = self._competition._sys
    ---类型判断
    self._tye = self._competition._tye
    ---游戏辅助
    self._hlp = self._competition._hlp
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
function logic:dataClear()
end

---桌子
---@return gameCompetition
function logic:getgame.competition()
    return self._competition
end

---当前玩家
---@return slotsPlayer
function logic:getCurPlayer()
    return self._competition:getCurPlayer()
end

---获取游戏信息
---@return gameInfo
function logic:getGameInfo()
    return self._competition:getGameInfo()
end

---获取游戏配置
---@return table
function logic:getGameConf()
    return self._competition:getGameConf()
end

return logic