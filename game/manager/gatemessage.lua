--[[
    file:gatemessage.lua 
    desc:gate消息处理
    auth:Caorl Luo
]]

local table = require("extend_table")
local websocket = require("api_websocket")
local protobuff = require("api_pbc")
local skynet = require("skynet")
local class = require("class")
local gameEnum = require("gameEnum")

---@class gatemessage @gate管理
local gatemessage = class()
local this = gatemessage

---构造
---@param gate service_gate         @gate服务
---@param cens table<socket,client> @连接隐射
function gatemessage:ctor(gate,cens)
    self._gate = gate
    self._cens = cens
end

---服务
---@return serviceInf @服务信息
function gatemessage:getServices()
    return self._gate.services
end

---请求
---@param fd  socket      @套接字
---@param msg messabeBody @数据
function gatemessage:request(fd,msg)
    local cmd = table.remove(msg.channel)
    local svs = self:getServices()
    local client = self._cens[fd]
    if gameEnum.login() == cmd then
        --登陆请求
        skynet.send(svs.login,"lua","request",fd,msg)
    elseif gameEnum.assignSingle() == cmd then
        --单机游戏
        skynet.send(svs.single,"lua","request",fd,msg)
    elseif gameEnum.table() == cmd then
        --桌子消息
        local svc = client.tablesvc
        if svc then
            skynet.send(svc,"lua","request",fd,msg)
        end
    end
end

---回应
---@param fd  socket       @套接字
---@param msg messabeBody  @数据
function gatemessage:respond(fd,name,msg)
    websocket.send(fd,protobuff.encode_message(name,msg))
end

return gatemessage