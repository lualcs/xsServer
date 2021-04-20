--[[
    file:assignSingle.lua
    desc:单人
    auth:Caorl Luo
]]

local skynet = require("skynet")
local tsort = require("sort")
local class = require("class")
local table = require("extend_table")
local debug = require("extend_debug")
local gameEnum = require("gameEnum")
local assignSuper = require("assignSuper")

---@class assignSingle:assignSuper @单机分配
local assignSingle = class(assignSuper)
local this = assignSingle

---构造函数
function assignSingle:ctor()
    ---@type name @类名
    self._assignClass = gameEnum.assignSingle()
end

---请求
---@param fd  socket      @套接字
---@param msg messabeBody @数据
function assignSingle:message(fd,msg)
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
        debug.logAssignhSingle("Unknown command")
    end
end

return assignSingle