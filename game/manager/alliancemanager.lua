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
local websocket = require("api_websocket")

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
    ---@type memberHashByUserID
    self._memberUser = {nil}
end

---重置
function alliancemanager:dataReboot()
end

---服务
---@return serviceInf @服务信息
function alliancemanager:getServices()
    return self._service._services
end


---上线
---@param rid userID @用户ID
---@param loginCount count @登录次数
function alliancemanager:online(rid,fd)
    local members = self._memberUser[rid]
    if not members then
        return
    end

    for _,member in ipairs(members) do
        ---联盟在线人数
        local alliance = self._allianceHash[member.allianceID]
        if not alliance then
            return
        end

        alliance.onlineMapping[rid] = fd
        alliance.onlineNumber = alliance.onlineNumber + 1
        ---代理在线人数
        local agency = self._agencyHash[member.agentID]
        agency.onlineMapping[rid] = fd
        agency.onlineNumber = agency.onlineNumber + 1
        ---成员在线标志
        member.online = true

        ---发送成员信息
    end
end

---断线
---@param rid userID @用户ID
function alliancemanager:offline(rid)
    local members = self._memberUser[rid]
    if not members then
        return
    end

    for _,member in ipairs(members) do
        ---联盟在线人数
        local alliance = self._allianceHash[member.allianceID]
        if not alliance then
            return
        end

        alliance.onlineMapping[rid] = nil
        alliance.onlineNumber = alliance.onlineNumber - 1
        ---代理在线人数
        local agency = self._agencyHash[member.agentID]
        agency.onlineMapping[rid] = nil
        agency.onlineNumber = agency.onlineNumber - 1
        ---成员在线标志
        member.online = false
    end
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
        data.agencyHash     = {nil}
        data.memberHash     = {nil}
        data.agencyList     = {nil}
        data.memberList     = {nil}
        data.assignList     = {nil}
        data.onlineMapping  = {nil}
        data.assignSingle   = nil
        data.assignHundred  = nil
        data.assignKilling  = nil
        data.onlineNumber   = 0
        data.combatNumber   = 0
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
        data.memberHash     = {nil}
        data.memberList     = {nil}
        data.onlineMapping  = {nil}
        ---填充代理
        ---@type allianceData
        local targe = self._allianceHash[data.allianceID]
        table.insert(targe.agencyList,data)
        targe.agencyHash[data.agentID] = data
        data.onlineNumber   = 0
        data.combatNumber   = 0
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
        local members = self._memberUser[info.rid] or {nil}
        self._memberUser[info.rid] = members
        table.insert(members,info)

         ---组织数据
        ---@type memberData
        local data = info

        ---填充联盟
        ---@type allianceData
        local alliance = self._allianceHash[data.allianceID]
        table.insert(alliance.memberList,data)

        ---填充代理
        local targe = alliance.agencyHash[data.agentID]
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
    
    for allianceID,info in pairs(self._allianceHash) do
        for index,assignClass in ipairs(assigns) do
           self:assignCtor(assignClass,allianceID)
        end
    end

    skynet.error("alliancemanager finish")
end

local assignKyes = {
    [senum.assignSingle()] = "assignSingle",
    [senum.assignHundred()] = "assignHundred",
    [senum.assignKilling()] = "assignKilling",
}
---构建分配服务
function alliancemanager:assignCtor(assignClass,allianceID)
    local service = skynet.newservice("service_assign")
    skynet.call(service,"lua","start",assignClass,allianceID)
    skynet.call(service,"lua","mapServices",senum.mapServices())
    skynet.call(service,"lua","multicast")
    skynet.call(service,"lua","dataReboot")
    ---所有分配服务
    local info = self._allianceHash[allianceID]
    table.insert(info.assignList,service)
    ---单机分配
    local key = assignKyes[assignClass]
    assert(not info[key],"重复分配服务")
    info[key] = service
end


---请求
---@param fd   socket         @套接字
---@param rid  userID         @用户ID
---@param msg  msgBody        @数据
function alliancemanager:message(fd,rid,msg)
    local cmd = table.remove(msg.cmds)
    if senum.c2s_allianceClubs() == cmd then
        self:c2s_allianceClubs(fd,rid,msg)
    elseif senum.c2s_allianceClubs() == cmd then
        self:c2s_allianceClubs(fd,rid,msg)
    end
end


---请求
---@param fd   socket         @套接字
---@param rid  userID         @用户ID
function alliancemanager:c2s_allianceClubs(fd,rid,msg)
    
    ---系统联盟
    if  not self._memberUser[rid] then
        local services = self:getServices()
        skynet.send(services.mysql,"lua","applyForInSystemAlliance",fd,rid,msg)
        return
    end

    local packs = {nil}
    ---联盟列表
    ---@type s2c_allianceClub[]
    local clubs = {nil}
    packs.clubs = clubs
    ---数据信息
    ---@type memberData[]
    local list = self._memberUser[rid]
    debug.error(list)
    for _,member in ipairs(list) do
        local alliance = self._allianceHash[member.allianceID]
        local agency = self._agencyHash[member.agentID]
        table.insert(clubs,{
            alliance = {
                allianceID      = alliance.allianceID,
                allianceName    = alliance.name,
                personality     = alliance.personality,
                logoGs          = alliance.logoGs,
                memberNumber    = #alliance.memberList,
                onlineNumber    = alliance.onlineNumber,
                combatNumber    = alliance.combatNumber,
            },
            agency = {
                agentID         = agency.agentID,
                memberNumber    = #agency.memberList,
                onlineNumber    = agency.onlineNumber,
                combatNumber    = agency.combatNumber,
            },
            member = {
                memberID = member.memberID,
                office = member.office
            },
        })
    end
    ---发送数据
    websocket.sendpbc(fd,senum.s2c_allianceClubs(),{senum.login()},packs)
end

return alliancemanager