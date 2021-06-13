--[[
    file:slotsEnum.lua 
    desc:枚举
    auth:Carol Luo
]]


local class = require("class")
local gameEnum = require("game.enum")

---@class slotsEnum:gameEnum
local enum = class(gameEnum)

---构造函数
function enum:ctor()
end

---摇奖
---@return senum
function enum.spin()
    return "spin"
end

---免费
---@return senum
function enum.fpin()
    return "fpin"
end

---重转
---@return senum
function enum.xpin()
    return "xpin"
end


---结果

return enum
