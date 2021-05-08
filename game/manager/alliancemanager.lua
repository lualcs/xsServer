--[[
    desc:联盟管理
    auth:Caorl Luo
]]

local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("managerEnum")

---@class alliancemanager @gate管理
local alliancemanager = class()
local this = alliancemanager

---构造
---@param service service_robot         @gate服务
function alliancemanager:ctor(service)
    ---机器人服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new()
end

---重置
function alliancemanager:dataReboot()
    ---启动定时器
    self._timer:poling()
end

---服务
---@return serviceInf @服务信息
function alliancemanager:getServices()
    return self._service.services
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody @数据
function alliancemanager:message(fd,msg)
  
end

return alliancemanager