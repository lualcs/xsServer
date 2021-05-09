--[[
    desc:联盟结构
    auth:Carol Luo
]]

---@alias allianceID number 
---联盟ID
---@alias agentID number 
---代理ID
---@alias memberID number 
---成员ID


---@class allianceInfo              @联盟信息
---@field allianceID    allianceID  @盟主标识
---@field name          name        @盟主昵称
---@field rid           userID      @盟主用户
---@field assignRule    json        @分配规则
---@field gameInfos     json        @创建日期
---@field birthday      string      @创建日期

---@alias allianceInfos allianceInfo[]

---@class agencyInfo                @代理信息
---@field agentID       agentID     @代理标识
---@field rid           userID      @盟主用户
---@field allianceID    allianceID  @联盟标识
---@field birthday      string      @创建日期

---@alias agencyInfos agencyInfo[]


---@class memberInfo
---@field memberID      number      @成员标识
---@field rid           userID      @成员用户
---@field identity      senum       @成员身份
---@field superiorID    agentID     @上级代理
---@field allianceID    allianceID  @所属联盟
---@field birthday      string      @创建日期

---@alias memberInfos memberInfo[]
---@field online    boolean     @是否在线


---@class allianceData:allianceInfo                     @联盟数据
---@field agencyHash        table<agentID,agencyData>   @代理信息
---@field memberHash        table<memberID,memberData>  @成员信息
---@field agencyList        agencyData[]                @代理列表
---@field memberList        memberData[]                @成员列表
---@field assignList        service[]                   @分配服务
---@field assignSingles     service[]                   @单机分配
---@field assignHundreds    service[]                   @百人分配
---@field assignKillings    service[]                   @竞争分配
---@field onlineMember      count                       @在线成员


---@class agencyData:agencyInfo @代理数据
---@field memberHash        table<memberID,memberData>  @成员信息
---@field memberList        memberData[]                @成员列表
---@field onlineMember      count                       @在线成员

---@class memberData:memberInfo @代理数据




---@alias allianceHash table<allianceID,allianceData>
---联盟映射
---@alias agencyHash table<agentID,agencyData>
---代理映射
---@alias memberHash table<memberID,memberData>
---成员映射
---@alias memberHashByUserID table<userID,memberData>
---成员映射


