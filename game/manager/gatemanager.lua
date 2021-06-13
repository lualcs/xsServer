--[[
    file:gatemanager.lua 
    desc:gate消息处理
    auth:Caorl Luo
]]

local os = require("extend_os")
local table = require("extend_table")
local debug = require("extend_debug")
local websocket = require("api_websocket")
local protobuff = require("api_pbc")
local skynet = require("skynet")
local class = require("class")
local tsort = require("sort")
local timer = require("timer")
local heap = require("heap")
local senum = require("managerEnum")

---@class gatemanager @gate管理
local gatemanager = class()
local this = gatemanager

---构造
---@param gate service_gate         @gate服务
function gatemanager:ctor(gate)
    ---gate服务
    ---@type service_gate
    self._gate = gate
    ---client映射
    ---@type table<fd,loginClient>
    self._clientLis = {nil}
     ---client映射
    ---@type table<userID,loginClient>
    self._clientMap = {nil}
    ---定时器
    self._timer = timer.new()
    ---堆结构
    self._hearbeats = heap.new()
   
end

---重置
function gatemanager:dataReboot()
    ---断线检查
    self._timer:appendEver(1000,function()
        self:heartbeatOff()
    end)
end

---服务
---@return serviceInf @服务信息
function gatemanager:getServices()
    return self._gate._services
end

---心跳断线
function gatemanager:heartbeatOff()
    local list = self._hearbeats
    local leaveTimer = os.getmillisecond() - 60 * 1000
    local reder = list:reder()
    while reder and reder.ticks < leaveTimer do
        local info = list:fetch()
        self._gate.shutdown(info.auto)
        reder = list:reder()
    end
end

---上线
---@param fd scoket @上线用户
function gatemanager:online(fd)

    local client = self._clientLis[fd]
    if not client then
        return
    end

    client.online = true

    ---服务信息
    local services = self:getServices()
    ---通知上线
    skynet.call(services.login,"lua","online",client.role.rid,fd)
    ---通知联盟
    skynet.call(services.club,"lua","online",client.role.rid,fd)
    ---分配服务
    if client.assign then
        skynet.call(client.assign,"lua","online",client.role.rid,fd)
    end
    ---桌子服务
    if client.table then
        skynet.call(client.table,"lua","online",client.role.rid,fd)
    end
end

---断线
---@param rid userID @套接字
function gatemanager:offline(fd)
    local clients = self._clientLis
    local client = clients[fd]
    if not client then
        return
    end

    clients[fd] = nil
    client.online = false

    ---服务信息
    local services = self:getServices()
    ---删除定时
    self._hearbeats:deleteBy(fd)
    ---通知断线
    skynet.call(services.login,"lua","offline",client.role.rid)
    ---通知联盟
    skynet.call(services.club,"lua","offline",client.role.rid)
    ---分配服务
    if client.assign then
        skynet.call(client.assign,"lua","offline",client.role.rid)
    end
    ---桌子服务
    if client.table then
        skynet.call(client.table,"lua","offline",client.role.rid)
    end
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody     @数据
function gatemanager:message(fd,msg)
    self._hearbeats:adjustBy(fd,os.getmillisecond())
    tsort.reverse(msg.cmds)
    local cmd = table.remove(msg.cmds)
    local services = self:getServices()
    local client = self._clientLis[fd]
    if senum.heartbeat() == cmd then
        debug.normal(fd,cmd)
        return
    end

    if senum.login() == cmd then
        --登陆请求
         skynet.send(services.login,"lua","message",fd,msg)
         return
    end

    if not client then
        return
    end

    if senum.club() == cmd then
        --联盟模块
        skynet.send(services.club,"lua","message",fd,client.role.rid,msg)
    elseif senum.assignSingle() == cmd then
        --单机游戏
        skynet.send(services.single,"lua","message",fd,client.role.rid,msg)
    elseif senum.assignHundred() == cmd then
        --百人游戏
        skynet.send(services.single,"lua","message",fd,client.role.rid,msg)
    elseif senum.assignKilling() == cmd then
        --竞技游戏游戏
        skynet.send(services.single,"lua","message",fd,client.role.rid,msg)
    elseif senum.table() == cmd then
        --桌子消息
        local svc = client.tablesvc
        if svc then
            skynet.send(svc,"lua","message",fd,client.role.rid,msg)
        end
    else
        debug.error("Unknown command",cmd)
    end
end

---登陆成功
---@param client client @登陆成功
function gatemanager:loginSuccessfully(client)
    self._clientLis[client.fd] = client
    self._clientMap[client.role.rid] = client
    self:online(client.fd)
end

---@class playerInfo      @游戏玩家
---@field fd        socket   @套接字
---@field userID    userID   @玩家ID
---@field seatID    seatID   @座位ID
---@field coin      score    @玩家分数
---@field name      name     @玩家名子
---@field logo      url      @玩家头像
---@field line      senum    @在线状态
---@field robot     boolean  @true:机器人 false:真人

---邀请进桌
---@param assign        service @分配服务
---@param competition   service @游戏桌子
---@param rid           userID  @用户角色
function gatemanager:inviteEnterTable(assign,competition,rid)
    local client = self._clientMap[rid]
    local role = client.role
    skynet.send(assign,"lua","inviteEnterTable",competition,{
        fd        = client.fd,
        userID    = role.rid,
        coin      = role.coin,
        name      = role.nickname,
        logo      = role.logolink,
        line      = client.online,
        robot     = role.office == senum.robot(),
    })
end

---成功入桌子
---@param rid           userID          @用户角色
---@param assign        service         @分配服务
---@param competition   service         @游戏桌台
function gatemanager:liveTable(rid,assign,competition)
    ---数据保存
    local client = self._clientMap[rid]
    client.assign = assign
    client.table = competition
end

return gatemanager