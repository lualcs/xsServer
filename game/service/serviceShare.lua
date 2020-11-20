
--[[
    file:serviceShare.lua 
    desc:启动所有共享配置
    auth:Carol Luo
]]
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")

skynet.start(function()
    --麻将成朴映射
    local name = "mahjong.mapMeets"
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
    local name = "canaster.mapNames"
    local deploy = require(name)
    sharedata.new(name,deploy)
    _G.package.loaded[name] = nil
end)

