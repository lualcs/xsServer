--[[
    file:sg_helper.lua 
    desc:三公
    auth:Caorl Luo
]]

local class = require("class")
local pokerHelper = require("pokerHelper")
---@class sg_helper:pokerHelper
local sg_helper = class(pokerHelper)
local this = sg_helper

---构造 
function sg_helper:ctor()
end

---获取花色
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper.sgColor(card)
    local c = this.getColor(card)
    return c % 2
end

---获取点数
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper.sgPoint(card)
    local v = this.getValue(card)
    if 15 == v then
        v = 6
    else
        v = v % 10
    end
    return v
end

return sg_helper