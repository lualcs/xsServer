--[[
    desc:联盟结构
    auth:Carol Luo
]]

---@alias clubID number 
---联盟ID
---@alias agentID number 
---代理ID
---@alias memberID number 
---成员ID


---@class clubInfo              @联盟信息
---@field clubID    clubID  @盟主标识
---@field name          name        @联盟昵称
---@field rid           userID      @盟主用户
---@field logoGs        url[]       @展示头像
---@field assignRule    json        @分配规则
---@field gameInfos     json        @创建日期
---@field birthday      string      @创建日期

---@alias clubInfos clubInfo[]

---@class agencyInfo                @代理信息
---@field agentID       agentID     @代理标识
---@field rid           userID      @盟主用户
---@field clubID    clubID  @联盟标识
---@field birthday      string      @创建日期

---@alias agencyInfos agencyInfo[]


---@class memberInfo
---@field memberID      number      @成员标识
---@field rid           userID      @成员用户
---@field office        senum       @成员身份
---@field agentID       agentID     @上级代理
---@field clubID    clubID  @所属联盟
---@field birthday      string      @创建日期

---@alias memberInfos memberInfo[]



---@class clubData:clubInfo                     @联盟数据
---@field agencyHash        table<agentID,agencyData>   @代理信息
---@field memberHash        table<memberID,memberData>  @成员信息
---@field agencyList        agencyData[]                @代理列表
---@field memberList        memberData[]                @成员列表
---@field assignList        service[]                   @分配服务
---@field assignSingle      service[]                   @单机分配
---@field assignHundred     service[]                   @百人分配
---@field assignKilling     service[]                   @竞争分配
---@field onlineMapping     table<rid,fd>               @在线映射
---@field onlineNumber      count                       @在线成员
---@field combatNumber      count                       @对局数量


---@class agencyData:agencyInfo @代理数据
---@field memberHash        table<memberID,memberData>  @成员信息
---@field memberList        memberData[]                @成员列表
---@field onlineMapping     table<rid,fd>               @在线映射
---@field onlineNumber      count                       @在线成员
---@field combatNumber      count                       @对局数量

---@class memberData:memberInfo @成员数据
---@field online    boolean     @是否在线




---@alias clubHash table<clubID,clubData>
---联盟映射
---@alias agencyHash table<agentID,agencyData>
---代理映射
---@alias memberHash table<memberID,memberData>
---成员映射
---@alias memberHashByUserID table<userID,memberData[]>
---成员映射


