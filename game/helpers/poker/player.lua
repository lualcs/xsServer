--[[
    file:pokerPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("game.player")
---@class pokerPlayer:gamePlayer
local player = class(gamePlayer)

---构造
function player:ctor()
    ---@type pkCard[]       @玩家手牌
    self._hands = {nil}
    ---@type pkCard[]       @显示手牌
    self._shows = {nil}
end

---手牌
---@return pkCard[]
function player:getHandCards()
    return self._hands
end

return player