--[[
    desc:辅助功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")
local math = require("extend_math")
local pokerHelper = require("poker.helper")

---@class bullHelper:pokerHelper @扑克辅助
local helper = class(pokerHelper)
local this = helper

---构造函数
function helper:ctor()
end

return helper