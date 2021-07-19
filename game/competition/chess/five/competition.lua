--[[
    desc:桌子
    auth:Carol Luo
]]

local class = require("class")
local chessTable = require("chessTable")
---@class fiveCompetition:gameCompetition @桌子
local competition = class(chessTable)

---构造函数
function competition:ctor()
end

return competition