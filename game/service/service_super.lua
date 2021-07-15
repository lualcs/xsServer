--[[
    desc:服务基类
    auth:Caorl Luo
]]

local next = next
local class = require("class")
local table = require("extend_table")
local multicast = require("api_multicast")
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

---@class service_super @服务基类
local super = class()
local this = super

---启动
---@param service_name name 服务名字
function super.start(service_name)
    --加载共享数据
    this.shareFech(service_name)
end

---退出
function super.exit()
    skynet.exit()
end

---加载共享
function super.shareFech(service_name)
    local shareFech = sharedata.query("share.fech")
      --通用部分
      for _,name in ipairs(shareFech.general_fech) do
          local deploy = sharedata.query(name)
          _G.package.loaded[name] = deploy
      end
      --独属部分
      for _,name in ipairs(shareFech[service_name]) do
        local deploy = sharedata.query(name)
        _G.package.loaded[name] = deploy
    end
end

---服务表
function super.mapServices(name)
    local services = sharedata.query(name)
    ---@type serviceInf @服务地址信息
    this._services = services
  end

  ---组播
function super.multicast()
	---服务
	local services = this._services
	---组播
	---@type api_multicast
	this._multicast = multicast.new()
	this._multicast:createBinding(services.mainChannel,function(channel,source,cmd,...)
		this._manger:multicastMsg(cmd,...)
	end)
end

---重置
function super.dataReboot()
end


return super

