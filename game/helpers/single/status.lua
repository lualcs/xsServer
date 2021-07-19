--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local skynet = require("skynet")
local debug = require("extend_debug")
local senum = require("hundred.enum")
local gameStatus = require("game.status")
---@class killingStatus:gameStatus @状态机
local status = class(gameStatus)
local this = status

---构造函数 
function status:ctor()
end
return status