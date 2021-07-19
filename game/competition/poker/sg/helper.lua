--[[
    file:sg_helper.lua 
    desc:三公
    auth:Caorl Luo
]]

local class = require("class")
local pokerHelper = require("poker.helper")
---@class sgHelper:pokerHelper
local helper = class(pokerHelper)
local this = helper

---构造 
function helper:ctor()
end

---获取花色
---@param card pokerCard @扑克
---@return pokerColor
function helper.sgColor(card)
    local c = this.getColor(card)
    return c % 2
end

---获取点数
---@param card pokerCard @扑克
---@return pokerColor
function helper.sgPoint(card)
    local v = this.getValue(card)
    if 15 == v then
        v = 6
    else
        v = v % 10
    end
    return v
end

return helper