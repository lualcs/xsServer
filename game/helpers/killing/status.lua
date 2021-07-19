--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local skynet = require("skynet")
local debug = require("extend_debug")
local senum = require("hundred.enum")
local gameStatus = require("game.status")
---@class killingStatus:gameStatus @状态机
local status = class(gameStatus)
local this = status

---构造函数 
function status:ctor()
end

---重置数据
function status:dataReboot()
    ---重置处理
    self:super(this,"dataReboot")
    ---开启流程
    self:setGameStatus(self:idle())
end

---游戏流程切换
---@param status senum @游戏状态 
function status:enterGameProcess(status)
    self:super(this,"enterGameProcess",status)
    ---空闲状态
    if status == self:idle() then
        self:enterIdle()
    ---开局状态
    elseif status == self:start() then
        self:enterStart()
    ---下注状态
    elseif status == self:betting() then
        self:enterBetting()
    ---结束状态
    elseif status == self:close() then
        self:enterClose()
    end
end

---状态结束切换
---@param status senum @游戏状态 
function status:leaveGameProcess(status)
    self:super(this,"leaveGameProcess",status)
    ---空闲状态
    if status == self:idle() then
        self:leaveIdle()
    ---开局状态
    elseif status == self:start() then
        self:leaveStart()
    ---下注状态
    elseif status == self:betting() then
        self:leaveBetting()
    ---结束状态
    elseif status == self:close() then
        self:leaveClose()
    end
end


----------------------------------------------------空闲状态--------------------------------------------------

---空闲状态
---@return senum
function status:idle()
    return "idle"
end

---是否空闲
---@return senum
function status:ifIdle()
    return self:idle() == self:getGameStatus()
end

---设置空闲
---@return senum
function status:setIdle()
    self:setGameStatus(self:idle())
end

---进入空闲
function status:enterIdle()
    ---@type hundredCompetition
    self._competition:gameIdle()
end

---离开空闲
function status:leaveIdle()
    if self._competition:checkStart() then
        self:setGameStatus(self:start())
    else
        self:setGameStatus(self:idle())
    end
end

------------------------------------------------------开局状态------------------------------------------------

---开局状态
---@return senum
function status:start()
    return "start"
end

---开局状态
---@return senum
function status:ifStart()
    return self:start() == self:getGameStatus()
end

---开局状态
---@return senum
function status:setStart()
    self:setGameStatus(self:start())
end

---进入开局
function status:enterStart()
    self._competition:gameStart()
end

---离开开局
function status:leaveStart()
    self:setGameStatus(self:betting())
end

------------------------------------------------------下注状态------------------------------------------------

---下注状态
---@return senum
function status:betting()
    return "betting"
end

---是否下注
---@return senum
function status:ifBetting()
    return self:betting() == self:getGameStatus()
end

---设置下注
---@return senum
function status:setBetting()
    self:setGameStatus(self:betting())
end

---进入下注
function status:enterBetting()
    self._competition:gameBetting()
    self._sys:robotStrategy()
    self._sys:robotBetting()
end

---离开下注
function status:leaveBetting()
    self:enterGameProcess(self:close())
end

------------------------------------------------------结束状态------------------------------------------------

---开局状态
---@return senum
function status:close()
    return "close"
end

---是否结束
---@return senum
function status:ifClose()
    return self:close() == self:getGameStatus()
end

---设置结束
---@return senum
function status:setClose()
    self:setGameStatus(self:close())
end

---进入结束
function status:enterClose()
    self._competition:gameClose()
end

---离开下注
function status:leaveClose()
    self:enterGameProcess(self:idle())
end



return status