--[[
    file:sg_player.lua 
    desc:三公
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("pokerPlayer")
---@class sg_player:pokerPlayer
local sg_player = class(pokerPlayer)
local this = sg_player

---构造
function sg_player:ctor()
end

return sg_player