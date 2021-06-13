--[[
    file:ddz_player.lua 
    desc:炸金花
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("poker.player")
---@class ddzPlayer:pokerPlayer
local player = class(pokerPlayer)
local this = player

---构造
function player:ctor()
end

---重启
function player:dataReboot()
end


return player