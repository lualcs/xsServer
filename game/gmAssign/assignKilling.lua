--[[
    file:assignKilling.lua
    desc:竞赛场
    auth:Caorl Luo
]]

local skynet = require("skynet")
local class = require("class")
local debug = require("extend_debug")
local assignSuper = require("assignSuper")
local senum = require("gameEnum")

---@class assignKilling:assignSuper @百人分配
local assignKilling = class(assignSuper)
local this = assignKilling

---构造函数
function assignKilling:ctor()
    ---@type name @类名
    self._assignClass = senum.assignKilling()
end

return assignKilling