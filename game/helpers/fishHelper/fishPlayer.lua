--[[
    file:fishPlayer.lua  
    desc:算法
    auth:Carol Luo
]]

local class = require("class")
local gamePlayer = require("gamePlayer")
---@class fishPlayer:gamePlayer
local fishPlayer = class(gamePlayer)

---构造 
function fishPlayer:ctor()
end

return fishPlayer