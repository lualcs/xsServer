--[[
    file:slotsPlayer.lua 
    desc:slots玩家
    auth:Caorl Luo
]]


local class = require("class")
local gamePlayer = require("gamePlayer")

---@class slotsPlayer:gamePlayer @slotsPlayer基类
local slotsPlayer = class(gamePlayer)
local this = slotsPlayer

---构造
function slotsPlayer:ctor()
end

---重启
function slotsPlayer:dataReboot()
    self:super(this,"dataReboot")
    ---@type count                  剩余免费次数
    self._freeCount  = 0 
    ---@type slots_result_normal    上次结果(正常-免费-重转)
    self._lastResult = nil
    ---@type slots_result_normal    上次结果(正常)
    self._lastNormal = nil
    ---@type slots_result_normal    上次结果(免费)
    self._lastFree   = nil
    ---@type slots_result_normal    上次结果(重转)
    self._lastRoller = nil
end

---获取下注请求
---@return slots_jetton
function slotsPlayer:getJetton()
    local msg = self:getRequest()
    local idx = msg.details
    ---@type slots_cfg
    local cfg = self._table:getGameConf()
    return cfg.jetton_pair[idx]
end

---获取单线下注
---@return slots_scope
function slotsPlayer:getLineBet()
    local jetton = self:getJetton()
    return jetton.single
end

---获取免费次数
---@return count
function slotsPlayer:getFreeCount()
    return self._freeCount
end

---设置免费次数
---@param count count @次数
function slotsPlayer:setFreeCount(count)
    self._freeCount = count
end

---增加免费次数
---@param count count @次数
function slotsPlayer:addFreeCount(count)
    self._freeCount = self._freeCount + count
end

---设置上次结果
---@param result slots_result_normal
function slotsPlayer:setLastResult(result)
    self._lastResult = result
    ---设置免费次数
    self:addFreeCount(result.free_push)
    ---修改游戏分数
    self:addCoin(result.gain_coin)
end

---获取上次结果
---@return slots_result_normal
function slotsPlayer:getLastResult()
    return self._lastResult
end

---设置正常结果
---@param result slots_result_normal
function slotsPlayer:setLastNormal(result)
    self:setLastResult(result)
    self._lastNormal = result
end

---获取正常结果
---@return slots_result_normal
function slotsPlayer:getLastNormal()
    return self._lastNormal
end

---设置免费结果
---@param result slots_result_normal
function slotsPlayer:setLastFree(result)
    self:setLastResult(result)
    self._lastFree = result
end

---获取免费结果
---@return slots_result_normal
function slotsPlayer:getLastFree()
    return self._lastFree
end

---设置重转结果
---@param result slots_result_normal
function slotsPlayer:setLastRoller(result)
    self:setLastResult(result)
    self._lastRoller = result
end

---获取重转结果
---@return slots_result_normal
function slotsPlayer:getLastRoller()
    return self._lastRoller
end


return slotsPlayer