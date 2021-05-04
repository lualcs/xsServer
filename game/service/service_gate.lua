--[[
	file:service_watchdog.lua 
	desc:入口
	auth:Carol Luo
]]

local format = string.format
local reusable = require("reusable")
local os = require("extend_os")
local debug = require("extend_debug")
local json = require("api_json")
local multicast = require("api_multicast")
local websocket = require("api_websocket")
local socketdriver = require("api_socketdriver")
local protobuff = require("api_pbc")
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

local gatemanager = require("gatemanager")

---@type mapServers 				@监听信息
local mapServers

---@class service_gate  			@入口服务
local service = {nil}
local this = service

---@type websocket_handle 			@消息回调
local ws_handle = {nil}
---@type table<fd,gateClient>	@连线信息
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
	---@type gateClient
	local item = fdreusable:get()
	item.address = websocket.addrinfo(fd)
	mapclients[fd] = item

	---添加堆数据
    this._manger._hearbeats:appendBy(os.getmillisecond(),fd,fd)

	debug.error("connect:",item)
end

---关闭
---@param fd socket @套接字
function ws_handle.close(fd,code,reason)
	local item = mapclients[fd]
	fdreusable:set(item)
	mapclients[fd] = nil
	this._manger:offline(fd)
end

---握手
---@param fd socket @套接字
---@param header string @握手信息 
---@param url	 string @链接地址
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
	local data = protobuff.decode_message(message,#message)
	this._manger:message(fd,data)
	skynet.trash(message,#message)
end


---启动
function service.start()
	--监听
	local gate = mapServers.gate
	local fd = websocket.listen(gate.host,gate.port,ws_handle)
	--协议
	local list = require("protocol.protobuff")
	protobuff.parser_register(list,"game_protobuff")
	
	---@type gatemanager
	this._manger = gatemanager.new(this)
end

---主动关闭
---@param fd socket @套接字
function service.shutdown(fd)
	if mapclients[fd] then
		websocket.close(fd, 0 ,"heartbeat")
	end
end

---服务表
function service.mapServices(name)
	local services = sharedata.query(name)
	---@type serviceInf @服务地址信息
	this._services = services

	---@type userdata @共享protobuff
	local env = protobuff.get_protobuf_env()
    skynet.send(services.login,"lua","protobuff",env)
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
            local mgr = this._manger
            local f = mgr[cmd]
            cs(f,mgr,...)
        end
		skynet.retpack(false)
    end)
end)



