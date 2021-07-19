--[[
    desc:策略
    auth:Carol Luo
]]

local math = math
local pairs = pairs
local class = require("class") 
local reusable = require("reusable")
local table = require("extend_table")
local debug = require("extend_debug")
local gameSystem = require("game.system")
---@class singleSystem:gameSystem
local system = class(gameSystem)
local this = system

---构造 
function system:ctor()
end

return system