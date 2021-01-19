--[[
    file:api_dns.lua 
    desc:域名解析
    auth:Carol Luo
]]

local dns = require "skynet.dns"

---@class api_dns
local api_dns = {}

---指定dns服务器
---@param server    ip      @地址
---@param port      port    @端口 默认53
function api_dns.server(server,port)
    dns.server(server,port)
end

---查询dns IP
---@param name      dns         @域名
---@param ipv6      boolean     @是否查询ipv6地址
function api_dns.resolve(name, ipv6)
    return dns.resolve(name, ipv6)
end

---清空缓存
function api_dns.flush()
    dns.flush()
end

return api_dns