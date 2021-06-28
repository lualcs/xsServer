--[[
    desc:扑克结构
    auth:Carol Luo
]]

---@alias pkCard number
---扑克 

---@alias pkValue number
---牌值 

---@alias pkColor number
---花色 


---@class pokerLayout @扑克分析
---@field singles   pkCard[]    @单牌
---@field doubles   pkCard[]    @对牌
---@field triples   pkCard[]    @三条
---@field tetrads   pkCard[]    @铁支
---@field laizis    pkCard[]    @癞子
---@field pokers    pkCard[]    @扑克
---@field repeas    pkCard[]    @映射