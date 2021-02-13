--[[
    file:dz_helper.lua 
    desc:扯旋
    auth:Caorl Luo
]]

local class = require("class")
local pokerHelper = require("pokerHelper")
---@class dz_helper:pokerHelper
local dz_helper = class(pokerHelper)
local this = dz_helper

---构造 
function dz_helper:ctor()
end

---获取花色
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper.dzColor(card)
    local c = this.getColor(card)
    return c % 2
end

---获取点数
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper.dzPoint(card)
    local v = this.getValue(card)
    if 15 == v then
        v = 6
    else
        v = v % 10
    end
    return v
end

return dz_helper