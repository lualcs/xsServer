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
local tostring = require("extend_tostring")

local infomation = {}
local service = {}

function service.start()
    local mapNames = sharedata.query("canaster.mapNames")
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
        skynet.retpack(false)
    end)
end)
