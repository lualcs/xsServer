--[[
    file:bullPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local pokerPlayer = require("pokerPlayer")
---@class bullPlayer:pokerPlayer
local bullPlayer = class(pokerPlayer)

---构造
function bullPlayer:ctor()
    ---@type pkCard[]       @玩家手牌
    self._hands = {nil}
end


return bullPlayer