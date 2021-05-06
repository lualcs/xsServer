--[[
    desc:龙虎
    auth:Caorl Luo
]]

local ipairs = ipairs
local math = math
local table = table
local class = require("class")
local senum = require("dragonTiger.dragonTigerEnum")
local hundredTable = require("hundredTable")
---@class dragonTigerTable:hundredTable
local dragonTigerTable = class(hundredTable)
local this = dragonTigerTable

---构造
function dragonTigerTable:ctor()
end


---下注赔额
---@param area      senum               @区域
---@param score     score               @下注
---@return boolean
function dragonTigerTable:ifRepayment(area,score)
    ---@type dragonTigerDeploy
    local cfg = self:getGameConf()

    local betting = 0
    local dragonBet = self._mapAreaBet[senum.dragon()]
    local tigerBet = self._mapAreaBet[senum.tiger()]
    local peaceBet = self._mapAreaBet[senum.peace()]

    ---区域最大下注
    local maxiBetting = cfg.areas[area].maxi
    if senum.dragon() == area then
        ---龙
        dragonBet = dragonBet + score
        betting = dragonBet / self:getUnit()
        if betting > maxiBetting then
            return false
        end
    elseif senum.tiger() == area then
        ---虎
        tigerBet = tigerBet + score
        betting = tigerBet / self:getUnit()
        if betting > maxiBetting then
            return false
        end
    elseif senum.peace() == area then
        ---和
        peaceBet = peaceBet + score
        betting = peaceBet / self:getUnit()
        if betting > maxiBetting then
            return false
        end
    end

    
    ---庄家是否够赔
    local dragonAndPeace = dragonBet + peaceBet
    local tigerAndPeace = tigerBet + peaceBet
    local dragonAndTiger = tigerBet + dragonBet
    local repaymentDragon = dragonAndPeace -  dragonBet
    local repaymentTiger = tigerAndPeace - tigerBet
    local repaymentPeace = peaceBet * cfg.areas[senum.peace()].odds

    ---最大赔付金额
    local repaymentMaxi = math.max(repaymentDragon,repaymentTiger,repaymentPeace)
    for _,seatID in ipairs(self._arrBanker) do
        local player = self._arrPlayer[seatID]
        repaymentMaxi = repaymentMaxi - player:getCoin()
        if repaymentMaxi < 0 then
            return false
        end
    end

    return true
end


return dragonTigerTable