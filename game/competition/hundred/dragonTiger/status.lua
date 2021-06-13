--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local hundredStatus = require("hundred.status")
local senum = require("dragonTiger.enum")
---@class dragonTigerStatus:hundredStatus @龙虎状态机
local status = class(hundredStatus)

---构造函数
function status:ctor()

end

---游戏流程切换
function status:switchGameProcess(status)
    ---龙虎桌子
    ---@type dragonTigerTable
    local _table = self._table
    ---开始阶段
    if senum.gameStart() == status then
        _table:gameStart()
    ---下注阶段
    elseif senum.gameBetting() == status then
        _table:gameBetting()
    ---结算阶段
    elseif senum.gameSettle() == status then
        _table:gameSettle()
    end 
end

---获取总共时间
---@return number @毫秒
function status:totalMilliscond()
    local status = self._table:getGameStatus()
    ---开始阶段
    if senum.gameStart() == status then
    ---下注阶段
    elseif senum.gameBetting() == status then
    ---结算阶段
    elseif senum.gameSettle() == status then
    end 
end

return status