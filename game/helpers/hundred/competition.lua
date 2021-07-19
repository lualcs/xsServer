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
local senum = require("hundred.enum")
local gameCompetition= require("game.competition")
---@class hundredCompetition:gameCompetition
local competition = class(gameCompetition)
local this = competition

---构造 
function competition:ctor()
    ---神算子排行榜
    ---@type ranking
    self._ssz_rank = ranking.new(10)
    ---大富豪排行榜
    ---@type ranking
    self._dfh_rank = ranking.new(10)
    ---庄家列表数据
    ---@type hundredPlayer[]
    self._arrBanker = {nil}
    ---请求上庄列表
    ---@type hundredPlayer[]
    self._arrWaitUpBanker = {nil}
    ---上庄分成比例
    ---@type number[]
    self._arrBankerRights = {nil}
    ---下注区域类型
    ---@type senum[]
    self._arrAreaEnum = {nil}
    ---区域下注信息
    ---@type table<senum,score>
    self._mapAreaBet = {nil}
    ---闲家下注信息
    ---@type table<userID,hundredBetInf[]>
    self._mapBetInfo = {nil}
    ---现价下注列表
    ---@type hundredBetInf[]
    self._arrBetInfo = {nil}
    ---闲家下注统计
    ---@type table<userID,score>
    self._mapBetCoin = {nil}
    ---闲家收益统计
    ---@type table<userID,score>
    self._mapBetBonus= {nil}
end

---最少庄家
---@return count
function competition:minBanker()
    local cfg = self:getGameInfo()
    return cfg.minBanker
end

---最多庄家
---@return count
function competition:maxBanker()
    local cfg = self:getGameInfo()
    return cfg.maxBanker
end

---庄家数量
---@return count
function competition:numBanker()
    return #self._arrBanker
end

---等待上庄数量
---@return count
function competition:numWaitBanker()
    return #self._arrWaitUpBanker
end

---获取区域赔率
---@param area senum @区域
---@return count
function competition:getAreaOdds(area)
    local cfg = self:getGameConf()
    return cfg.areas[area].odds
end

---清除数据
function competition:dataClear()
    self:super(this,"dataClear")
    table.clear(self._mapAreaBet)
    table.clear(self._mapBetInfo)
    table.clear(self._arrBetInfo)
    table.clear(self._mapBetBonus)
    table.clear(self._arrBankerRights)
end


---检查开始
---@return boolean
function competition:checkStart()
    --检查状态
    if not self._stu:ifIdle() then
        return false
    end

    --检查庄家
    if self:numBanker() <= 0 then
        return false
    end

    --检查闲家
    for _,player in pairs(self._mapPlayer) do
        if not player:ifBanker() then
            return true
        end
    end

    return false
end

----------------------------------------------------空闲状态--------------------------------------------------
function competition:gameIdle()
end


----------------------------------------------------开始状态--------------------------------------------------
function competition:gameStart()
    self:dataClear()
    self:gameBanker()
end

----------------------------------------------------下注状态--------------------------------------------------
function competition:gameBetting()
end

----------------------------------------------------结束状态--------------------------------------------------
function competition:gameClose()
    ---游戏结算
    self:gameResults()
    ---游戏结算
    self:gameSettlement()
end

----------------------------------------------------上庄处理--------------------------------------------------
function competition:gameBanker()
    ---上庄处理
    while self:numBanker() < self:maxBanker() do
        local list = self._arrWaitUpBanker
        if table.empty(list) then
            break
        end
        self:tryUpBanker(table.remove(list))
    end
    ---统计携带
    local totalAssetNumber = 0
    for _,player in ipairs(self._arrBanker) do
        local assetNumber = player:getCoin()
        totalAssetNumber = totalAssetNumber + assetNumber
    end
    ---分配比例
    for index,player in ipairs(self._arrBanker) do
        local assetNumber = player:getCoin()
        self._arrBankerRights[index] = assetNumber / totalAssetNumber;
    end
end

----------------------------------------------------游戏结果--------------------------------------------------
function competition:gameResults()
end

----------------------------------------------------游戏结算--------------------------------------------------
function competition:gameSettlement()
end

