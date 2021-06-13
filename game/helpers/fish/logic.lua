--[[
    file:fishLogic.lua 
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local gameLogic = require("game.logic")
---@class fishLogic:gameLogic
local logic = class(gameLogic)

---构造 
function logic:ctor()
end

return logic