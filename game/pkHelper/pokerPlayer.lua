--[[
    file:pokerPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("gamePlayer")
---@class pokerPlayer:gamePlayer
local pokerPlayer = class(gamePlayer)

---构造
function pokerPlayer:ctor()
end

return pokerPlayer