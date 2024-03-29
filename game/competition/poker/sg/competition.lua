--[[
    file:sg_table.lua 
    desc:三公
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local sg_enum = require("sg.enum")
local pokerCompetition = require("poker.Competition")
---@class sgCompetition:pokerCompetition
local competition = class(pokerCompetition)
local this = competition

---构造
function competition:ctor()
end

---请求
---@param player        sgPlayer  @玩家
---@param msg           messageInfo @消息
---@return boolean,string|any
function competition:message(player,msg)
    local ok,error = self:super(this,"message",player,msg)
    if ok then
        return ok,error
    end
    local cmd = table.last(msg.cmds) 
    if cmd == sg_enum.sg_qp() then
        ok,error = self:gameCastCard(player)--弃牌
    elseif cmd == sg_enum.sg_gz() then
        ok,error = self:gameWithBet(player)--跟注
    elseif cmd == sg_enum.sg_jz() then
        local index = msg.details
        ok,error = self:gameRefuelBet(player,index)--加注
    elseif cmd == sg_enum.sg_sh() then
        ok,error = self:gameShowhandBet(player)--梭哈
    elseif cmd == sg_enum.sg_gdd() then
        ok,error = self:gameTraceBet(player)--跟到底
    end
    return ok,error
end

---看牌
---@param player       sgPlayer
function competition:gameSeeCard(player)
    --本局玩家
    local senum = sg_enum.join()
    if not player:getStatusBy(senum) then
        return false,"看牌:非参与者"
    end

    --重复检查
    local senum = sg_enum.sg_kp()
    if player:getStatusBy(senum) then
        return false,"看牌:重复请求"
    end

    player:setStatusBy(senum,true)
    self:ntfMsgToSeeCard({
        seatID = player:getSeatID(),        --玩家位置
        hand   = player:getHandCards(),     --玩家手牌
    })
end

---弃牌
---@param player       sgPlayer
function competition:gameCastCard(player)
    --本局玩家
    local senum = sg_enum.join()
    if not player:getStatusBy(senum) then
        return false,"弃牌:非参与者"
    end

    --重复检查
    local senum = sg_enum.sg_qp()
    if player:getStatusBy(senum) then
        return false,"弃牌:重复请求"
    end

    player:setStatusBy(senum,true)
    self:ntfMsgToGiveup({
        seatID = player:getSeatID(),        --玩家位置
        hand   = player:getHandCards(),     --玩家手牌
    })
end

---跟注
---@param player       sgPlayer
function competition:gameWithBet(player)
    --本局玩家
    local senum = sg_enum.join()
    if not player:getStatusBy(senum) then
        return false,"跟注:非参与者"
    end

    --操作玩家
    if not false then
        return false,"跟注:非等待者"
    end

    --检查金币
    if not player:usageCoin() then
        return false,"跟注:金币不足"
    end

end


---开始通知
---@param data sg_game_start_ntc @数据
function competition:ntfMsgToStart(data)
    self:ntfMsgToTable("sg_game_start_ntc",data)
end

---发牌通知
---@param data sg_deal_ntc @数据
function competition:ntfMsgToDealCard(data)
    self:ntfMsgToTable("sg_deal_ntc",data)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---看牌通知
---@param data sg_see_ntc @数据
function competition:ntfMsgToSeeCard(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable("sg_see_ntc",data,see_info)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---放弃通知
---@param data sg_giveup_ntc @数据
function competition:ntfMsgToGiveup(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable("sg_giveup_ntc",data,see_info)
end

---加注通知
---@param data sg_bet_refuel_ntc @数据
function competition:ntfMsgToRefuel(data)
    self:ntfMsgToTable("sg_bet_refuel_ntc",data)
end

---跟注通知
---@param data sg_bet_with_ntc @数据
function competition:ntfMsgToBetWith(data)
    self:ntfMsgToTable("sg_bet_with_ntc",data)
end

---梭哈通知
---@param data sg_bet_all_ntc @数据
function competition:ntfMsgToBetAll(data)
    self:ntfMsgToTable("sg_bet_all_ntc",data)
end

---结果通知
---@param data sg_game_result_ntc @数据
function competition:ntfMsgToGameResult(data)
    self:ntfMsgToTable("sg_game_result_ntc",data)
end

return competition