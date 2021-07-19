--[[
    desc:支付服务
    auth:Carol
]]

local class = require("class")
local super = require("service_super")
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

---@class service_payment:service_super @服务基类
local service = class(super)
local this = service


skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
        local pack = cs(this[cmd], ...)
        skynet.retpack(pack or false)
    end)
end)