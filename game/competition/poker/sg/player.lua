--[[
    file:sg_player.lua 
    desc:三公
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("poker.player")
---@class sgPlayer:pokerPlayer
local player = class(pokerPlayer)
local this = player

---构造
function player:ctor()
end

return player