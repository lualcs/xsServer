--[[
    file:bullType.lua 
    desc:类型判断  所有牌型：  3162510
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local class = require("class")
local sort = require("sort")
local table = require("extend_table")
local bullEnum = require("bull.enum")
local pokerType = require("poker.type")
---@class bullType:pokerType
local type = class(pokerType)

---构造函数
function type:ctor()
end

return type