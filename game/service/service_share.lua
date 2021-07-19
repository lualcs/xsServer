
--[[
    file:service.lua 
    desc:启动所有共享配置
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local format = string.format
local skynet = require("skynet")
local queue = require ("skynet.queue")
local sharedata = require("skynet.sharedata")
local senum = require("managerEnum")
local cs = queue()

---@class service_assign @共享服务
local service = {}
local this = service

---服务启动
function service.start()
    local name = "share.push"
    local list = require(name)
    for _,name in ipairs(list) do
        local deploy = require(name)
        sharedata.new(name,deploy)
        _G.package.loaded[name] = nil
    end
end

---服务表
function service.mapServices(name)
    local services = sharedata.query(name)
    ---@type serviceInf @服务地址信息
    this._services = services
end


---设置共享
function service.setShare(name,infos)
    sharedata.new(name,infos)
end


---广播服务
function service.broadcast(name)
    ---@type serviceInf
    local mapServices = sharedata.query(name)
    for key,service in pairs(mapServices) do
        if service == mapServices.debug then
        elseif service == mapServices.share then
        elseif service == mapServices.mainChannel then
        else
            skynet.call(service,"lua",name,name)
        end
    end
end

---广播服务
function service.distributed(name,...)
    ---@type serviceInf
    local mapServices = sharedata.query(senum.mapServices())
    for key,service in pairs(mapServices) do
        if service == mapServices.debug then
        elseif service == mapServices.share then
        elseif service == mapServices.mainChannel then
        else
            skynet.call(service,"lua",name,...)
        end
    end
end

skynet.start(function()
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = service[cmd]
        local pack
        if f then
            pack = cs(f,...)
        else
            skynet.error(format("unknown:%s",cmd))
        end
        skynet.retpack(pack or false)
    end)
    
end)