---下注
---@param player    hundredPlayer      @玩家
---@param score     score              @下注
function competition:tryBetting(player,area,score)
    ---游戏状态
    if not self._stu:ifBetting() then
        return
    end

    ---携带分数
    local rid = player:getUserID()
    local playerBetCoin = self._mapBetCoin[rid] or 0
    if player:getCoin() < score + playerBetCoin then
        return 
    end

    ---玩家身份
    if player:ifBanker() then
        return
    end

    ---下注区域
    if table.exist(self._arrAreaEnum,area) then
        return
    end

    ---下注金额
    if not self:ifAreaBet(area,score) then
        return
    end

    ---赔付检查
    if not self:ifRepayment(area,score) then
        return
    end

    ---区域赔付
    local areaBet = self._mapAreaBet[area] or 0
    self._mapAreaBet[area] = areaBet + score

    ---玩家下注
    ---@type hundredBetInf
    local infos = self._mapBetInfo[rid] or {nil}
    local betting = {
        rid = rid,
        area = area,
        coin = score,
    }

    ---信息保存
    table.insert(infos,betting)
    self._mapBetInfo[rid] = infos
    local arrBets = self._arrBetInfo
    table.insert(arrBets,betting)

    ---统计下注
    self._mapBetCoin[rid] = playerBetCoin + score

    ---广播下注
    self:ntfBroadcastBet(betting)
end

---区域下注
---@param area      senum               @区域
---@param score     score               @下注
function competition:ifAreaBet(area,score)
    ---游戏配置
    ---@type hundredDeploy
    local cfg = self:getGameConf()
    ---下注区域
    ---@type hundredAreaInf
    local areaInfo = cfg.areas[area]
    if not areaInfo then
        return false
    end

    ---下注分数
    local jettons = cfg.jettons
    local unit = self:getUnit()
    if not table.exist(jettons,score / unit) then
        return false
    end

    return true
end

---下注赔额
---@param area      senum               @区域
---@param score     score               @下注
---@return boolean
function competition:ifRepayment(area,score)
end

---申请上庄
---@param player hundredPlayer @申请玩家
function competition:applyForUpBanker(player)
    ---游戏阶段
    if not self._stu:ifIdle() then
        self:tryWaitUpBanker(player)
    ---庄家数量
    elseif self:numBanker() >= self:maxBanker() then
        self:tryWaitUpBanker(player)
    else
        self:tryUpBanker(player)
    end
end

---等待上庄
---@param player hundredPlayer @玩家
function competition:tryWaitUpBanker(player)

    ---是否闲家
    if player:ifBanker() then
        return false
    end

    ---重复操作
    if player:ifWaitDownBanker() then
        return false
    end

    local list = self._arrWaitUpBanker
    table.insert(list,player)

    return true
end

---取消等待上庄
---@param player hundredPlayer @玩家
function competition:tryCancelWaitUpBanker(player)
    ---检查状态
    if not player:ifWaitDownBanker() then
        return false
    end

    ---遍历检查
    local list = self._arrWaitUpBanker
    for index,waitPlayer in ipairs(list) do
        if waitPlayer == player then
            table.remove(list,index)
            return true
        end
    end
    return false
end

---尝试上庄
---@param player hundredPlayer @申请玩家
---@return boolean,string|nil
function competition:tryUpBanker(player)

    ---闲家身份
    if player:ifBanker() then
        return false
    end

    ---等待上庄
    if player:ifWaitDownBanker() then
        return false
    end

    if not self._stu:ifIdle() then
        ---等待上庄
        self:tryWaitUpBanker(player)
    else
        ---上庄成功
        table.insert(self._arrBanker,player)
        player:falseWaitDownBanker()
    end

    return true
end

---申请下庄
---@param player hundredPlayer @申请玩家
function competition:tryDownBanker(player)

    ---是否庄家
    if not player:ifBanker() then
        return false
    end

    ---状态检查
    ---@type hundredStatus
    local status = self:getGameStatus()
    if senum.gameIdle() ~= status then
        player:trueWaitDownBanker()
        return true
    end

    ---庄家列表
    local list = self._arrBanker
    for index,banker in ipairs(list) do
        if player == banker then
            table.remove(list,index)
            break
        end
    end 

    return true
end

return competition