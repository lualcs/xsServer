--[[
    file:zjh_player.lua 
    desc:炸金花
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("pokerPlayer")

---@class zjh_player:pokerPlayer
local zjh_player = class(pokerPlayer)
local this = zjh_player

---构造
function zjh_player:ctor()
end

---重启
function zjh_player:dataReboot()
end


return zjh_player