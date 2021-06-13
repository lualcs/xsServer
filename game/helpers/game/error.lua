--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local class = require("class")
---@class gameError @游戏枚举
local error = class()
local this = error

---构造
function error:ctor()
end

---已经是庄家
---@return integer
function error.alreadyBanker()
    return 1
end

---最小错误码
---@return integer
function error.minimumError()
    return 1
end

---最大错误码
---@return integer
function error.maximumError()
    return 100
end

return error