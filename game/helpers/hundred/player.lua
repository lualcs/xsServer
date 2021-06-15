--[[
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("game.player")
local senum = require("hundred.enum")
---@class hundredPlayer:gamePlayer
local player = class(gamePlayer)
local this = player

---构造函数
function player:ctor()
    ---等待下庄
    ---@type boolean
    self._mapsig.waitDownBanker = nil
end

---等待下庄
function player:trueWaitDownBanker()
    self._mapsig.waitDownBanker = true
end

---等待下庄
function player:falseWaitDownBanker()
    self._mapsig.waitDownBanker = nil
end

---是否等待下庄
function player:ifWaitDownBanker()
    return self._waitDownBanker
end

return player