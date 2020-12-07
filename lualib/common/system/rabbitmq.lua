--[[
    file:rabitmq.lua
    desc:AMQP的使用-RabbitMQ
    auth:Carol Luo
]]

local class = require("class")
local rabbitmqstomp = require "rabbitmqstomp"

---@class rabbitmq @如何使用rmq
local rabbitmq = class()

---构造函数
function rabbitmq:ctor(address,rmqUser)
    self.mq = self:connect(address, rmqUser)
end

---建立连接
---@param address address @地址
---@param rmqUser rmqUser @账户
function rabbitmq:connect(address, rmqUser)
    self.mq = rabbitmqstomp.connect(address,rmqUser)
end

---发送消息
---@param name name @?
---@param json json @发送数据
function rabbitmq:send_rmq_msg(name,json)
    self.mq:send_rmq_msg(name,json)
end