--[[
    file:hntdhPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("hntdhPlayer")
local mahjongPlayer = require("mahjongPlayer")
---@class hntdhPlayer:mahjongPlayer @玩家
local hntdhPlayer = class(mahjongPlayer)

---构造
function hntdhPlayer:ctor()
end

return hntdhPlayer