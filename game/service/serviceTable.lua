--[[
    file:serviceTable.lua 
    desc:桌子服务
    auth:Carol Luo
]]

local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local queue = queue()
local string = string
local format = string.format


local infomation = {}
local service = {}

function service.start()
end

skynet.start(function()
    skynet.info_func(function()
        return infomation
    end)
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = service[cmd]
        if f then
            queue(f,...)
        else
            skynet.error(format("unknown:%s",cmd))
        end
    end)
end)
