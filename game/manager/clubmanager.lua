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

---@class clubmanager @gate管理
local clubmanager = class()
local this = clubmanager

---构造
---@param service service_robot         @gate服务
function clubmanager:ctor(service)
    ---联盟管理服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new()
    ---联盟数据
    ---@type clubInfos
    self._clubs = {nil}
    ---联盟数据
    ---@type clubHash
    self._clubHash = {nil}
    ---代理数据
    ---@type adminInfos
    self._admins = {nil}
    ---代理数据
    ---@type adminHash
    self._adminHash = {nil}
    ---成员数据
    ---@type members
    self._members = {nil}
    ---@type memberHash
    self._memberHash = {nil}
    ---@type memberHashByUserID
    self._memberUser = {nil}
end

---重置
function clubmanager:dataReboot()
end

---服务
---@return serviceInf @服务信息
function clubmanager:getServices()
    return self._service._services
end


---上线
---@param rid userID @用户ID
---@param loginCount count @登录次数
function clubmanager:online(rid,fd)
    local members = self._memberUser[rid]
    if not members then
        return
    end

    for _,member in ipairs(members) do
        ---联盟在线人数
        local club = self._clubHash[member.clubID]
        if not club then
            return
        end

        club.onlineMapping[rid] = fd
        club.onlineNumber = club.onlineNumber + 1
        ---代理在线人数
        local admin = self._adminHash[member.agentID]
        admin.onlineMapping[rid] = fd
        admin.onlineNumber = admin.onlineNumber + 1
        ---成员在线标志
        member.online = true

        ---发送成员信息
    end
end

---断线
---@param rid userID @用户ID
function clubmanager:offline(rid)
    local members = self._memberUser[rid]
    if not members then
        return
    end

    for _,member in ipairs(members) do
        ---联盟在线人数
        local club = self._clubHash[member.clubID]
        if not club then
            return
        end

        club.onlineMapping[rid] = nil
        club.onlineNumber = club.onlineNumber - 1
        ---代理在线人数
        local admin = self._adminHash[member.agentID]
        admin.onlineMapping[rid] = nil
        admin.onlineNumber = admin.onlineNumber - 1
        ---成员在线标志
        member.online = false
    end
end

---联盟数据
---@param ret clubInfos @联盟信息
function clubmanager:clubInfo(ret)
    local list = self._clubs
    local hash = self._clubHash
    for _,info in ipairs(ret) do
        ---解析数据
        info.assignRule = cjson.decode(info.assignRule)
        info.gameInfos = cjson.decode(info.gameInfos)
        table.insert(list,info)
        hash[info.clubID] = info

        ---组织数据
        ---@type clubData
        local data = info
        data.adminHash     = {nil}
        data.memberHash     = {nil}
        data.adminList     = {nil}
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
---@param ret adminInfos @联盟信息
function clubmanager:adminsInfo(ret)
    local list = self._admins
    local hash = self._adminHash
    for _,info in ipairs(ret) do
        ---解析数据
        table.insert(list,info)
        hash[info.clubID] = info

        ---组织数据
        ---@type adminData
        local data = info
        data.memberHash     = {nil}
        data.memberList     = {nil}
        data.onlineMapping  = {nil}
        ---填充代理
        ---@type clubData
        local targe = self._clubHash[data.clubID]
        table.insert(targe.adminList,data)
        targe.adminHash[data.agentID] = data
        data.onlineNumber   = 0
        data.combatNumber   = 0
    end
end

---成员数据
---@param ret memberInfos @联盟信息
function clubmanager:membersInfo(ret)
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
        ---@type clubData
        local club = self._clubHash[data.clubID]
        table.insert(club.memberList,data)

        ---填充代理
        local targe = club.adminHash[data.agentID]
        table.insert(targe.memberList,data)
        targe.memberHash[data.memberID] = data
    end
end

---加载完成
function clubmanager:overclub()
    ---全局服务
    local services = self:getServices()
    ---分配管理
    local assigns = {senum.assignSingle(),senum.assignHundred(),senum.assignKilling()}
    
    for clubID,info in pairs(self._clubHash) do
        for index,assignClass in ipairs(assigns) do
           self:assignCtor(assignClass,clubID)
        end
    end

    skynet.error("clubmanager finish")
end

local assignKyes = {
    [senum.assignSingle()] = "assignSingle",
    [senum.assignHundred()] = "assignHundred",
    [senum.assignKilling()] = "assignKilling",
}
---构建分配服务
function clubmanager:assignCtor(assignClass,clubID)
    local service = skynet.newservice("service_assign")
    skynet.call(service,"lua","start",assignClass,clubID)
    skynet.call(service,"lua","mapServices",senum.mapServices())
    skynet.call(service,"lua","multicast")
    skynet.call(service,"lua","dataReboot")
    ---所有分配服务
    local info = self._clubHash[clubID]
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
function clubmanager:message(fd,rid,msg)
    local cmd = table.remove(msg.cmds)
    if senum.c2s_clubClubs() == cmd then
        self:c2s_clubClubs(fd,rid,msg)
    elseif senum.c2s_clubClubs() == cmd then
        self:c2s_clubClubs(fd,rid,msg)
    end
end


---请求
---@param fd   socket         @套接字
---@param rid  userID         @用户ID
function clubmanager:c2s_clubClubs(fd,rid,msg)
    
    ---系统联盟
    if  not self._memberUser[rid] then
        local services = self:getServices()
        skynet.send(services.mysql,"lua","applyForInSystemclub",fd,rid,msg)
        return
    end

    local packs = {nil}
    ---联盟列表
    ---@type s2c_clubClub[]
    local clubs = {nil}
    packs.clubs = clubs
    ---数据信息
    ---@type memberData[]
    local list = self._memberUser[rid]
    debug.error(list)
    for _,member in ipairs(list) do
        local club = self._clubHash[member.clubID]
        local admin = self._adminHash[member.agentID]
        table.insert(clubs,{
            club = {
                clubID      = club.clubID,
                clubName    = club.name,
                personality     = club.personality,
                logoGs          = club.logoGs,
                memberNumber    = #club.memberList,
                onlineNumber    = club.onlineNumber,
                combatNumber    = club.combatNumber,
            },
            admin = {
                agentID         = admin.agentID,
                memberNumber    = #admin.memberList,
                onlineNumber    = admin.onlineNumber,
                combatNumber    = admin.combatNumber,
            },
            member = {
                memberID = member.memberID,
                office = member.office
            },
        })
    end
    ---发送数据
    websocket.sendpbc(fd,senum.s2c_clubClubs(),{senum.login()},packs)
end

return clubmanager