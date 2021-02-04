--[[
    file:server_login.lua 
    desc:登陆服务
    auth:Carol Luo
]]

local _G = _G
local format = string.format
local ipairs = ipairs
local debug = require("extend_debug")
local table = require("extend_table")
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local loginmanager = require("loginmanager")
local protobuff = require("api_pbc")
local cs = queue()


---@class service_login @桌子服务
local service = {}
local this = service

---服务启动
function service.start()
    this._manger = loginmanager.new(this)
    skynet.retpack(false)
end

---服务退出
function service.exit()
    skynet.retpack(true)
    skynet.exit()
end

---服务表
function service.gservices(name)
	local services = sharedata.query(name)
	---@type serviceInf @服务地址信息
	this.services = services
	skynet.retpack(false)
end

---注册协议
function service.protobuff(env)
    protobuff.set_protobuf_env(env)
end

skynet.start(function()
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = this[cmd]
        if f then
            cs(f,...)
        else
            local mgr = this._manger
            local f = mgr[cmd]
            cs(f,mgr,...)
        end
    end)
end)
