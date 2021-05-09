--[[
    desc:联盟管理
    auth:Caorl Luo
]]

local pairs = pairs
local ipairs = ipairs
local cjson = require("api_json")
local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("managerEnum")

---@class alliancemanager @gate管理
local alliancemanager = class()
local this = alliancemanager

---构造
---@param service service_robot         @gate服务
function alliancemanager:ctor(service)
    ---联盟管理服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new()
    ---联盟数据
    ---@type allianceInfos
    self._alliances = {nil}
    ---联盟数据
    ---@type allianceHash
    self._allianceHash = {nil}
    ---代理数据
    ---@type agencyInfos
    self._agencys = {nil}
    ---代理数据
    ---@type agencyHash
    self._agencyHash = {nil}
    ---成员数据
    ---@type members
    self._members = {nil}
    ---@type memberHash
    self._memberHash = {nil}
end

---重置
function alliancemanager:dataReboot()
    ---启动定时器
    self._timer:poling()
    ---加载联盟信息
    self:loadingAlliance()
end

---服务
---@return serviceInf @服务信息
function alliancemanager:getServices()
    return self._service._services
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody @数据
function alliancemanager:message(fd,msg)
  
end

---加载联盟
function alliancemanager:loadingAlliance()
    local services = self:getServices()
    skynet.send(services.mysql,"lua","loadingAlliance")
end

---联盟数据
---@param ret allianceInfos @联盟信息
function alliancemanager:allianceInfo(ret)
    local list = self._alliances
    local hash = self._allianceHash
    for _,info in ipairs(ret) do
        ---解析数据
        info.assignRule = cjson.decode(info.assignRule)
        info.gameInfos = cjson.decode(info.gameInfos)
        table.insert(list,info)
        hash[info.allianceID] = info

        ---组织数据
        ---@type allianceData
        local data = info
        data.agencyHash = {nil}
        data.memberHash = {nil}
        data.agencyList = {nil}
        data.memberList = {nil}
        data.assignList = {nil}
        data.assignSingles  = {nil}
        data.assignHundreds = {nil}
        data.assignKillings = {nil}
    end
end

---代理数据
---@param ret agencyInfos @联盟信息
function alliancemanager:agencysInfo(ret)
    local list = self._agencys
    local hash = self._agencyHash
    for _,info in ipairs(ret) do
        ---解析数据
        table.insert(list,info)
        hash[info.allianceID] = info

        ---组织数据
        ---@type agencyData
        local data = info
        data.memberHash = {nil}
        data.memberList = {nil}

        ---填充代理
        ---@type allianceData
        local targe = self._allianceHash[data.allianceID]
        table.insert(targe.agencyList,data)
        targe.agencyHash[data.agentID] = data

    end
end

---成员数据
---@param ret memberInfos @联盟信息
function alliancemanager:membersInfo(ret)
    local list = self._members
    local hash = self._memberHash
    for _,info in ipairs(ret) do
        ---保存数据
        table.insert(list,info)
        hash[info.memberID] = info

         ---组织数据
        ---@type memberData
        local data = info

        ---填充代理
        ---@type allianceData
        local alliance = self._allianceHash[data.allianceID]
        local targe = alliance.agencyHash[data.superiorID]
        table.insert(targe.memberList,data)
        targe.memberHash[data.memberID] = data
    end
end

---加载完成
function alliancemanager:overAlliance()
    ---全局服务
    local services = self:getServices()
    ---分配管理
    local assigns = {senum.assignSingle(),senum.assignHundred(),senum.assignKilling()}
    local assignKyes = {"assignSingles","assignHundreds","assignKillings"}
    for allianceID,info in pairs(self._allianceHash) do
        for index,assignClass in ipairs(assigns) do
            local service = skynet.newservice("service_assign")
            skynet.call(service,"lua","start",assignClass,allianceID)
            skynet.call(service,"lua","mapServices",senum.mapServices())
            skynet.call(service,"lua","multicast")
            skynet.call(service,"lua","dataReboot")
            ---所有分配服务
            table.insert(info.assignList,service)
            ---单机分配
            local key = assignKyes[index]
            table.insert(info[key],service)
        end
    end

    ---gate服务 开始监听
    skynet.call(services.gates,"lua","listen")
end

function alliancemanager:assignCtor()
     ---单机游戏
     local service = skynet.newservice("service_assign")
     skynet.call(service,"lua","start",senum.assignSingle())
 
     ---百人游戏
     local service = skynet.newservice("service_assign")
     skynet.call(service,"lua","start",senum.assignHundred())
 
     ---竞技游戏
     local service = skynet.newservice("service_assign")
     skynet.call(service,"lua","start",senum.assignKilling())
end

return alliancemanager