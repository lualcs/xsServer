--[[
    desc:龙虎 
    auth:Caorl Luo
]]


local class = require("class")
local hundredEnum = require("hundredEnum")

---@class dragonTigerEnum:hundredEnum
local dragonTigerEnum = class(hundredEnum)

---构造
function dragonTigerEnum:ctor()
end

---龙
---@return senum
function dragonTigerEnum.dragon()
    return "dragon"
end

---虎
---@return senum
function dragonTigerEnum.tiger()
    return "tiger"
end

---和
---@return senum
function dragonTigerEnum.peace()
    return "peace"
end

---庄
---@return senum
function dragonTigerEnum.banker()
    return "peace"
end

return dragonTigerEnum