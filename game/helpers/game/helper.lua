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
    self._competition = table
end

---重启
function helper:dataReboot()
    ---游戏算法
    self._gor = self._competition._gor
    ---游戏策略
    self._sys = self._competition._sys
    ---类型判断
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
function helper:dataClear()
end

---游戏配置 
---@return table
function helper:getGameConf()
    return self._competition:getGameConf()
end

return helper