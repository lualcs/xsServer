--[[
    file:bullLogic.lua 
    desc:扑克逻辑
    auth:Caorl Luo
]]

local class = require("class")
local pokerLogic = require("poker.logic")
---@class bullLogic:pokerLogic
local logic = class(pokerLogic)

---构造 
function logic:ctor()
end

return logic