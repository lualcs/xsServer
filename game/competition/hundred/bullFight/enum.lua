--[[
    desc:龙虎 
    auth:Caorl Luo
]]


local class = require("class")
local hundredEnum = require("hundred.enum")

---@class dragonTigerEnum:hundredEnum
local enum = class(hundredEnum)

---构造
function enum:ctor()
end

---龙
---@return senum
function enum.dragon()
    return "dragon"
end

---虎
---@return senum
function enum.tiger()
    return "tiger"
end

---和
---@return senum
function enum.peace()
    return "peace"
end

---庄
---@return senum
function enum.banker()
    return "peace"
end

return enum