--[[
    desc:邮件结构
    auth:Carol Luo
]]

---@class  goods        @物品
---@field  id   number  @道具ID

---@class affix:goods   @附件
---@field count         count   @道具数量
---@field signFor       boolean @是否签收


---@class email     @邮件结构
---@field title     string  @邮件标题
---@field descr     string  @邮件内容
---@field affix     affix[] @邮件附件
---@field date      string  @邮件日期
---@field indate    string  @失效日期
---@field read      boolean @是否读取

---@class mongoEmail @mongo邮件
---@field email     email    @邮件数据
---@field rid       userID   @邮件主人
---@field _id       ObjectId @mongo主键