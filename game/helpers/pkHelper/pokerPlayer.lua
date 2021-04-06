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
    ---@type pkCard[]       @玩家手牌
    self._hands = {nil}
    ---@type pkCard[]       @显示手牌
    self._shows = {nil}
end

---手牌
---@return pkCard[]
function pokerPlayer:getHandCards()
    return self._hands
end

return pokerPlayer