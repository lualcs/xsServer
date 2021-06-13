--[[
    desc:龙虎
    auth:Carol Luo
]]


local class = require("class")
local hundredPlayer = require("hundred.player")

---@class dragonTigerPlayer:hundredPlayer
local player = class(hundredPlayer)

---构造函数
function player:ctor()
end

return player