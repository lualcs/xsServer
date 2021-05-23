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
local mysql = require("api_mysql")
local websocket = require("api_websocket")
local listen = require("listener.mapServers")

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
    self._mysql = mysql.new(listen.mysql)

    ---启动连接
    self._mysql:connect()

    ---启动定时器
    self._timer = timer.new()
    self._timer:poling()

end

---重置
function mysqlmanager:dataReboot()
    ---构造数据库
    --self:dbstructure()
end

---服务
---@return serviceInf @服务信息
function mysqlmanager:getServices()
    return self._service._services
end

---构造数据库
function mysqlmanager:dbstructure()
    ---构造dbaccounts
    self:dbaccounts()
    ---构造dbaccountsProcedure
    self:dbaccountsProcedure()
    ---构造dballiances
    self:dballiances()
    ---构造dballiancesProcedure
    self:dballiancesProcedure()
    ---构造dbPlatform
    self:dbplatform()
    ---构造dbgameinfo
    self:dbgameinfo()
    ---构造dbsundrys
    self:dbsundrys()
    ---构造默认库存表
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

---dbaccountsProcedure 结构
function mysqlmanager:dbaccountsProcedure()
    local cmds = require("mysql.dbaccountsProcedure")
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
function mysqlmanager:dballiances()
    local cmds = require("mysql.dballiances")
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

---dballiancesProcedure 结构
function mysqlmanager:dballiancesProcedure()
    local cmds = require("mysql.dballiancesProcedure")
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

---构造dbgameinfo 结构
function mysqlmanager:dbgameinfo()
    local cmds = require("mysql.dbgameinfo")
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


---dbsundrys 结构
function mysqlmanager:dbsundrys()
    local cmds = require("mysql.dbsundrys")
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

    ---库存头像
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

    ---库存昵称
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

    ---联盟数据
    local alliances = require("mysql.library_alliances")
    for index,cmd in ipairs(alliances) do
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
        CALL dbaccounts.procedureLoginTourists("%s");
    ]],accredit)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
    end
    --返回结果
    return repak[1][1]
end

---手机登陆
---@param phonenum string @手机号码
---@param password string @登录密码
function mysqlmanager:phoneLogin(phonenum,password)
    ---拼接语句
    local sqlex = format([[
        CALL dbaccounts.procedureLoginPhone("%s","%s");
    ]],phonenum,password)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
    end
    return repak[1][1]
end

---微信登陆
---@param accredit string @登录凭证
function mysqlmanager:wechatLogin(accredit)
    ---拼接语句
    local sqlex = format([[
        CALL dbaccounts.procedureLoginWechat("%s");
    ]],accredit)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
    end
    return repak[1][1]
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
    if repak.err then
        debug.error(repak)
    end
    --返回结果
    return {
        rid = rid,
        nickname = nickname
    }
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
    if repak.err then
        debug.error(repak)
    end
    --返回结果
    return {
        rid = rid,
        logolink = logolink
    }
end

---加载联盟信息
function mysqlmanager:loadingAlliance()
    local services = self:getServices()
    local mysql = self._mysql
    ---辅助变量
    local count = 100
    ---加载联盟
    local start = 1
    while true do
        local cmd = format("SELECT * FROM `dballiances`.`alliances` WHERE `allianceID` BETWEEN %d AND %d;",start,start+count)
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
            break
        end
        skynet.call(services.alliance,"lua","allianceInfo",result)
        start = start + count

        ---数据加载完成
        if #result < count then
            break
        end
    end

    ---加载代理
    local start = 1
    while true do
        local cmd = format("SELECT * FROM `dballiances`.`agencys` WHERE `agentID` BETWEEN %d AND %d;",start,start+count)
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
            break
        end
        skynet.call(services.alliance,"lua","agencysInfo",result)
        start = start + count

        ---数据加载完成
        if #result < count then
            break
        end
    end

    ---加载成员
    local start = 1
    while true do
        local cmd = format("SELECT * FROM `dballiances`.`members` WHERE `memberID` BETWEEN %d AND %d;",start,start+count)
        local result = mysql:query(cmd)
        if result.err then
            debug.normal({
                ret = result,
                sql = cmd,
            })
            break
        end
        skynet.call(services.alliance,"lua","membersInfo",result)
        start = start + count

        ---数据加载完成
        if #result < count then
            break
        end
    end

    ---加载完成
    skynet.call(services.alliance,"lua","overAlliance")
end

return mysqlmanager