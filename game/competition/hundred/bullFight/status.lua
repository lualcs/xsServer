--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local hundredStatus = require("hundred.status")
local senum = require("dragonTiger.enum")
---@class dragonTigerStatus:hundredStatus @龙虎状态机
local status = class(hundredStatus)

---构造函数
function status:ctor()

end

---获取总共时间
---@return number @毫秒
function status:totalMilliscond()
    local status = self:getGameStatus()
    ---空闲状态
    if status == self:idle() then
        return self:idleTimer()
    ---开局状态
    elseif status == self:start() then
        return self:startTimer()
    ---下注状态
    elseif status == self:betting() then
        return self:bettingTimer()
    ---下注状态
    elseif status == self:close() then
        return self:closeTimer()
    end
end

---空闲时间
---@return integer
function status:idleTimer()
    return 1000
end

---开始时间
---@return integer
function status:startTimer()
    return 5000
end

---空闲时间
---@return integer
function status:bettingTimer()
    return 10000
end

---结束时间
---@return integer
function status:closeTimer()
    return 5000
end

return status