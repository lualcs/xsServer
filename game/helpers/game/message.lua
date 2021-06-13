--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local mgrEnum = require("managerEnum")
local class = require("class")

---@class gameEnum:managerEnum @游戏枚举
local message = class(mgrEnum)
local this = message

---构造
function message:ctor()
end

return message