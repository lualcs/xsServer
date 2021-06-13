--[[
    file:bullHelper.lua 
    desc:只做最简单的功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")
local math = require("extend_math")
local pokerHelper = require("poker.helper")

---@class bullHelper:pokerHelper @扑克辅助
local helper = class(pokerHelper)
local this = helper

---构造函数
function helper:ctor()
end

---比较牌值
---@param card cardPoker @花色
---@return number
function pokerHelper.getLogicValue(card)
    return this.getValue(card)
end

---单牌点数
---@param card pkCard @扑克 
---@return bullNumber
function helper:getPoint(card)
    local value = self:getValue(card)
    return math.min(value,10)
end

return helper