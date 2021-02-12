--[[
    file:gameAlgor.lua 
    desc:游戏算法 
    auth:Carol Luo
]]

local class = require("class")

---@class gameAlgor
local gameAlgor = class()
local this = gameAlgor

---构造函数
---@param table gameTable @游戏桌子
function gameAlgor:ctor(table)
    ---游戏桌子
    ---@type gameTable
    self._table = table
end

---重启
function gameAlgor:dataReboot()
    self._hlp = self._table._hlp
    self._sys = self._table._sys
    self._tye = self._table._tye
    self._lgc = self._table._lgc
end

return gameAlgor