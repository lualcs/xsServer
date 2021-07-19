--[[
    file:tigerLogic.lua 
    desc:逻辑
    auth:Carol Luo
]]

local class = require("class")
local gameLogic = require("game.logic")
---@class tigerLogic:gameLogic @逻辑
local logic = class(gameLogic)

---构造函数
function logic:ctor()
end

return logic