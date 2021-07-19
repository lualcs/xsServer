--[[
    desc:龙虎
    auth:Carol Luo
]]

local ipairs = ipairs
local class = require("class")
local math = require("extend_math")
local table = require("extend_table")
local hundredPlayer = require("hundred.player")

---@class dragonTigerPlayer:hundredPlayer
local player = class(hundredPlayer)
local this = player
---构造函数
function player:ctor()
   
end

---清除数据
function player:dataClear()
    self:super(this,"dataClear")
    if self:ifRobot() then
        self:robotStrategy()
    end
end

---下注策略
function player:robotStrategy()

    ---配置数据
    local cfg = self._competition:getRobotCfg()
    local sfg = cfg.strategy

    ---下注概率
    local probabliity = math.random(1,sfg.sumProbability)
    if probabliity > sfg.betProbability then
        return
    end

    ---下注区域
    local afg = sfg.betAreas
    local areaWeight = math.random(1,afg.sum)
    for _,wgts in ipairs(afg.lis) do
        for _,area in ipairs(wgts.areas) do
            ---下注筹码
            local chipWeight = math.random(1,sfg.sum)
            for _,wgts in ipairs(sfg.lis) do
                chipWeight = chipWeight - wgts.weight
                if chipWeight <= 0 then
                    self:robotBet(wgts,area)
                end
            end
        end
    end
    
end

---下注数据
---@param cfg   any
---@param area  senum
function player:robotBet(cfg,area)

    ---比赛
    ---@type dragonTigerCompetition
    local game = self._competition
    ---下注库存
    ---@type reusable
    local reusable = self._sys:robotBetReusable()
    local bettings = self._strategy.bets
    ---携带下注比例
    if cfg.ratio then
        local coin = self:getCoin()
        local asset = coin * cfg.ratio // 1
        local chips = game:jettonChips()
        local start = #chips
        while asset > 0 do
            for i=start,1,-1 do
                local score = game:chipScore(i)
                if asset >= score or 1 == i then
                    ---下注信息
                    ---@type hundredRobotBetting
                    local data = reusable:get()
                    data.area = area
                    data.chip = score
                    table.insert(bettings,data)
                    asset = asset - score
                    start = i
                    break
                end
            end
        end
    end

    ---单个下注筹码
    if cfg.chips then
        local chips = cfg.chips
        local irand = math.random(1,#chips)
        local index = chips[irand]
        ---下注信息
        ---@type hundredRobotBetting
        local data = reusable:get()
        data.area = area
        data.chip = game:chipScore(index)
        table.insert(bettings,data)
    end

    ---随机下注筹码
    if cfg.rands then
        local rands = cfg.rands
        local number = math.random(rands.min,rands.max)
        for i=1,number do
            local irand = math.random(1,#rands.lis)
            local index = rands.lis[irand]
            ---下注信息
            ---@type hundredRobotBetting
            local data = reusable:get()
            data.area = area
            data.chip = game:chipScore(index)
            table.insert(bettings,data)
        end
    end
end

return player