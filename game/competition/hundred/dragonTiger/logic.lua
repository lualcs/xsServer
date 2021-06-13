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
local ifNumber = require("ifNumber")
local hundredLogic = require("hundredLogic")
local senum = require("dragonTiger.enum")
---@class drangonTigerLogic:hundredLogic
local logic = class(hundredLogic)
local this = logic

---构造 
function logic:ctor()
end


return logic