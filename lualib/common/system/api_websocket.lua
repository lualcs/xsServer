--[[
    file:api_websocket.lua
    desc:websocket 使用
    auth:Carol Luo
]]

local tsort = require("sort")
local api_socket = require("api_socket")
local protbuff = require("api_pbc")
local websocket = require("http.websocket")

---@class api_websocket
local api_websocket = {nil}
local this = api_websocket

---监听
---@param host      ip                  @地址
---@param port      port                @端口
---@param handle    websocket_handle    @对象
function api_websocket.listen(host, port,handle)
    local fd = api_socket.listen(host, port)
    api_socket.start(fd,function(fd,addr)
        this.accept(fd,handle,"ws",addr)
    end)
    return fd
end

---接受
---@param fd        socket              @套接字
---@param handle    websocket_handle    @handle
---@param protocol  string              @ws or wss
---@param addr      host                @地址
function api_websocket.accept(fd, handle, protocol, addr)
    websocket.accept(fd, handle, protocol, addr)
end

---地址
---@param   fd        socket             @地址
---@return  ip
function api_websocket.addrinfo(fd)
    return websocket.addrinfo(fd)
end

---关闭
---@param   fd      socket  @套接字
---@param   code    number  @掩码
---@param   reason  string  @原因
function api_websocket.close(fd, code ,reason)
    return websocket.close(fd, code ,reason)
end

---发送
---@param fd            socket  @套接字
---@param data          string  @数据
---@param fmt           string  @类型 "text" or "binary"
---@param masking_key   number  @掩码
function api_websocket.write(fd,data,fmt,masking_key)
    websocket.write(fd,data,fmt,masking_key)
end


---发送
---@param fd            socket  @套接字
---@param data          string  @数据
function api_websocket.sendpbc(fd,name,cmds,info)
    tsort.reverse(cmds)
    local data = protbuff.encode_message(name,cmds,info)
    websocket.write(fd,data,"binary")
end


return api_websocket