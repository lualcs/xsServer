--[[
    file:zjh_logic.lua 
    desc:炸金花
    auth:Caorl Luo
]]

local class = require("class")
local pokerLogic = require("poker.logic")
---@class zjh_logic:pokerLogic
local logic = class(pokerLogic)
local this = logic

---构造
function logic:ctor()
end 

return logic