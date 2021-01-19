--[[
    file:aip_socketchannel.lua 
    desc:使用
    auth:Carol Luo
]]

local channel = require("skynet.socketchannel")
local class = require("class")
---@class aip_socketchannel 
local aip_channel = class()
local this = aip_channel

---构造
---@param desc socketchannel_desc
function aip_channel:ctor(desc)
    self._channel = channel.channel(desc)
end

---请求
---@param request   string      @请求数据
---@param response  function    @回应回调args(sock)
---@param padding   string[]    @填充数据
function aip_channel:request(request, response, padding)
    return self._channel:request(request, response, padding)
end

---关闭
function aip_channel:close()
    self._channel:close()
end

return aip_channel


---@class socketchannel_desc
---@field host      host        @地址
---@field port      port        @端口
---@field nodelay   boolean     @延时
---@field backup    address[]   @备用地址 
---@field auth      function    @认证函数args(obj:channel) 
---@field response  function    @解析函数args(obj:sock)
---@field overload  function    @超载回调args(boolean:isOverload)