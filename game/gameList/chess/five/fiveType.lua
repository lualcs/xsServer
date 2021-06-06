--[[
    desc:类型
    auth:Carol Luo
]]

local class = require("class")
local chessType = require("chessType")
---@class fiveType:chessType @桌子
local fiveType = class(chessType)

---构造函数
function fiveType:ctor()
end

return fiveType