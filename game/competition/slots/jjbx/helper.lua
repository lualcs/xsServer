--[[
    desc:金鸡报喜 
    auth:Caorl Luo
]]

local pairs
local class = require("class")
local slotsHelper = require("slots.helper")
---@class jjbxHelper
local helper = class(slotsHelper)

---构造
function helper:ctor()
end

---倍数
---@param wgts weight_info @转轴
function helper.getwbexct(wgts)
    local exct = 0
    for cnt,wgt in pairs(wgts.wgt) do
        exct = exct + (cnt * wgt / wgts.sum)
    end
    return exct
end

return helper