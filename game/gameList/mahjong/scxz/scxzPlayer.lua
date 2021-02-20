--[[
    file:scxzPlayer.lua 
    desc:玩家
    auth:Carol Luo
]]

local class = require("scxzPlayer")
local mahjongPlayer = require("mahjongPlayer")
---@class scxzPlayer:mahjongPlayer @玩家
local scxzPlayer = class(mahjongPlayer)

---构造
function scxzPlayer:ctor()
end

return scxzPlayer