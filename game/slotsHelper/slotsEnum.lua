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
function slotsEnum.spin()
    return "spin"
end

---免费
---@return senum
function slotsEnum.fpin()
    return "fpin"
end

---重转
---@return senum
function slotsEnum.xpin()
    return "xpin"
end


---结果

return slotsEnum
