--[[
    desc:http服务器管理
    auth:Caorl Luo
]]

local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("managerEnum")

---@class shttpmanger @http服务器管理
local shttpmanger = class()
local this = shttpmanger

---构造
---@param service service_robot         @gate服务
function shttpmanger:ctor(service)
    ---机器人服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new()
end

---重置
function shttpmanger:dataReboot()
    ---启动定时器
    self._timer:poling()
end

---服务
---@return serviceInf @服务信息
function shttpmanger:getServices()
    return self._service._services
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody     @数据
function shttpmanger:message(fd,msg)
  
end

return shttpmanger