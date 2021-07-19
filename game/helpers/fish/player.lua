--[[
    file:fishPlayer.lua  
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("game.player")
---@class fishPlayer:gamePlayer
local player = class(gamePlayer)

---构造 
function player:ctor()
end

return player