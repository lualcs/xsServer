--[[
    file:handle.lua 
    desc:结构
    auth:Caorl Luo
]]

---@class websocket_handle @web
local ws_handle = {nil}


---连接
---@param fd socket
function ws_handle.connect(fd)
end

---握手
---@param fd socket @套接字
---@param header 
---@param url
function ws_handle.handshake(fd, header, url)
end

---消息
---@param fd        socket @套接字
---@param message   any    @数据 
---@param msgtype   any    @类型
function ws_handle.message(fd, message, msgtype)
end


---ping
---@param fd socket @套接字
function ws_handle.ping(fd)
end

---pong
---@param fd socket @套接字
function ws_handle.pong(fd)
end

---关闭
---@param fd socket @套接字
function ws_handle.close(fd,code,reason)
end
