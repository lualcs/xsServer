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

---服务
---@return senum
function managerEnum.mapServices()
    return "mapServices"
end

---联盟
---@return senum
function managerEnum.alliance()
    return "alliance"
end

---代理
---@return senum
function managerEnum.agency()
    return "agency"
end

---成员
---@return senum
function managerEnum.member()
    return "member"
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

---心跳
---@return senum
function managerEnum.heartbeat()
    return "heartbeat"
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

---游客
---@return senum
function managerEnum.tourists()
    return "tourists"
end

---手机
---@return senum
function managerEnum.phone()
    return "phone"
end

---微信
---@return senum
function managerEnum.wechat()
    return "wechat"
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


---游客登录
---@return senum
function managerEnum.c2s_loginTourists()
    return "c2s_loginTourists"
end

---账号登录
---@return senum
function managerEnum.c2s_loginAccount()
    return "c2s_loginAccount"
end

---手机登录
---@return senum
function managerEnum.c2s_loginPhone()
    return "c2s_loginPhone"
end

---微信登陆
---@return senum
function managerEnum.c2s_loginWeChat()
    return "c2s_loginWeChat"
end

---登陆结果
---@return senum
function managerEnum.s2c_loginResult()
    return "s2c_loginResult"
end

---联盟信息
---@return senum
function managerEnum.s2c_allianceInfo()
    return "s2c_allianceInfo"
end

---代理信息
---@return senum
function managerEnum.s2c_agencyInfo()
    return "s2c_agencyInfo"
end

---联盟成员
---@return senum
function managerEnum.s2c_memberInfo()
    return "s2c_memberInfo"
end

---更改昵称
---@return senum
function managerEnum.c2s_changeNickname()
    return "c2s_changeNickname"
end

---更新头像
---@return senum
function managerEnum.c2s_changeLogolink()
    return "c2s_changeLogolink"
end

---联盟信息
---@return senum
function managerEnum.c2s_allianceBase()
    return "c2s_allianceBase"
end

---联盟信息
---@return senum
function managerEnum.s2c_allianceBase()
    return "s2c_allianceBase"
end

---联盟数据
---@return senum
function managerEnum.c2s_allianceClubs()
    return "c2s_allianceClubs"
end

---联盟数据
---@return senum
function managerEnum.s2c_allianceClubs()
    return "s2c_allianceClubs"
end

return managerEnum