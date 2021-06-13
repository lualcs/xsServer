---@class msgHead           @消息头
---@field name  string      @消息体
---@field cmds  senum[]     @命令表

---@class msgBody
---@field cmds  senum[]     @命令表 
---@field info  table       @数据表 


---@class s2c_clubInfo  @联盟信息
---@field clubID    clubID  @联盟ID
---@field clubName  name        @联盟名字
---@field personality   string      @联盟签名
---@field memberNumber  count       @成员数量
---@field combatNumber  count       @对局数量


---@class s2c_agencyInfo  @联盟信息
---@field agentID       agentID     @代理ID
---@field memberNumber  count       @成员数量 
---@field memberNumber  count       @成员数量
---@field combatNumber  count       @对局数量

---@class s2c_memberInfo @联盟成员
---@field memberID      mermberID   @成员ID
---@field office        senum       @成员身份


---@class s2c_clubClub @俱乐部信息
---@field club  s2c_clubInfo @联盟信息 
---@field agency    s2c_agencyInfo   @联盟信息 
---@field member    s2c_memberInfo   @成员信息 
---@field logoGs    url[]            @成员头像

---@class s2c_clubClubs @俱乐部信息
---@field clubs  s2c_clubClub[] @联盟信息 

