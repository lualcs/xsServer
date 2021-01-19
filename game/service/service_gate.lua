--[[
	file:service_gate.lua 
	desc:入口
	auth:Carol Luo
]]

local format = string.format
local json = require("api_json")
local debug = require("extend_debug")
local websocket = require("api_websocket")
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

---@type mapServers @监听信息
local mapServers

---@class service_gate  	@入口服务
local service = {}
local this = service

---@type websocket_handle 	@消息回调
local ws_handle = {nil}

---连接
---@param fd socket
function ws_handle.connect(fd)
	debug.error("connect:",{
		fd = fd,
	})
end

---关闭
---@param fd socket @套接字
function ws_handle.close(fd,code,reason)
	debug.error("close:",{
		fd = fd,
		code = code,
		reason = reason,
	})
end

---握手
---@param fd socket @套接字
---@param header 
---@param url
function ws_handle.handshake(fd, header, url)
	local addr = websocket.addrinfo(fd)
	debug.error("handshake:",{
		fd = fd,
		addr = addr,
		header = header,
		url = url,
	})
end

---消息
---@param fd        socket @套接字
---@param message   any    @数据 
---@param msgtype   any    @类型
function ws_handle.message(fd, message, msgtype)
	local size = #message
	debug.error("message:",{
		fd = fd,
		--message = message,--json.decode(message),
		msgtype = msgtype,
	})
	skynet.trash(message,size)
end


---ping
---@param fd socket @套接字
function ws_handle.ping(fd)
	debug.error("ping:",{
		fd = fd,
	})
end

---pong
---@param fd socket @套接字
function ws_handle.pong(fd)
	debug.error("pong:",{
		fd = fd,
	})
end


---启动
function service.start()
	local gate = mapServers.gate
	local fd = websocket.listen(gate.host,gate.port,ws_handle)
	skynet.retpack(false)
end

---初始
skynet.init(function()
	---@type mapServers @监听信息
	mapServers = sharedata.query("listener.mapServers")
end)

---启动
skynet.start(function()
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = this[cmd]
        if f then
            cs(f,...)
        else
            local table = this._table
            local f = table[cmd]
            cs(f,table,...)
        end
    end)
end)



