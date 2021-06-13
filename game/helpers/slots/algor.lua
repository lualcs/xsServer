--[[
    file:slotsAlgor.lua 
    desc:slots算法
    auth:Caorl Luo
]]

local class = require("class")
local gameAlgor = require("game.algor")
---@class slotsAlgor:gameAlgor
local algor = class(gameAlgor)
local this = algor

---构造
function algor:ctor()
end

---普通图标轴概率
---@param nWgt              slots_weight  @普通图标轴权重
---@param wWgt              slots_weight  @wild图标轴权重
---@param fWgt              slots_weight  @免费图标轴权重
---@param sWgt              slots_weight  @轴总图标轴权重
---@param fPro              slots_axlepro @免费图标轴概率
---@return slots_axlepro          @轴概率
function algor.normatAxlePro(nWgt,wWgt,fWgt,sWgt,fPro)
    ---@type slots_weight @总权重-免费图标权重
    local snwgt = sWgt - sWgt
    return (nWgt+wWgt)/snwgt*(1-(fPro/3))
end

---wild图标轴概率
---@param wWgt              slots_weight  @wild图标轴权重
---@param sWgt              slots_weight  @轴总图标轴权重
---@param fPro              slots_axlepro @免费图标轴概率
---@return slots_axlepro        @轴概率
function algor.wildAxlePro(wWgt,sWgt,fPro)
    ---@type slots_weight @总权重-免费图标权重
    local snwgt = sWgt - sWgt
    return wWgt/snwgt*(1-(fPro/3))
end

---scatter图标轴概率
---@param fWgt              slots_weight @免费图标轴权重
---@param sWgt              slots_weight @所有图标轴权重
function algor.scatterAxlePro(fWgt,sWgt)
    local x = fWgt/sWgt
    return x+(1-x)*x+(1-x-(1-x)*x)*x
end

return algor