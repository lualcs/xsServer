--[[
    desc:枚举
    auth:Carol Luo
]]

local class = require("class")
local gameEnum = require("gameEnum")
---@class chessEnum:gameEnum @枚举
local chessEnum = class(gameEnum)

---构造函数
function chessEnum:ctor()
end

return chessEnum