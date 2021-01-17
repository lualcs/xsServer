--[[
    file:api_msgserver.lua
    desc:消息服务使用
    auth:Carol Luo
]]

local msgserver = require("snax.msgserver")

local class = require("class")
---@class api_msgserver
local api_msgserver = {}
local this = api_msgserver


---启动服务
---@param conf msgservice_start_cfg
function api_msgserver.start(conf)
    msgserver.start(conf)
end

---获取userid
---@param username name @用户名字
function api_msgserver.userid(username)
    return msgserver.userid(username)
end

---获取username
---@param uid           xxxx @
---@param subid         xxxx @
---@param servername    xxxx @
function api_msgserver.username(uid, subid, servername)
	return msgserver.userid(uid, subid, servername)
end

function api_msgserver.logout(username)
	msgserver.logout(username)
end

function api_msgserver.login(username, secret)
	msgserver.login(username, secret)
end

function api_msgserver.ip(username)
	return msgserver.ip(username)
end

return api_msgserver


---@class msgservice_start_cfg
---@field expired_number        number      @失效
---@field login_handler         function    @登陆
---@field logout_handler        function    @退出
---@field kick_handler          function    @剔除
---@field register_handler      function    @注册
---@field disconnect_handler    function    @断开
---@field request_handler       function    @请求
---@field request_handler       function    @请求