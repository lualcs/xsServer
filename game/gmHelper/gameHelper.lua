--[[
    file:gameHelper.lua 
    desc:游戏辅助 
    auth:Caorl Luo
]]

local class = require("class")

---@class gameHelper
local gameHelper = class()

---构造
---@param table gameTable
function gameHelper:ctor(table)
    self._table = table
end

---重启
function gameHelper:dataReboot()
    self._gor = self._table._gor
    self._sys = self._table._sys
    self._tye = self._table._tye
    self._lgc = self._table._lgc
end

---游戏配置 
---@return table
function gameHelper:getGameConf()
    return self._table:getGameConf()
end

return gameHelper