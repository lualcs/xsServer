--[[
    file:service_agent.lua 
    desc:代理
    auth:Carol Luo
]]

local skynet = require("skynet")
local queue = require("skynet.queue")
local cs = queue()

local agent = {nil}
local this = agent

---@class client_info                   @客户端信息
---@field fd    socket                  @套接字

---启动
---@param  infs client_info @信息
function agent.start(infs)
    this._infs = infs
    skynet.retpack(false)
end

---退出
function agent.exit()
    skynet.exit()
end


skynet.start(function()
    ---处理watchdog过来的消息
    skynet.info_func(function()
        return this._infs
    end)
    skynet.dispatch("lua", function(session, source, cmd, ...)
        cs(this[cmd], ...)
    end)
end)