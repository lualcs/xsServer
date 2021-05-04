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
    self._clients = {nil}
    ---定时器
    self._timer = timer.new()
    ---堆结构
    self._hearbeats = heap.new()
   
end

---重置
function gatemanager:dataReboot()
    ---启动定时
    self._timer:poling()
    ---断线检查
    self._timer:appendEver(1000,function()
        self:heartbeatOff()
    end)
end

---服务
---@return serviceInf @服务信息
function gatemanager:getServices()
    return self._gate.services
end

---心跳断线
function gatemanager:heartbeatOff()
    local list = self._hearbeats
    local leaveTimer = os.getmillisecond() - 60 * 1000
    while list:reder().ticks < leaveTimer do
        local info = list:fetch()
        self._gate.shutdown(info.auto)
    end
end

---断线
---@param fd scoket @套接字
function gatemanager:offline(fd)
    local clients = self._clients
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
    skynet.call(services.login,"lua","offline",fd)
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
---@param msg messabeBody @数据
function gatemanager:message(fd,msg)
    self._hearbeats:adjustBy(fd,os.getmillisecond())
    tsort.reverse(msg.cmds)
    local cmd = table.remove(msg.cmds)
    local svs = self:getServices()
    local client = self._clients[fd]
    if senum.login() == cmd then
        --登陆请求
        ---@type client 
        local client = skynet.call(svs.login,"lua","message",fd,msg)
        if not client.failure then
            self._clients[fd] = client
        else
            debug.logServiceGate({
                msg = msg,
                ret = client,
            })
        end
    elseif senum.assignSingle() == cmd then
        --单机游戏
        skynet.send(svs.single,"lua","message",fd,msg)
    elseif senum.assignHundred() == cmd then
        --百人游戏
        skynet.send(svs.single,"lua","message",fd,msg)
    elseif senum.assignKilling() == cmd then
        --竞技游戏游戏
        skynet.send(svs.single,"lua","message",fd,msg)
    elseif senum.table() == cmd then
        --桌子消息
        local svc = client.tablesvc
        if svc then
            skynet.send(svc,"lua","message",fd,msg)
        end
    else
        debug.error("Unknown command")
    end
end

---回应
---@param fd  socket       @套接字
---@param msg messabeBody  @数据
function gatemanager:respond(fd,name,msg)
    websocket.send(fd,protobuff.encode_message(name,msg))
end

return gatemanager