--[[
    desc:联盟服务
    auth:Carol Luo
]]

local ipairs = ipairs
local debug = require("extend_debug")
local multicast = require("api_multicast")
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local protobuff = require("api_pbc")
local clubmanager = require("clubmanager")
local queue = require("skynet.queue")
local cs = queue()

---@class service_clubs @联盟服务
local service = {}
local this = service

---启动
function service.start()
    this.shareFech()
    this._manager = clubmanager.new(this)
end

---退出
function service.exit()
    skynet.exit()
end

---加载共享
function service.shareFech()
    local shareFech = sharedata.query("share.fech")
      --通用部分
      for _,name in ipairs(shareFech.general_fech) do
          local deploy = sharedata.query(name)
          _G.package.loaded[name] = deploy
      end
      --独属部分
      for _,name in ipairs(shareFech.service_clubs) do
        local deploy = sharedata.query(name)
        _G.package.loaded[name] = deploy
    end
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
		this._manager:multicastMsg(cmd,...)
	end)
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
        local f = this[cmd]
        local pack
        if f then
            pack = cs(f,...)
        else
            local mgr = this._manager
            local f = mgr[cmd]
            pack = cs(f,mgr,...)
        end
        skynet.retpack(pack or false)
    end)
end)