--[[
    file:pokerTable.lua 
    desc:扑克桌子
    auth:Carol Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local pokerEnum = require("pokerEnum")
local gameTable = require("gameTable")
---@class pokerTable:gameTable
local pokerTable = class(gameTable)
local this = pokerTable


---构造
function pokerTable:ctor()
end

return pokerTable