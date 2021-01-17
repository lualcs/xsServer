--[[
    file:assignSingle.lua
    desc:单人
    auth:Caorl Luo
]]


local class = require("class")
local gameEnum = require("gameEnum")
local assignSuper = require("assignSuper")

---@class assignSingle @单机分配
local assignSingle = class(assignSuper)
local this = assignSingle

---构造函数
function assignSingle:ctor()
    ---@type name @类名
    self._assignClass = gameEnum.assignSingle()
end

return assignSingle