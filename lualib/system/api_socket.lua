--[[
    file:api_socket.lua 
    desc:socket使用
    auth:Caorl Luo
]]

local socket = require("skynet.socket")

---@class api_socket
local api_socket = {}

---监听
---@param host      ip                  @地址
---@param port      port                @端口
---@return socket       
function api_socket.listen(host, port)
    return socket.listen(host, port)
end

---连接
---@param address ip   @地址
---@param port    port @端
---@return socket
function api_socket.open(address, port)
    return socket.open(address, port)
end

---关闭
---@param fd    socket  @套接字
function api_socket.close(fd)
    socket.close(fd)
end

---关闭
---@param fd    socket  @套接字
function api_socket.close_fd(fd)
    socket.close_fd(fd)
end

---关闭
---@param fd    socket  @套接字
function api_socket.shutdown(fd)
    socket.shutdown(fd)
end

---启动
---@param fd        socket      @套接字
---@param func      function    @连接回调
function api_socket.start(fd, func)
    socket.start(fd, func)
end

---发送
---@param fd        socket      @套接字
---@param text      string      @字符串
function api_socket.write(fd, text)
    socket.write(fd, text)
end

---发送
---@param fd        socket      @套接字
---@param from      host        @网络地址
---@param data      string      @字符串数据     
function api_socket.sendto(fd, from, data)
    socket.sendto(fd, from, data)
end

return api_socket