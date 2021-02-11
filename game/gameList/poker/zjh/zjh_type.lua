--[[
    file:zjh_type.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local pokerType = require("pokerType")
---@class zjh_type:pokerType
local zjh_type = class(pokerType)

---构造 
function zjh_type:ctor()
end

---豹子
---@return senum
function zjh_type.isBaoZi()
end

return zjh_type