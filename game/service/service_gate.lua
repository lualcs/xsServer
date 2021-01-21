--[[
	file:service_watchdog.lua 
	desc:入口
	auth:Carol Luo
]]

local format = string.format
local reusable = require("reusable")
local debug = require("extend_debug")
local json = require("api_json")
local websocket = require("api_websocket")
local socketdriver = require("api_socketdriver")
local protobuff = require("api_pbc")
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

local gatemessage = require("gatemessage")

---@type mapServers 				@监听信息
local mapServers

---@class service_gate  			@入口服务
local service = {nil}
local this = service

---@type websocket_handle 			@消息回调
local ws_handle = {nil}
---@type table<socket,client>	@连线信息
local mapclients = {nil}
local fdreusable = reusable.new()
local connect_count = 0
---连接
---@param fd socket
function ws_handle.connect(fd)
	if connect_count >= 10000 then
		websocket.close(fd)
		return
	end
	socketdriver.nodelay(fd)
	connect_count = connect_count + 1
	---@type client
	local item = fdreusable:get()
	item.address = websocket.addrinfo(fd)
	item.atTable = nil
	mapclients[fd] = item
	debug.error("connect:",item)
end

---关闭
---@param fd socket @套接字
function ws_handle.close(fd,code,reason)
	local item = mapclients[fd]
	fdreusable:set(item)
	mapclients[fd] = nil
	debug.error("close:",{fd=fd,code=code,reason=reason})
end

---握手
---@param fd socket @套接字
---@param header 
---@param url
function ws_handle.handshake(fd, header, url)
	debug.error("handshake:",{fd=fd,header=header,url=url})
end

---ping
---@param fd socket @套接字
function ws_handle.ping(fd)
	debug.error("ping:",{fd=fd})
end

---pong
---@param fd socket @套接字
function ws_handle.pong(fd)
	debug.error("pong:",{fd=fd})
end


---消息
---@param fd        socket  @套接字
---@param message   string	@数据 
---@param msgtype   string	@类型 "text" or "binary"
function ws_handle.message(fd, message, msgtype)
	debug.error("message:",{fd=fd,message=message,msgtype=msgtype})
	local msgHead,msgBody = protobuff.decode_message(message,#message)
	this._msg:request(fd,msgBody)
end


---启动
function service.start()
	--监听
	local gate = mapServers.gate
	local fd = websocket.listen(gate.host,gate.port,ws_handle)
	--协议
	local list = require("protocol.protobuff")
    protobuff.parser_register(list,"game_protobuff")
	--消息
	this._msg = gatemessage.new(this,mapclients)
	skynet.retpack(false)
end

---服务表
function service.gservices(name)
	local services = sharedata.query(name)
	---@type serviceInf @服务地址信息
	this.services = services
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
            local mgr = this._msg
            local f = mgr[cmd]
            cs(f,mgr,...)
        end
    end)
end)



