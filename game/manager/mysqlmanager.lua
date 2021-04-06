--[[
    file:mysqlmanager.lua 
    desc:mysql处理
    auth:Caorl Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local debug = require("extend_debug")
local skynet = require("skynet")
local class = require("class")
local senum = require("managerEnum")
local api_mysql = require("api_mysql")
local timer = require("timer")

---@class mysqlmanager @gate管理
local mysqlmanager = class()
local this = mysqlmanager

---构造
---@param service service_mysql         @gate服务
function mysqlmanager:ctor(service)
    ---mysql服务
    ---@type service_mysql
    self._service = service

    ---mysql
    self._mysql = api_mysql.new({
        host        = "127.0.0.1",  --主机
        port        = 3306,         --端口
        database    = "";           --库名
        user        = "root";       --用户
        password    = "123456";     --密码
    })

    ---启动连接
    self._mysql:connect()

    ---启动定时器
    self._timer = timer.new()
    self._timer:poling()
end

---服务
---@return serviceInf @服务信息
function mysqlmanager:getServices()
    return self._service.services
end



---构造数据库
function mysqlmanager:dbstructure()
    self:dbAccounts()
    skynet.retpack(false)
end


---dbaccounts 结构
function mysqlmanager:dbAccounts()
    local cmds = require("mysql.dbaccounts")
    ---执行语句
    local mysql = self._mysql
    for index,cmd in ipairs(cmds) do
        debug.normal(mysql:query(cmd))
    end
end


return mysqlmanager