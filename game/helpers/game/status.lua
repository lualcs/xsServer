--[[
    file:游戏状态机
    auth:Carol Luo
]]

local os = require("extend_os")
local class = require("class")
local senum = require("game.enum")
---@class gameStatus @游戏状态机
local status = class()

---构造
---@param table gameCompetition @游戏桌子
function status:ctor(table)
    ---游戏桌子
    ---@type gameCompetition
    self._competition = table
    ---切换时间
    self._switchTimer = os.getmillisecond()
    ---总共时间
    self._statusTimer = nil
end

---重启
function status:dataReboot()
    ---游戏算法
    self._gor = self._competition._gor
    ---游戏策略
    self._sys = self._competition._sys
    ---类型判断
    self._tye = self._competition._tye
    ---游戏逻辑
    self._lgc = self._competition._lgc
    ---游戏辅助
    self._hlp = self._competition._hlp
    ---游戏定时
    self._tim = self._competition._tim
    ---错误编码
    self._err = self._competition._err
    ---消息处理
    self._msg = self._competition._msg
end

---清除数据
function status:dataClear()
end

---设置游戏状态
---@param status senum @游戏状态
function status:settingStatus(status)
    self._competition:setGameStatus(status)
end

---获取游戏状态
---@param status senum @游戏状态
function status:gettingStatus(status)
    return self._competition:getGameStatus(status)
end

---游戏状态跳转
function status:jumpGameStatus()
    local status = self._competition:getGameStatus()
    self._tim:appendCall(0,function()
        self:enterGameProcess(status)
    end)
    ---记录时间
    self._statusTimer = os.getmillisecond()
end

---获取剩余时间
---@return number @毫秒
function status:leftMilliscond()
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
function status:totalMilliscond()
    
end

---游戏流程切换
---@param status senum @游戏状态 
function status:enterGameProcess(status)
end

---状态结束切换
---@param status senum @游戏状态 
function status:leaveGameProcess(status)
end


return status