--[[
    file:jjbx_helper.lua 
    desc:金鸡报喜 
    auth:Caorl Luo
]]

local pairs
local class = require("class")
local slotsHelper = require("slotsHelper")
---@class jjbx_helper
local jjbx_helper = class(slotsHelper)


---构造
function jjbx_helper:ctor()
end

---倍数
---@param wgts weight_info @转轴
function jjbx_helper.getwbexct(wgts)
    local exct = 0
    for cnt,wgt in pairs(wgts.wgt) do
        exct = exct + (cnt * wgt / wgts.sum)
    end
    return exct
end

return jjbx_helper