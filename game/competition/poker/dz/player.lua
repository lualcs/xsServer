--[[
    file:dz_player.lua 
    desc:扯旋
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("poker.player")
---@class dzPlayer:pokerPlayer
local player = class(pokerPlayer)
local this = player

---构造
function player:ctor()
end

return player