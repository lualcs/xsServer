--[[
    file:scxzPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("class")
local mahjongPlayer = require("mahjong.player")
---@class scxzPlayer:mahjongPlayer @玩家
local scxzPlayer = class(mahjongPlayer)

---构造
function scxzPlayer:ctor()
end

return scxzPlayer