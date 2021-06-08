--[[
    file:游戏状态机
    auth:Carol Luo
]]

local os = require("extend_os")
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
    ---切换时间
    self._switchTimer = os.getmillisecond()
    ---总共时间
    self._statusTimer = nil
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
    self._tim:appendCall(0,function()
        self:switchGameProcess(status)
    end)
    ---记录时间
    self._statusTimer = os.getmillisecond()
    ---设置回调
    self._table._tim:appendCall(self:leftMilliscond(),function()
        self:clostGameStatus(status)
    end)
end

---获取剩余时间
---@return number @毫秒
function gameStatus:leftMilliscond()
    ---获取总共时间
    local statusTimer = self:totalMilliscond()
    ---获取当前时间
    local currentTimer = os.getmillisecond()
    ---获取切换时间
    local switchTimer = self._switchTimer

    return statusTimer - (currentTimer - switchTimer)
end

---获取总共时间
---@return number @毫秒
function gameStatus:totalMilliscond()
    local milliscond = self._statusTimer;
    if self._statusTimer then
        return milliscond
    end
end

---游戏流程切换
---@param status senum @游戏状态 
function gameStatus:switchGameProcess(status)
end


---游戏状态结束
---@param status senum @游戏状态 
function gameStatus:clostGameStatus(status)
end








return gameStatus