--[[
    file:bullTable.lua 
    desc:扑克桌子
    auth:Carol Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local bullEnum = require("bullEnum")
local pokerTable = require("pokerHelper.pokerTable")
---@class bullTable:pokerTable
local bullTable = class(pokerTable)
local this = bullTable


---构造
function bullTable:ctor()
end

return bullTable