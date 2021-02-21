--[[
    file:tigerPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("gamePlayer")
---@class tigerHelper:gamePlayer @玩家
local tigerPlayer = class(gamePlayer)

---构造函数
function tigerPlayer:ctor()
end

return tigerPlayer