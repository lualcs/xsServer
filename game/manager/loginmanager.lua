--[[
    file:loginmanager.lua 
    desc:gate消息处理
    auth:Caorl Luo
]]

local table = require("extend_table")
local debug = require("extend_debug")
local websocket = require("api_websocket")
local skynet = require("skynet")
local class = require("class")
local senum = require("managerEnum")

---@class loginmanager @gate管理
local loginmanager = class()
local this = loginmanager

---构造
---@param login service_login         @gate服务
function loginmanager:ctor(service)
    ---服务
    ---@type service_login
    self._login = service
    ---@type table<fd,client>
    ---连接
    self._sockets = {nil}
    ---@type table<rid,client>
    ---连接
    self._clients = {nil}
end

---重置
function loginmanager:dataReboot()
  
end

---断线
---@param fd scoket @套接字
function loginmanager:offline(fd)
    local client = self._sockets[fd]
    client.online = false
end

---服务
---@return serviceInf @服务信息
function loginmanager:getServices()
    return self._login.services
end

---请求
---@param fd  socket      @套接字
---@param msg messabeBody @数据
function loginmanager:message(fd,msg)
    local cmd = table.remove(msg.cmds)
    local svs = self:getServices()
    if senum.c2s_loginTourists() == cmd then
        --游客登录
        self:touristsLogin(fd,msg)
        skynet.retpack(self._sockets[fd])
    elseif senum.c2s_loginPhone() == cmd then
        --手机登陆
        self:phoneLogin(fd,msg)
        skynet.retpack(self._sockets[fd])
    elseif senum.c2s_loginWeChat() == cmd then
        --微信登陆
        self:phoneLogin(fd,msg)
        skynet.retpack(self._sockets[fd])
    end
end

---重复登录
---@param fd scoket   @套接字
function loginmanager:socketLogin(fd)
    local client = self._sockets[fd]
    if client then
        return false
    end
    return true
end

---保存登录
---@param fd    scoket             @套接字
---@param role  s2c_loginResult    @登录结果
function loginmanager:cacheLogin(fd,role)
    local client = {
        fd = fd,
        role = role,
        online = true,
    }
    self._sockets[fd] = role
    self._clients[role.rid] = role
    ---通知skyneg
    return true
end

---游客登陆
---@param fd    socket              @套接字
---@param msg   c2s_loginTourists   @消息
function loginmanager:touristsLogin(fd,msg)
    ---重复登录
    if self:socketLogin(fd) then
        return
    end

    ---服务信息
    ---@type serviceInf
    local services = self._login.services
    ---游客凭证
    ---@type string 
    local accredit = msg.accredit;
    ---登陆结果
    ---@type s2c_loginResult
    local login = skynet.call(services.mysql,"lua","touristsLogin",accredit)
    if not login.failure then
        ---登录模式
        login.loginMod = senum.tourists()
        login.loginBid = msg.accredit
        ---返回结果
        websocket.sendpbc(fd,senum.s2c_loginResult(),{senum.login(),senum.succeed()},login)
        ---保存结果
        self:cacheLogin(fd,login)
    end
    skynet.retpack(login)
end

---手机登陆
---@param fd    socket              @套接字
---@param msg   c2s_loginPhone      @消息
function loginmanager:phoneLogin(fd,msg)
    ---重复登录
    if self:socketLogin(fd) then
        return
    end

    ---服务信息
    ---@type serviceInf
    local services = self._login.services
    ---手机号码
    ---@type string 
    local phonenum = msg.phonenum;
    ---登录密码
    ---@type string 
    local password = msg.password;
    ---登陆结果
    ---@type s2c_loginResult
    local login = skynet.call(services.mysql,"lua","phoneLogin",phonenum,password)
    if not login.failure then
        ---登录模式
        login.loginMod = senum.tourists()
        login.loginBid = msg.phonenum
        ---返回结果
        websocket.sendpbc(fd,senum.s2c_loginResult(),{senum.login(),senum.succeed()},login)
        ---保存结果
        self:cacheLogin(fd,login)
    end
    skynet.retpack(login)
end

---微信登陆
---@param fd    socket              @套接字
---@param msg   c2s_loginWeChat      @消息
function loginmanager:wechatLogin(fd,msg)
    ---重复登录
    if self:socketLogin(fd) then
        return
    end

    ---服务信息
    ---@type serviceInf
    local services = self._login.services
    ---微信授权
    ---@type string 
    local accredit = msg.accredit;
    ---登陆结果
    ---@type s2c_loginResult
    local login = skynet.call(services.mysql,"lua","wechatLogin",accredit)
    if not login.failure then
        ---登录模式
        login.loginMod = senum.wechat()
        login.loginBid = msg.phonenum
        ---返回结果
        websocket.sendpbc(fd,senum.s2c_loginResult(),{senum.login(),senum.succeed()},login)
        ---保存结果
        self:cacheLogin(fd,login)
    end
    skynet.retpack(login)
end

---更新昵称
---@param fd    socket              @套接字
---@param msg   c2s_changeNickname  @消息
function loginmanager:changeNickname(fd,msg)
    ---用户数据
    local client = self._sockets[fd]
    if not client then
        return
    end

    ---服务信息
    ---@type serviceInf
    local services = self._login.services
    ---账号标识
    local rid = client.role.rid;
    ---更新昵称
    ---@type string 
    local nickname = msg.nickname;
    ---更新结果
    ---@type s2c_loginResult
    local login = skynet.call(services.mysql,"lua","changeNickname",rid,nickname)
    ---返回结果
    websocket.sendpbc(fd,senum.s2c_loginResult(),{senum.login(),senum.succeed()},login)
end

---更新头像
---@param fd    socket              @套接字
---@param msg   c2s_changeLogolink  @消息
function loginmanager:changeLogolink(fd,msg)
     ---用户数据
     local client = self._sockets[fd]
     if not client then
         return
     end
    ---服务信息
    ---@type serviceInf
    local services = self._login.services
    ---账号标识
    local rid = client.role.rid;
    ---更新头像
    ---@type string 
    local logolink = msg.logolink;
    ---更新结果
    ---@type s2c_loginResult
    local login = skynet.call(services.mysql,"lua","changeLogolink",rid,logolink)
    ---返回结果
    websocket.sendpbc(fd,senum.s2c_loginResult(),{senum.login(),senum.succeed()},login)
end
  

return loginmanager