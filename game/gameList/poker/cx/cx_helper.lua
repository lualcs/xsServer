--[[
    file:cx_helper.lua 
    desc:扯旋
    auth:Caorl Luo
]]

local class = require("class")
local pokerHelper = require("pokerHelper")
---@class cx_helper:pokerHelper
local cx_helper = class(pokerHelper)
local this = cx_helper

---构造 
function cx_helper:ctor()
end

---获取花色
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper.cxColor(card)
    local c = this.getColor(card)
    return c % 2
end

---获取点数
---@param card pokerCard @扑克
---@return pokerColor
function pokerHelper.cxPoint(card)
    local v = this.getValue(card)
    if 15 == v then
        v = 6
    else
        v = v % 10
    end
    return v
end

return cx_helper