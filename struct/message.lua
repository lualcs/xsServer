---@class msgHead           @消息头
---@field name  string      @消息体
---@field cmds  senum[]     @命令表

---@class msgBody
---@field cmds  senum[]     @命令表 
---@field info  table       @数据表 


---@class s2c_allianceInfo  @联盟信息
---@field allianceID    allianceID  @联盟ID
---@field allianceName  name        @联盟名字
---@field memberNumber  count       @成员数量


---@class s2c_agencyInfo  @联盟信息
---@field agentID       agentID     @代理ID
---@field userID        userID      @所属成员
---@field nickname      name        @代理昵称
---@field memberNumber  count       @成员数量 

---@class s2c_memberInfo @联盟成员
---@field memberID      mermberID   @成员ID
---@field userID        userID      @成员角色
---@field nickname      name        @成员昵称
---@field identity      senum       @成员身份