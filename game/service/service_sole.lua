--[[
    desc:全局唯一
    auth:Caorl Luo
]]

local next = next
local table = require("extend_table")
local queue = require("skynet.queue")
local skynet = require("skynet.manager")
local multicast = require("api_multicast")
local sharedata = require("skynet.sharedata")
local cs = queue()

---@class service_sole @唯一服务
local service = {}
local this = service
local idlels  = {}
local autoID  = 1

---启动
function service.start(start)
    this.shareFech()
    ---@type historID @历史战绩
    this.historID = start.historID
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
      for _,name in ipairs(shareFech.service_sole) do
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

---重置
function service.dataReboot()
end


---战绩ID
function service.getHistorID()
    local historID = this.historID
    this.historID = historID + 1
    return this.historID
end


---申请
function service.getcompetitionID()
    if table.empty(idlels) then
        --没有空闲
        local soleID = autoID
        autoID = soleID + 1
        return soleID
    else
        --还有空闲
        local idleID = next(idlels)
        idlels[idleID] = nil
        return idleID
    end
end

---回收
function service.setcompetitionID(ID)
    idlels[ID] = true
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
        local pack = cs(this[cmd], ...)
        skynet.retpack(pack or false)
    end)
end)