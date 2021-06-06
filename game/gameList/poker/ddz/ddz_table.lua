--[[
    desc:桌台
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local senum = require("ddz.ddz_enum")
local pokerTable = require("pokerTable")
---@class ddz_table:pokerTable
local ddz_table = class(pokerTable)
local this = ddz_table

---构造
function ddz_table:ctor()
end

---请求
---@param player        ddz_player  @玩家
---@param msg           msgBody @消息
---@return boolean,string|any
function ddz_table:message(player,msg)
    local ok,error = self:super(this,"message",player,msg)
    
    return ok,error
end

return ddz_table