--[[
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local gameLogic = require("game.logic")
---@class singleLogic:gameLogic
local logic = class(gameLogic)
local this = logic

---构造 
function logic:ctor()
end

return logic