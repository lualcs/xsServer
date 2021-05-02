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
local multicast = require("api_multicast")
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
    ---登陆管理
    ---@type loginmanager
    this._manger = loginmanager.new(this)
end

---服务退出
function service.exit()
    skynet.exit()
end

---服务表
function service.mapServices(name)
	local services = sharedata.query(name)
	---@type serviceInf @服务地址信息
	this._services = services
end

---注册协议
function service.protobuff(env)
    protobuff.set_protobuf_env(env)
end

---组播
function service.multicast()
	---服务
	local services = this._services
	---组播
	---@type api_multicast
	this._multicast = multicast.new()
	this._multicast:createBinding(services.mainChannel,function(channel,source,cmd,...)
		this._manger:multicastMsg(cmd,...)
	end)
end

skynet.start(function()
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = this[cmd]
        local pack
        if f then
            pack = cs(f,...)
        else
            local mgr = this._manger
            local f = mgr[cmd]
            pack = cs(f,mgr,...)
        end
        skynet.retpack(pack or false)
    end)
end)
