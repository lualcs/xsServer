--[[
    desc:龙虎
    auth:Caorl Luo
]]

local ipairs = ipairs
local math = math
local table = table
local class = require("class")
local senum = require("dragonTiger.enum")
local hundredCompetition = require("hundred.competition")
---@class dragonTigerCompetition:hundredCompetition
local competition = class(hundredCompetition)
local this = competition

---构造
function competition:ctor()
    ---区域下注信息
    ---@type table<senum,score>
    self._arrAreaEnum = {senum.dragon(),senum.peace(),senum.tiger()}
end

---下注配置
---@return count[]
function competition:jettonChips()
    local cfg = self:getGameConf()
    return cfg.jettons
end


---下注金额
---@param index index @下注
---@return score
function competition:chipScore(index)
    local chips = self:jettonChips()
    local count = chips[index]
    return count * self:getUnit()
end

---下注赔额
---@param area      senum               @区域
---@param score     score               @下注
---@return boolean
function competition:ifRepayment(area,score)
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
    local repaymentPeace = peaceBet * self:getAreaOdds(senum.peace())

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

----------------------------------------------------上庄处理--------------------------------------------------
function competition:gameBanker()
    self:super(this,"gameBanker")
end

----------------------------------------------------游戏结果--------------------------------------------------
function competition:gameResults()
    ---龙虎逻辑
    ---@type dragonTigerLogic
    local logic = self._lgc
    ---龙虎发牌
    logic:dealCards()
    ---结果
    ---@type dragonTigerGameResults
    local results = {
        dragonCard = logic:getDragonCard(),
        tigerCard = logic:getTigerCard(),
        winnerArea = logic:getWinner(),
    }
    self:super(this,"gameResults")
end

----------------------------------------------------游戏结算--------------------------------------------------
function competition:gameSettlement()
    ---龙虎逻辑
    ---@type dragonTigerLogic
    local logic = self._lgc
    ---游戏结算
    local betBonus = self._mapBetBonus;
    local winner = logic:getWinner()
    for _,info in ipairs(self._arrBetInfo) do
        local bouns = betBonus[info.rid] or 0
        if winner == info.area then
            betBonus[info.rid] = bouns + info.coin * self:getAreaOdds(winner)
        else
            betBonus[info.rid] = bouns + info.coin * self:getAreaOdds(winner)
        end
    end

    self:super(this,"gameSettlement")
end



return competition