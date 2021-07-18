--[[
    desc:策略
    auth:Carol Luo
]]

local class = require("class")
local mahjongSystem = require("mahjong.system")
---@class scxzSystem:mahjongSystem @策略
local scxzSystem = class(mahjongSystem)

---构造
function scxzSystem:ctor()
end

return scxzSystem