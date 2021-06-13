--[[
    file:sg_algor.lua 
    desc:算法
    auth:Caorl Luo
]]

local class = require("class")
local pokerAlgor = require("poker.algor")
---@class sgAlgor:pokerAlgor
local algor = class(pokerAlgor)
local this = algor

---构造
function algor:ctor()
end

return algor