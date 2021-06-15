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

---清除数据
function error:dataClear()
end

---已经是庄家
---@return integer
function error.alreadyBanker()
    return 1
end

return error