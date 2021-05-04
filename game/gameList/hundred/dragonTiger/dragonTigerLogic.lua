--[[
    desc:龙虎
    auth:Carol Luo
]]

local math = math
local table = table
local pairs = pairs
local ipairs = ipairs
local random = require("random")
local class = require("class")
local is_number = require("is_number")
local hundredLogic = require("hundredLogic")
local senum = require("dragonTiger.dragonTigerEnum")
---@class drangonTigerLogic:hundredLogic
local drangonTigerLogic = class(hundredLogic)
local this = drangonTigerLogic

---构造 
function drangonTigerLogic:ctor()
end


return drangonTigerLogic