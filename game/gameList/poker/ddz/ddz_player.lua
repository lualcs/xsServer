--[[
    file:ddz_player.lua 
    desc:炸金花
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("pokerPlayer")
---@class ddz_player:pokerPlayer
local ddz_player = class(pokerPlayer)
local this = ddz_player

---构造
function ddz_player:ctor()
end

---重启
function ddz_player:dataReboot()
end


return ddz_player