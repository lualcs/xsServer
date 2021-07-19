--[[
    desc:逻辑
    auth:Caorl Luo
]]

local class = require("class")
local pokerLogic = require("poker.logic")
---@class ddzLogic:pokerLogic
local logic = class(pokerLogic)
local this = logic

---构造
function logic:ctor()
end 

return logic