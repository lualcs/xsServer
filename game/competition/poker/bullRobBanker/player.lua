--[[
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("poker.player")
---@class bullPlayer:pokerPlayer
local player = class(pokerPlayer)

---构造
function player:ctor()
end

return player