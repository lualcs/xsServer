--[[
    file:assignKilling.lua
    desc:竞赛场
    auth:Caorl Luo
]]

local class = require("class")
local assignSuper = require("assignSuper")

---@class assignKilling @百人分配
local assignKilling = class(assignSuper)
local this = assignKilling

---构造函数
function assignKilling:ctor()
end

return assignKilling