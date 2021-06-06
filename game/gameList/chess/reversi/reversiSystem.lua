--[[
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local gameSystem = require("gameSystem")
---@class chessSystem:gameSystem @策略
local chessSystem = class(gameSystem)

---构造函数
function chessSystem:ctor()
end

return chessSystem