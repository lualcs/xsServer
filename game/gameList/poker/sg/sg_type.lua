--[[
    file:sg_type.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local pokerType = require("pokerType")
---@class sg_type:pokerType
local sg_type = class(pokerType)

---构造 
function sg_type:ctor()
end

---丁皇
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function sg_type:isDingHuang(a,b)
    if 0x23 == a and 0x4f == b then
        return true
    end
    if 0x23 == b and 0x4f == a then
        return true
    end
    return false
end

return sg_type