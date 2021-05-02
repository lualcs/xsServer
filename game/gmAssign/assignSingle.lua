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
local senum = require("gameEnum")
local assignSuper = require("assignSuper")

---@class assignSingle:assignSuper @单机分配
local assignSingle = class(assignSuper)
local this = assignSingle

---构造函数
function assignSingle:ctor()
    ---@type name @类名
    self._assignClass = senum.assignSingle()
end

---重置
function assignSingle:dataReboot()
    ---金玉满堂
    self:createTable(10001,{})
end

---请求
---@param fd  socket      @套接字
---@param msg messageInfo @数据
function assignSingle:message(fd,msg)
    local cmd = table.remove(msg.cmds)
    local inf = msg.info
    ---进桌
    if cmd == senum.enter() then
    ---离卓
    elseif cmd == senum.leave() then
    end
end

return assignSingle