--[[
    file:gatemanager.lua 
    desc:gate消息处理
    auth:Caorl Luo
]]

local table = require("extend_table")
local debug = require("extend_debug")
local websocket = require("api_websocket")
local protobuff = require("api_pbc")
local skynet = require("skynet")
local class = require("class")
local tsort = require("sort")
local timer = require("timer")
local senum = require("managerEnum")

---@class gatemanager @gate管理
local gatemanager = class()
local this = gatemanager

---构造
---@param gate service_gate         @gate服务
---@param cens table<socket,gateClient> @连接隐射
function gatemanager:ctor(gate,cens)
    ---gate服务
    self._gate = gate
    ---client映射
    self._cens = cens
    ---定时器
    self._timer = timer.new()
    self._timer:poling()
end

---服务
---@return serviceInf @服务信息
function gatemanager:getServices()
    return self._gate.services
end

---请求
---@param fd  socket      @套接字
---@param msg messabeBody @数据
function gatemanager:message(fd,msg)
    tsort.reverse(msg.cmds)
    local cmd = table.remove(msg.cmds)
    local svs = self:getServices()
    local client = self._cens[fd]
    if senum.login() == cmd then
        --登陆请求
        local client = skynet.call(svs.login,"lua","message",fd,msg)
        if not client.failure then
            self._cens[fd] = client
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