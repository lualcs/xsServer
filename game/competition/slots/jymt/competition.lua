--[[
    desc:金玉满堂
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local jymtEnum = require("jymt.enum")
local slotsCompetition = require("slots.competition")
---@class jymtTable:slotsCompetition @金玉满堂
local competition = class(slotsCompetition)
local this = competition

---构造
function competition:ctor()
end


return competition