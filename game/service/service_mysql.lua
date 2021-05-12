--[[
    file:service_mysql.lua 
    desc:mysql
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local multicast = require("api_multicast")
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

local mysqlmanager = require("mysqlmanager")

---@class service_mysql @mysql服务
local service = {}
local this = service

---启动
---@param simport string @相对路径
function service.start() 
  --共享数据
  local adrres = skynet.queryservice("service_share")
  local shares = {
    "listener.mapServers",
  }
  for _,name in ipairs(shares) do
    local deploy = sharedata.query(name)
    _G.package.loaded[name] = deploy
  end

  this._manger = mysqlmanager.new(this)

  skynet.register(".mysql")
end

---服务表
function service.mapServices(name)
  local services = sharedata.query(name)
  ---@type serviceInf @服务地址信息
  this._services = services
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

---退出
function service.exit()
  skynet.exit()
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
        local f = this[cmd]
        local pack
        if f then
          pack = cs(f, ...)
        else
          local mgr = this._manger
          local f = mgr[cmd]
          pack = cs(f,mgr,...)
        end
        skynet.retpack(pack or false)
    end)
end)
