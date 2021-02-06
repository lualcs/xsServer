--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local class = require("class")

---@class managerEnum @游戏枚举
local managerEnum = class()
local this = managerEnum

---构造
function managerEnum:ctor()
end


---重启
function managerEnum:dataReboot()
end

---同意
---@return senum
function managerEnum.agree()
    return "agree"
end

---拒绝
---@return senum
function managerEnum.refuse()
    return "refuse"
end


---单人
---@return senum
function managerEnum.assignSingle()
    return "assignSingle"
end


---百人
---@return senum
function managerEnum.assignHundred()
    return "assignHundred"
end


---竞技
---@return senum
function managerEnum.assignKilling()
    return "assignKilling"
end

---错误消息
---@return senum
function managerEnum.error()
    return "error"
end

---成功
---@return senum
function managerEnum.succeed()
    return "succeed"
end

---登陆消息
---@return senum
function managerEnum.login()
    return "login"
end

---大厅消息
---@return senum
function managerEnum.lobby()
    return "lobby"
end

---桌子消息
---@return senum
function managerEnum.table()
    return "table"
end

---离线
---@return senum
function managerEnum.offline()
    return "offline"
end

---在线
---@return senum
function managerEnum.online()
    return "online"
end

---邀请
---@return senum
function managerEnum.invite()
    return "invite"
end

---聊天
---@return senum
function managerEnum.chat()
    return "chat"
end

---桌子
---@return senum
function managerEnum.table()
    return "table"
end

---参与
---@return senum
function managerEnum.join()
    return "join"
end

---手机
---@return senum
function managerEnum.phone()
    return "phone"
end

---创建
---@return senum
function managerEnum.create()
    return "create"
end

---删除
---@return senum
function managerEnum.delete()
    return "delete"
end

return managerEnum