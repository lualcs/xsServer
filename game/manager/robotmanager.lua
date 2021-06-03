--[[
    desc:机器人管理
    auth:Caorl Luo
]]

local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("managerEnum")

---@class robotmanager @gate管理
local robotmanager = class()
local this = robotmanager

---构造
---@param service service_robot         @gate服务
function robotmanager:ctor(service)
    ---机器人服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new()
    ---空闲机器人
    ---@type userID[]
    self._idles = {nil}
    ---工作机器人
    ---@type userID[]
    self._works = {nil}
end

---重置
function robotmanager:dataReboot()
end

---服务
---@return serviceInf @服务信息
function robotmanager:getServices()
    return self._service._services
end

---服务
---@param rlist userID[] @机器列表
function robotmanager:feachRobotList(rlist)
    local _idles = self._idles
    table.push_list(_idles,rlist)
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody @数据
function robotmanager:message(fd,msg)
  
end

return robotmanager