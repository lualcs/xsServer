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
local gameEnum = require("gameEnum")

---@class gatemanager @gate管理
local gatemanager = class()
local this = gatemanager

---构造
---@param gate service_gate         @gate服务
---@param cens table<socket,client> @连接隐射
function gatemanager:ctor(gate,cens)
    self._gate = gate
    self._cens = cens
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
    if gameEnum.login() == cmd then
        --登陆请求
        skynet.send(svs.login,"lua","message",fd,msg)
    elseif gameEnum.assignSingle() == cmd then
        --单机游戏
        skynet.send(svs.single,"lua","message",fd,msg)
    elseif gameEnum.table() == cmd then
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