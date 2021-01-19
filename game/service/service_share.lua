
--[[
    file:service_share.lua 
    desc:启动所有共享配置
    auth:Carol Luo
]]

local format = string.format
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require "skynet.queue"
local cs = queue()

---@class service_share @共享服务
local service_share = {}
local this = service_share

---服务启动
function service_share.start()
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

    --金玉满堂配置
    local name = "slots.games.slots_jymt_cfg"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil

    skynet.retpack(false)
end

---服务加载
function service_share.loading()
    skynet.retpack({
        "games.gameInfos",
    })
end

---设置共享
function service_share.setShare(name,infos)
    sharedata.new(name,infos)
    skynet.retpack(false)
end

skynet.start(function()
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = service_share[cmd]
        if f then
            cs(f,...)
        else
            skynet.error(format("unknown:%s",cmd))
            skynet.retpack(false)
        end
    end)
    
end)

