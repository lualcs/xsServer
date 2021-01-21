--[[
    file:service.lua 
    desc:全局唯一
    auth:Caorl Luo
]]

local next = next
local table = require("extend_table")
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

---@class service_sole @唯一服务
local service = {}
local this = service
local idlels  = {}
local autoID  = 1

---启动
function service.start(start)
    ---@type historID @历史战绩
    this.historID = start.historID
    skynet.retpack(false)
end

---服务表
function service.gservices(name)
    local services = sharedata.query(name)
    ---@type serviceInf @服务地址信息
    this.services = services
    skynet.retpack(false)
  end

---退出
function service.exit()
    skynet.exit()
end

---战绩ID
function service.getHistorID()
    local historID = this.historID
    this.historID = historID + 1
    skynet.retpack(this.historID)
end


---申请
function service.getTableID()
    if table.empty(idlels) then
        --没有空闲
        local soleID = autoID
        autoID = soleID + 1
        skynet.retpack(soleID)
    else
        --还有空闲
        local idleID = next(idlels)
        idlels[idleID] = nil
        skynet.retpack(idleID)
    end
end

---回收
function service.setTableID(ID)
    idlels[ID] = true
    skynet.retpack(false)
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
        cs(this[cmd], ...)
    end)
end)