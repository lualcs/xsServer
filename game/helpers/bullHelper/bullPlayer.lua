--[[
    file:bullPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("gamePlayer")
---@class bullPlayer:gamePlayer
local bullPlayer = class(gamePlayer)

---构造
function bullPlayer:ctor()
    ---@type pkCard[]       @玩家手牌
    self._hands = {nil}
end

---手牌
---@return pkCard[]
function bullPlayer:getHandCards()
    return self._hands
end

return bullPlayer