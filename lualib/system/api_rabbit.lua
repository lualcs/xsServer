--[[
    desc:rabbit 消息队列
    auth:Carol Luo
]]

local rabbitmqstomp = require("rabbitmqstomp")

local class = require("class")

---@class api_rabbit @消息队列
local api_rabbit = class()
local this = api_rabbit

---构造
function api_rabbit:ctor()
end

return api_rabbit