
--[[
    file:service.lua 
    desc:启动所有共享配置
    auth:Carol Luo
]]

local pairs = pairs
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
    --麻将成朴映射
    local name = "mahjong.mapHuCards"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --麻将名字映射
    local name = "mahjong.mapNames"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --麻将视图映射
    local name = "mahjong.mapViews"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --麻将成扑隐射
    local name = "mahjong.mapSnaps"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --扑克名字映射
    local name = "poker.mapNames"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --服务信息数据
    local name = "listener.mapServers"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --游戏信息数据
    local name = "games.gameInfos"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --管理桌子数据
    local name = "sundry.table"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --管理机器数据
    local name = "sundry.robot"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
    --平台比例数据
    local name = "sundry.ratio"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil

    --金玉满堂配置
    local name = "slots.games.slots_jymt_cfg"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil

end

---服务表
function service.mapServices(name)
    local services = sharedata.query(name)
    ---@type serviceInf @服务地址信息
    this._services = services
  end

---服务加载
function service.loading()
    return {
        "games.gameInfos",
    }
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

