--[[
    file:dz_logic.lua 
    desc:扯旋
    auth:Caorl Luo
]]

local class = require("class")
local pokerLogic = require("poker.logic")
---@class dzLogic:pokerLogic
local logic = class(pokerLogic)
local this = logic

---构造
function logic:ctor()
end 

return logic