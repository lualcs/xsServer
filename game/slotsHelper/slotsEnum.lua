--[[
    file:slotsEnum.lua 
    desc:枚举
    auth:Carol Luo
]]


local class = require("class")
local gameEnum = require("gameEnum")

---@class slotsEnum:gameEnum
local slotsEnum = class(gameEnum)

---构造函数
function slotsEnum:ctor()
end

---摇奖
---@return senum
function slotsEnum:rotateNormal()
    return "rotateNormal"
end

---免费
---@return senum
function slotsEnum:rotateFree()
    return "rotateFree"
end

---重转
---@return senum
function slotsEnum:rotateRoller()
    return "rotateRoller"
end


---结果

return slotsEnum
