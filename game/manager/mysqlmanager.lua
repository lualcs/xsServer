--[[
    file:mysqlmanager.lua 
    desc:mysql处理
    auth:Caorl Luo
]]

local ipairs = ipairs
local format = string.format
local string = require("extend_string")
local table = require("extend_table")
local debug = require("extend_debug")
local skynet = require("skynet")
local class = require("class")

local timer = require("timer")
local api_mysql = require("api_mysql")
local websocket = require("api_websocket")

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
    ---构造dbaccounts
    self:dbaccounts()
    ---构造dbPlatform
    self:dbplatform()
    ---构造头像库存表
    self:dblibarays()
end


---dbaccounts 结构
function mysqlmanager:dbaccounts()
    local cmds = require("mysql.dbaccounts")
    ---执行语句
    local mysql = self._mysql
    for index,cmd in ipairs(cmds) do
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
        end
    end
end

---dbaccounts 结构
function mysqlmanager:dbplatform()
    local cmds = require("mysql.dbplatform")
    ---执行语句
    local mysql = self._mysql
    for index,cmd in ipairs(cmds) do
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
        end
    end
end

---dblibarays 库存
function mysqlmanager:dblibarays()
    ---执行语句
    local mysql = self._mysql

    local logos = require("mysql.library_logo")
    for index,cmd in ipairs(logos) do
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
        end
    end

    local names = require("mysql.library_name")
    for index,cmd in ipairs(names) do
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
        end
    end
end

---游客登陆
---@param accredit string @登录凭证
function mysqlmanager:touristsLogin(accredit)
    ---拼接语句
    local sqlex = format([[
        CALL dbaccounts.procLoginTourists("%s");
    ]],accredit)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    --返回结果
    skynet.retpack(repak[1][1])
end

---手机登陆
---@param phonenum string @手机号码
---@param password string @登录密码
function mysqlmanager:phoneLogin(phonenum,password)
    ---拼接语句
    local sqlex = format([[
        CALL dbaccounts.procLoginPhone("%s","%s");
    ]],phonenum,password)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak and repak[1] and repak[1][1] then
        --返回结果
        skynet.retpack(repak[1][1])
    else
        --登录失败
        skynet.retpack({
            failure = "账号不存在,或者密码错误！",
        })
    end
end

---微信登陆
---@param accredit string @登录凭证
function mysqlmanager:wechatLogin(accredit)
    ---拼接语句
    local sqlex = format([[
        CALL dbaccounts.procLoginWechat("%s");
    ]],accredit)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak and repak[1] and repak[1][1] then
        --返回结果
        skynet.retpack(repak[1][1])
    else
        --登录失败
        skynet.retpack({
            failure = "账号不存在,或者密码错误！",
        })
    end
end

---更新昵称
---@param rid       number  @角色ID
---@param nickname  string  @更新昵称
function mysqlmanager:changeNickname(rid,nickname)
    ---拼接语句
    local sqlex = format([[
        UPDATE `dbaccounts`.`accounts` SET `nickname` = "%s"WHERE `rid` = %d;
    ]],nickname,rid)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    --返回结果
    skynet.retpack({
        rid = rid,
        nickname = nickname
    })
end

---更新头像
---@param rid       number  @角色ID
---@param logolink  string  @更新昵称
function mysqlmanager:changeLogolink(rid,logolink)
    ---拼接语句
    local sqlex = format([[
        UPDATE `dbaccounts`.`accounts` SET `logo` = "%s"WHERE `rid` = %d;
    ]],logolink,rid)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
     --返回结果
     skynet.retpack({
        rid = rid,
        logolink = logolink
    })
end

return mysqlmanager