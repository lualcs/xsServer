--[[
    desc:http客户端管理
    auth:Caorl Luo
]]

local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("managerEnum")
local ahttp = require("api_http")

---@class chttpmanger @http客户端管理
local chttpmanger = class()
local this = chttpmanger

---构造
---@param service service_robot         @gate服务
function chttpmanger:ctor(service)
    ---机器人服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new()
end

---重置
function chttpmanger:dataReboot()
   
end

---服务
---@return serviceInf @服务信息
function chttpmanger:getServices()
    return self._service._services
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody @数据
function chttpmanger:message(fd,msg)
  
end

return chttpmanger