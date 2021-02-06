--[[
    file:slotsHelper.lua 
    desc:slots 辅助
    auto:Carol Luo
]]

local string = string
local ipairs = ipairs
local skynet = require("skynet")
local class = require("class")
local gameHelper = require("gameHelper")
---@class slotsHelper:gameHelper
local slotsHelper = class(gameHelper)

---构造函数
function slotsHelper:ctor()

end

---是否scatter图标
---@param icon slots_icon
---@return boolean
function slotsHelper:isScatter(icon)
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return icon == cfg.scatter_icon
end

---是否wild图标
---@param icon slots_icon
---@return boolean
function slotsHelper:isWild(icon)
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return icon == cfg.wild_icon
end

---是否普通图标
---@param icon slots_icon
---@return boolean
function slotsHelper:isNormal(icon)
    return not self:isScatter(icon) and not self:isWild(icon)
end



return slotsHelper

