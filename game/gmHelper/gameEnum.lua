--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local class = require("class")

---@class gameEnum @游戏枚举
local gameEnum = class()
local this = gameEnum

---构造
function gameEnum:ctor()
end

---重启
function gameEnum:dataReboot()
end

---登陆消息
---@return senum
function gameEnum.msgLogin()
    return "msgLogin"
end

---大厅消息
---@return senum
function gameEnum.msgHall()
    return "msgHall"
end

---桌子消息
---@return senum
function gameEnum.msgTable()
    return "msgTable"
end

---玩家请求
---@return senum
function gameEnum.msgPlayer()
    return "msgPlayer"
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

---单人
---@return senum
function gameEnum.singlePlayer()
    return "singlePlayer"
end

---单人
---@return senum
function gameEnum.assignSingle()
    return "assignSingle"
end


---百人
---@return senum
function gameEnum.assignHundred()
    return "assignHundred"
end


---竞技
---@return senum
function gameEnum.assignKilling()
    return "assignKilling"
end

---离线
---@return senum
function gameEnum.offline()
    return "offline"
end

---在线
---@return senum
function gameEnum.online()
    return "online"
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

---邀请
---@return senum
function gameEnum.invite()
    return "invite"
end

---聊天
---@return senum
function gameEnum.chat()
    return "chat"
end

---创建
---@return senum
function gameEnum.create()
    return "create"
end

---删除
---@return senum
function gameEnum.delete()
    return "delete"
end

---桌子
---@return senum
function gameEnum.table()
    return "table"
end

return gameEnum