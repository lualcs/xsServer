--[[
    file:api_mysql.lua 
    desc:mysql 的使用
    auth:Caorl Luo
]]

local debug = require("extend_debug")
local format = string.format
local class = require("class")
local mysql = require("skynet.db.mysql")

---@class api_mysql @api_mysql
local api_mysql = class()
local this = api_mysql


---构造函数
---@param info mysql_connect_info @连接信息
function api_mysql:ctor(info)
    ---@type mysql_connect_info
    self._info = info
end

---连接函数
---@param info mysql_connect_info @连接信息
function api_mysql:connect()
    self._db = mysql.connect(self._info)
end

---连接断开
function api_mysql:disconnect()
    self._db:disconnect()
end

---执行语句
---@param cmd mysql_cmd @命令
function api_mysql:query(cmd)
    return self._db:query(cmd)
end


---@class mysql_connect_info        @mysql 连接信息
---@field host              host            @目标主机
---@field port              port            @端口
---@field database          name            @库名
---@field user              name            @用户
---@field password          password        @密码 
---@field max_packet_size   number          @最大字节
---@field on_connect        function        @连接回调函数
---@field charset           number          @编码
---@field overload          xxx
---@field compact_arrays    xxx

return api_mysql