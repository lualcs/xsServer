--[[
    desc:桌子
    auth:Caorl Luo
]]

local pairs = pairs
local ipairs = ipairs
local class = require("class")
local ranking = require("ranking")
local debug = require("extend_debug")
local table = require("extend_table")
local senum = require("killing.enum")
local gameCompetition= require("game.competition")
---@class singleCompetition:gameCompetition
local competition = class(gameCompetition)
local this = competition

---构造 
function competition:ctor()
end


---检查开始
---@return boolean
function competition:checkStart()
    --检查状态
    if not self._stu:ifIdle() then
        return false
    end

    --检查人数
    local info = self:getGameInfo()
    if self:getNumPlayer() >= info.minPlayer then
        return true
    end

    return false
end

return competition