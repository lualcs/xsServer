--[[
    file:dz_player.lua 
    desc:扯旋
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("pokerPlayer")
---@class dz_player:pokerPlayer
local dz_player = class(pokerPlayer)
local this = dz_player

---构造
function dz_player:ctor()
end

return dz_player