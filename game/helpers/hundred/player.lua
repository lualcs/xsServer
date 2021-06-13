--[[
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("game.player")
local senum = require("hundred.enum")
---@class hundredPlayer:gamePlayer
local player = class(gamePlayer)
local this = player

---构造 
function player:ctor()
    
end

return player