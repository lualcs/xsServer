--[[
    file:cx_player.lua 
    desc:扯旋
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("pokerPlayer")
---@class cx_player:pokerPlayer
local cx_player = class(pokerPlayer)
local this = cx_player

---构造
function cx_player:ctor()
end

---重启
function cx_player:dataReboot()
end


return cx_player