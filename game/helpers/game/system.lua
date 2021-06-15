--[[
    file:gameSystem.lua 
    desc:策略
    auth:Carol Luo
]]

local class = require("class")

---@class gameSystem
local system = class()
local this = system

---构造函数
---@param table gameCompetition
function system:ctor(table)
    self._competition = table
end

---重启
function system:dataReboot()
    ---游戏算法
    self._gor = self._competition._gor
    ---游戏类型
    self._tye = self._competition._tye
    ---游戏辅助
    self._hlp = self._competition._hlp
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
function system:dataClear()
end

return system