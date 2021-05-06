--[[
    file:assignHundred.lua
    desc:百人场
    auth:Caorl Luo
]]

local class = require("class")
local assignSuper = require("assignSuper")
local senum = require("gameEnum")

---@class assignHundred @百人分配
local assignHundred = class(assignSuper)
local this = assignHundred

---构造函数
function assignHundred:ctor()
    ---@type name @类名
    self._assignClass = senum.assignHundred()
end

return assignHundred