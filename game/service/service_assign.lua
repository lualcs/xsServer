--[[
    desc:游戏桌子调配
    auth:Carol Luo
]]

local ipairs = ipairs
local multicast = require("api_multicast")
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

---@class service_assign @分配服务
local service = {}
local this = service

---启动
---@param simport     string      @分配类型
---@param allianceID  allianceID  @联盟标识
function service.start(simport,allianceID) 
    ---加载共享
    this.shareFech()    
    ---分配类型
    local import = require(simport)
    ---分配类型
    ---@type assignSuper
    this.assign = import.new(this,allianceID)

    skynet.register("." .. simport)
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
    for _,name in ipairs(shareFech.service_assign) do
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
    skynet.dispatch("lua",function(_, _, cmd, ...)
            local f = this[cmd]
            local pack
            if f then
              pack = cs(f, ...)
            else
              pack = cs(this.assign[cmd], this.assign, ...)
            end
            skynet.retpack(pack or false)
    end)
end)
