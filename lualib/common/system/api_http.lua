
--[[
    file:api_http.lua
    desc:http 的使用
    auth:Carol Luo
]]

local class = require("class")
local httpc = require("http.httpc")
local httpd = require("http.httpd")

---@class api_http http 使用
local api_http = class()
local this = api_http

---构造函数
function api_http:ctor()
end

---http请求
---@param method        string      @GET-POST
---@param host          string      @目标地址
---@param url           string      @请求url
---@param recvheader    nil|table   @接收回应的hppt协议头
---@param content       string      @请求的内容
function api_http.request(method, host, url, recvheader, header, content)
    return httpc.request(method, host, url, recvheader, header, content)
end


---http-GET
---@param host          string      @目标地址
---@param url           string      @请求url
---@param recvheader    nil|table   @接收回应的hppt协议头
---@param content       string      @请求的内容
function api_http.get(host, url, recvheader, header, content,...)
	return httpc.get("GET", host, url, recvheader, header, content,...)
end

---http-POST
---@param host          string                  @目标地址
---@param url           string                  @请求url
---@param form          table<string,string>    @请求的内容
---@param recvheader    nil|table               @接收回应的hppt协议头
function api_http.post(host, url, form, recvheader)
	return httpc.post(host, url, form, recvheader)
end


return api_http