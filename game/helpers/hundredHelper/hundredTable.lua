--[[
    desc:桌子
    auth:Caorl Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local ranking  = require("ranking")
local gameTable = require("gameTable")
local senum = require("hundredEnum")
---@class hundredTable:gameTable
local hundredTable = class(gameTable)
local this = hundredTable

---构造 
function hundredTable:ctor()
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
    self._arrUpBanker = {nil}
    ---闲家下注信息
    ---@type table<seatID,hundredBetInf[]>
    self._mapBetInfo = {nil}
    ---区域下注信息
    ---@type table<senum,score>
    self._mapAreaBet = {nil}
end

---最少庄家
---@return count
function hundredTable:minBanker()
    local cfg = self:getGameConf()
    return cfg.minBanker
end

---最多庄家
---@return count
function hundredTable:maxBanker()
    local cfg = self:getGameConf()
    return cfg.maxBanker
end

---庄家数量
---@return count
function hundredTable:numBanker()
    return #self._arrBanker
end

---上庄数量
---@return count
function hundredTable:numUpBanker()
    return #self._arrUpBanker
end


---检查开始
function hundredTable:checkStart()
    ---检查庄家数量
    if self:numBanker() <= 0 then
        return
    end

    self:super(this,"checkStart")
end

---请求
---@param player        gamePlayer      @玩家
---@param msg           messageInfo     @消息
---@return boolean,string|any
function hundredTable:messageBy(player,msg)
    local cmd  = table.last(msg.cmds)
    local info = msg.info
    ---闲家下注
    if cmd == senum.betting() then
        self:tryBetting(player,info.area,info.score)
    end
end

---下注
---@param player    hundredPlayer      @玩家
---@param score     score              @下注
function hundredTable:tryBetting(player,area,score)
    ---游戏状态
    if self:getGameStatus() ~= senum.statusBet() then
        return
    end

    ---携带分数
    if player:getCoin() < score then
        return 
    end

    ---玩家身份
    if player:ifBanker() then
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
    local seat = player:getSeatID()
    ---@type hundredBetInf
    local infos = self._mapBetInfo[seat] or {nil}
    local betting = {
        area = area,
        bets = score,
    }

    ---信息保存
    table.insert(infos,betting)
    self._mapBetInfo[seat] = infos

    ---广播下注
    self:ntfBroadcastBet(betting)
end

---区域下注
---@param area      senum               @区域
---@param score     score               @下注
function hundredTable:ifAreaBet(area,score)
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
function hundredTable:ifRepayment(area,score)
end

---广播下注
---@param data xx 下注
function hundredTable:ntfBroadcastBet(data)
    self:ntfMsgToTable("s2cHundredBetting",data)
end

---申请上庄
---@param player hundredPlayer @申请玩家
function hundredTable:applyForUpBanker(player)
    local list = self._arrUpBanker
    table.insert(list,player)
end

---申请下庄
---@param player hundredPlayer @申请玩家
---@return boolean,string|nil
function hundredTable:tryUpBanker(player)
    
    if player:ifBanker() then
        return false,"alreadyBookmaker"
    end

    local list = self._arrUpBanker
    if table.exist(list,player) then
        return false,"hadAppliedFor"
    end
    
    return true
end

---申请下庄
---@param player hundredPlayer @申请玩家
function hundredTable:tryDownBanker(player)

    ---上庄列表
    local list = self._arrUpBanker
    for index,upBanker in ipairs(self._arrUpBanker) do
        if player == upBanker then
            table.remove(list,index)
            return true
        end
    end

    ---状态检查
    local status = self:getGameStatus()
    if senum.gameIdle() ~= status then
        return
    end

    ---庄家列表
    local list = self._arrBanker
    for index,banker in ipairs(list) do
        if player == banker then
            table.remove(list,index)
            return true
        end
    end 
end

return hundredTable