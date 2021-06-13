--[[
    desc:桌台
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local senum = require("ddz.enum")
local pokerCompetition = require("poker.Competition")
---@class ddz_table:pokerCompetition
local competition = class(pokerCompetition)
local this = competition

---构造
function competition:ctor()
end

---请求
---@param player        ddz_player  @玩家
---@param msg           msgBody @消息
---@return boolean,string|any
function competition:message(player,msg)
    local ok,error = self:super(this,"message",player,msg)
    
    return ok,error
end

return competition