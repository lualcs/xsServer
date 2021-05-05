--[[
    desc:枚举
    auth:Carol Luo
]]

local class = require("class")
local gameEnum = require("gameEnum")
---@class hundredEnum:gameEnum
local hundredEnum = class(gameEnum)

---构造 
function hundredEnum:ctor()
end

---下注动作
---@return senum
function gameEnum.betting()
    return "betting"
end

---上庄状态
---@return senum
function gameEnum.statusUpBanker()
    return "statusUpBanker"
end

---下注状态
---@return senum 
function gameEnum.statusBet()
    return "statusBet"
end

return hundredEnum