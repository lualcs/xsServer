--[[
    file:gameType.lua 
    desc:类型 
    auth:Carol Luo
]]

local class = require("class")
---@class gameType @游戏类型
local type = class()

---构造
---@param table gameCompetition
function type:ctor(table)
    self._competition = table
end

---重启
function type:dataReboot()
    ---游戏算法
    self._gor = self._competition._gor
    ---游戏辅助
    self._hlp = self._competition._hlp
    ---游戏策略
    self._sys = self._competition._sys
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
function type:dataClear()
end

return type