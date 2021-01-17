--[[
    file:pokerStruct.lua 
    desc:扑克结构
    auth:Carol Luo
]]

---@alias pkCard number
---扑克 

---@alias pkValue number
---牌值 

---@alias pkColor number
---花色 


---@class pkMethod @扑克分析
---@field singles   pkCard[]    @单牌
---@field doubles   pkCard[]    @对牌
---@field triples   pkCard[]    @三条
---@field fourles   pkCard[]    @铁支