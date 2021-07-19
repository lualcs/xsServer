--[[
    file:sg_logic.lua 
    desc:三公
    auth:Caorl Luo
]]

local class = require("class")
local pokerLogic = require("poker.logic")
---@class sgLogic:pokerLogic
local logic = class(pokerLogic)
local this = logic

---构造
function logic:ctor()
end 

return logic