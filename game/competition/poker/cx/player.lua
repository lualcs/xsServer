--[[
    file:cx_player.lua 
    desc:扯旋
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("poker.player")
---@class cx_player:pokerPlayer
local cx_player = class(pokerPlayer)
local this = cx_player

---构造
function cx_player:ctor()
end

return cx_player