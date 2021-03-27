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
local pokerHelper = require("pokerHelper")

---@class bullHelper:pokerHelper @扑克辅助
local bullHelper = class(pokerHelper)
local this = bullHelper

---构造函数
function bullHelper:ctor()
end

---单牌点数
---@param card pkCard @扑克 
---@return bullNumber
function bullHelper:getPoint(card)
    local value = self:getValue(card)
    return math.min(value,10)
end

return bullHelper