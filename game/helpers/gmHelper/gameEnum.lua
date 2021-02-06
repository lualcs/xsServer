--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local mgrEnum = require("managerEnum")
local class = require("class")

---@class gameEnum:managerEnum @游戏枚举
local gameEnum = class(mgrEnum)
local this = gameEnum

---构造
function gameEnum:ctor()
end

---人数
---@return senum
function gameEnum.people()
    return "people"
end

---定时
---@return senum
function gameEnum.timer()
    return "timer"
end

---准备
---@return senum
function gameEnum.ready()
    return "ready"
end

---旁观
---@return senum
function gameEnum.lookon()
    return "lookon"
end

---私聊
---@return senum
function gameEnum.private()
    return "private"
end

---广播
---@return senum
function gameEnum.public()
    return "public"
end

---托管
---@return senum
function gameEnum.trustee()
    return "trustee"
end

---托管-取消
---@return senum
function gameEnum.not_trustee()
    return "no_trustee"
end

---超时
---@return senum
function gameEnum.timeout()
    return "timeout"
end

---旁观
---@return senum
function gameEnum.lookon()
    return "lookon"
end

---坐下
---@return senum
function gameEnum.sitdown()
    return "sitdown"
end

---起立
---@return senum
function gameEnum.standup()
    return "standup"
end

---离开
---@return senum
function gameEnum.leave()
    return "leave"
end

---踢出
---@return senum
function gameEnum.kickout()
    return "kickout"
end

---测试
---@return senum
function gameEnum.example()
    return "example"
end

---游戏 
---@return senum
function gameEnum.gamelis()
    return "gamelis"
end

---空闲
---@return senum
function gameEnum.idle()
    return "idle"
end

---游戏
---@return senum
function gameEnum.game()
    return "game"
end

---场景
---@return senum
function gameEnum.scene()
    return "scene"
end



---扣分
---@return senum
function gameEnum.deduct()
    return "deduct"
end

return gameEnum