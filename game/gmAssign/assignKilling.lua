--[[
    file:assignKilling.lua
    desc:竞赛场
    auth:Caorl Luo
]]

local skynet = require("skynet")
local class = require("class")
local debug = require("extend_debug")
local assignSuper = require("assignSuper")

---@class assignKilling:assignSuper @百人分配
local assignKilling = class(assignSuper)
local this = assignKilling

---构造函数
function assignKilling:ctor()
end

return assignKilling