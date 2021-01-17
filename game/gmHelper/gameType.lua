--[[
    file:gameType.lua 
    desc:类型 
    auth:Carol Luo
]]

local class = require("class")
---@class gameType @游戏类型
local gameType = class()

---构造
---@param table gameTable
function gameType:ctor(table)
    self._table = table
end

---重启
function gameType:dataReboot()
    self._hlp = self._table._hlp
    self._sys = self._table._sys
    self._tye = self._table._tye
    self._lgc = self._table._lgc
end

return gameType