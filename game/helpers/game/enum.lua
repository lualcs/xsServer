--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local mgrEnum = require("managerEnum")
local class = require("class")

---@class gameEnum:managerEnum @游戏枚举
local enum = class(mgrEnum)
local this = enum

---构造
function enum:ctor()
end

---清除数据
function enum:dataClear()
end

---游戏单元
---@return senum
function enum.unit()
    return "unit"
end

---人数
---@return senum
function enum.people()
    return "people"
end

---准备
---@return senum
function enum.ready()
    return "ready"
end

---定时
---@return senum
function enum.timer()
    return "timer"
end

---百人
---@return senum
function enum.hundred()
    return "hundred"
end

---旁观
---@return senum
function enum.lookon()
    return "lookon"
end

---私聊
---@return senum
function enum.private()
    return "private"
end

---广播
---@return senum
function enum.public()
    return "public"
end

---托管
---@return senum
function enum.trustee()
    return "trustee"
end

---托管-取消
---@return senum
function enum.not_trustee()
    return "no_trustee"
end

---超时
---@return senum
function enum.timeout()
    return "timeout"
end

---旁观
---@return senum
function enum.lookon()
    return "lookon"
end

---坐下
---@return senum
function enum.sitdown()
    return "sitdown"
end

---起立
---@return senum
function enum.standup()
    return "standup"
end

---进入
---@return senum
function enum.enter()
    return "enter"
end


---离开
---@return senum
function enum.leave()
    return "leave"
end

---踢出
---@return senum
function enum.kickout()
    return "kickout"
end


---空闲
---@return senum
function enum.idle()
    return "idle"
end


---游戏
---@return senum
function enum.game()
    return "game"
end

---场景
---@return senum
function enum.scene()
    return "scene"
end


---扣分
---@return senum
function enum.deduct()
    return "deduct"
end

---庄
---@return senum
function enum.banker()
    return "banker"
end

---闲
---@return senum
function enum.player()
    return "player"
end

return enum