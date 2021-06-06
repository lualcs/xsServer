--[[
    file:mysqlmanager.lua 
    desc:mysql处理
    auth:Caorl Luo
]]

local ipairs = ipairs
local format = string.format
local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local mysql = require("api_mysql")
local string = require("extend_string")
local table = require("extend_table")
local debug = require("extend_debug")
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

end

---重置
function mysqlmanager:dataReboot()
    ---初始化数据库
    self:dbstructure()
    ---读取联盟数据
    self:fetchClubs()
    ---读取机器数据
    self:feachRobot()
    
    skynet.error("mysqlmanager finish")
end

---服务
---@return serviceInf @服务信息
function mysqlmanager:getServices()
    return self._service._services
end

---构造数据库
function mysqlmanager:dbstructure()
    ---执行语句
    local mysql = self._mysql

    ---库存头像
    local name = "mysql.dbstructure"
    local dirs = require(name)
    _G.package.loaded[name] = nil

    ---执行命令
    for _,name in ipairs(dirs) do
        local list = require(name)
        _G.package.loaded[name] = nil
        for _,cmd in ipairs(list) do
            local ret = mysql:query(cmd)
            if ret.err then
                debug.logServiceMySQL({
                    ret = ret,
                    sql = cmd,
                })
                goto leave
            end
        end
    end
    ::leave::
end

---机器登录
---@param rid userID @机器角色
function mysqlmanager:robotLogin(rid)
    ---拼接语句
    local sqlex = format([[CALL dbaccounts.procedureLoginRobot("%d");]],rid)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
        return
    end
    --返回结果
    return repak[1][1]
end

---游客登陆
---@param accredit string @登录凭证
function mysqlmanager:touristsLogin(accredit)
    ---拼接语句
    local sqlex = format([[CALL dbaccounts.procedureLoginTourists("%s");]],accredit)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
        return
    end
    --返回结果
    return repak[1][1]
end

---手机登陆
---@param phonenum string @手机号码
---@param password string @登录密码
function mysqlmanager:phoneLogin(phonenum,password)
    ---拼接语句
    local sqlex = format([[CALL dbaccounts.procedureLoginPhone("%s","%s");]],phonenum,password)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
        return
    end
    return repak[1][1]
end

---微信登陆
---@param accredit string @登录凭证
function mysqlmanager:wechatLogin(accredit)
    ---拼接语句
    local sqlex = format([[CALL dbaccounts.procedureLoginWechat("%s");]],accredit)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
        return
    end
    return repak[1][1]
end

---更新昵称
---@param rid       number  @角色ID
---@param nickname  string  @更新昵称
function mysqlmanager:changeNickname(rid,nickname)
    ---拼接语句
    local sqlex = format([[UPDATE `dbaccounts`.`accounts` SET `nickname` = "%s"WHERE `rid` = %d;]],nickname,rid)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
        return
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
    local sqlex = format([[UPDATE `dbaccounts`.`accounts` SET `logo` = "%s"WHERE `rid` = %d;]],logolink,rid)

    ---执行语句
    local mysql = self._mysql
    local repak = mysql:query(sqlex)
    if repak.err then
        debug.error(repak)
        return
    end
    --返回结果
    return {
        rid = rid,
        logolink = logolink
    }
end

---加载联盟信息
function mysqlmanager:fetchClubs()
    local services = self:getServices()
    local mysql = self._mysql

    local loadings = {
        {
            serviceid = services.alliance,
            methodnam = "allianceInfo",
            cmdFormat = 
            [[
                SELECT * FROM `dballiances`.`alliances` WHERE `allianceID` BETWEEN %d AND %d;
                SELECT MIN(`allianceID`) AS `start` FROM `dballiances`.`alliances` WHERE `allianceID` > %d;
            ]],

            cmdHead = [[
                SELECT 
                    `ac`.`logo`
                FROM 
                	`dballiances`.`members` AS `me` 
                	INNER JOIN 
                	`dbaccounts`.`accounts` AS `ac` 
                	ON `me`.`rid` = `ac`.`rid`
                WHERE `me`.`allianceID` = %d ORDER BY `me`.`memberID` LIMIT 9;
            ]]
        },

        {
            serviceid = services.alliance,
            methodnam = "agencysInfo",
            cmdFormat = 
            [[
                SELECT * FROM `dballiances`.`agencys` WHERE `agentID` BETWEEN %d AND %d;
                SELECT MIN(`agentID`) AS `start` FROM `dballiances`.`agencys` WHERE `agentID` > %d;
            ]],
        },

        {
            serviceid = services.alliance,
            methodnam = "membersInfo",
            cmdFormat = 
            [[
                SELECT * FROM `dballiances`.`members` WHERE `memberID` BETWEEN %d AND %d;
                SELECT MIN(`memberID`) AS `start` FROM `dballiances`.`members` WHERE `memberID` > %d;
            ]],
        },
    }

    for _,info in ipairs(loadings) do
        local start = 1
        local close = 100
        while true do
            local cmd = format(info.cmdFormat,start,close,close)
            local ret = mysql:query(cmd)
            --执行错误
            if ret.err then
                debug.logServiceMySQL({
                    ret = ret,
                    sql = cmd,
                })
                goto leave
            end

            local list = ret[1]
            if "allianceInfo" == info.methodnam  then
                for _,club in ipairs(list) do
                    local logoPack = mysql:query(format(info.cmdHead,club.allianceID))
                    local logoGs = {nil}
                    for _,iter in ipairs(logoPack) do
                        table.insert(logoGs,iter.logo)
                    end
                    club.logoGs = logoGs
                end
            end

            ---通知数据
            skynet.call(services.alliance,"lua",info.methodnam,list)

            --加载完成
            local step = ret[2]
            if table.empty(step) then
                break
            elseif table.empty(step[1]) then
                break
            end
            ---下次信息
            start = step[1].start
            close = start + 100 - 1
        end
    end


    ::leave::

    ---加载完成
    skynet.call(services.alliance,"lua","overAlliance")
end

---请求
---@param rid  userID         @用户ID
function mysqlmanager:applyForInSystemAlliance(fd,rid,msg)
    local services = self:getServices()
    local mysql = self._mysql
    local excmd = format([[CALL `dballiances`.`procedureApplyForInSystemAlliance`(%d);]],rid)
    local ret = mysql:query(excmd)
    if ret.err then
        debug.normal({
            ret = ret,
            sql = excmd,
        })
        return
    end

    local list = ret[1]
    if table.empty(list) then
        debug.normal("empty list:",list)
    end

    skynet.call(services.alliance,"lua","membersInfo",list)
    skynet.call(services.alliance,"lua","c2s_allianceClubs",fd,rid,msg)
end


---读取机器人数据
function mysqlmanager:feachRobot()
    local services = self:getServices()
    local mysql = self._mysql
    local rlist = {nil}
    local start = 0
    while true do
        ---查询数据
        local cmd = format([[SELECT * FROM `dbaccounts`.`bind_robots` WHERE `rid` > %d ORDER BY `rid` LIMIT 100;]],start)
        local ret = mysql:query(cmd)
        ---结束检查
        if ret.err then
            debug.normal({
                ret = ret,
                sql = cmd,
            })
            break
        end

        if table.empty(ret) then
            break
        end

        table.clear(rlist)
        for _,inf in ipairs(ret) do
            table.insert(rlist,inf.rid)
        end

        start = rlist[#rlist]

        ---回调机器人
        skynet.send(services.robot,"lua","feachRobotList",rlist)
    end
end

return mysqlmanager