--[[
    file:assignSingle.lua
    desc:单人
    auth:Caorl Luo
]]

local pcall = pcall
local skynet = require("skynet")
local tsort = require("sort")
local class = require("class")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("game.enum")
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
    self:super(this,"dataReboot")
end

---请求
---@param fd  socket      @套接字
---@param msg messageInfo @数据
function assignSingle:message(fd,msg)
    
end

return assignSingle