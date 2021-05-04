--[[
    file:zjh_table.lua 
    desc:扎金花
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local senum = require("zjh.zjh_enum")
local pokerTable = require("pokerTable")
---@class zjh_table:pokerTable
local zjh_table = class(pokerTable)
local this = zjh_table

---构造
function zjh_table:ctor()
end

---请求
---@param player        zjh_player  @玩家
---@param msg           msgBody @消息
---@return boolean,string|any
function zjh_table:message(player,msg)
    local ok,error = self:super(this,"message",player,msg)
    if ok then
        return ok,error
    end
    local cmd = table.last(msg.cmds)
    if cmd == senum.zjh_kp() then
        ok,error = self:gameSeeCard(player)--看牌
    elseif cmd == senum.zjh_qp() then
        ok,error = self:gameCastCard(player)--弃牌
    elseif cmd == senum.zjh_gz() then
        ok,error = self:gameWithBet(player)--跟注
    elseif cmd == senum.zjh_jz() then
        local index = msg.details
        ok,error = self:gameRefuelBet(player,index)--加注
    elseif cmd == senum.zjh_sh() then
        ok,error = self:gameShowhandBet(player)--梭哈
    elseif cmd == senum.zjh_gdd() then
        ok,error = self:gameTraceBet(player)--跟到底
    end
    return ok,error
end

---看牌
---@param player       zjh_player
function zjh_table:gameSeeCard(player)
    --本局玩家
    local senum = senum.join()
    if not player:getStatusBy(senum) then
        return false,"看牌:非参与者"
    end

    --重复检查
    local senum = senum.zjh_kp()
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
---@param player       zjh_player
function zjh_table:gameCastCard(player)
    --本局玩家
    local senum = senum.join()
    if not player:getStatusBy(senum) then
        return false,"弃牌:非参与者"
    end

    --重复检查
    local senum = senum.zjh_qp()
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
---@param player       zjh_player
function zjh_table:gameWithBet(player)
    --本局玩家
    local senum = senum.join()
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
---@param data zjh_game_start_ntc @数据
function zjh_table:ntfMsgToStart(data)
    self:ntfMsgToTable(data)
end

---发牌通知
---@param data zjh_deal_ntc @数据
function zjh_table:ntfMsgToDealCard(data)
    self:ntfMsgToTable(data)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---看牌通知
---@param data zjh_see_ntc @数据
function zjh_table:ntfMsgToSeeCard(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable(data,see_info)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---放弃通知
---@param data zjh_giveup_ntc @数据
function zjh_table:ntfMsgToGiveup(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable(data,see_info)
end

---加注通知
---@param data zjh_bet_refuel_ntc @数据
function zjh_table:ntfMsgToRefuel(data)
    self:ntfMsgToTable(data)
end

---跟注通知
---@param data zjh_bet_with_ntc @数据
function zjh_table:ntfMsgToBetWith(data)
    self:ntfMsgToTable(data)
end

---梭哈通知
---@param data zjh_bet_all_ntc @数据
function zjh_table:ntfMsgToBetAll(data)
    self:ntfMsgToTable(data)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"originSP","targetSP","originPX","targetPX"}
}
---比牌通知
---@param data zjh_cmp_card_ntc @数据
function zjh_table:ntfMsgToCompare(data)
    see_info.chairs = {data.originID,data.targetID}
    self:ntfMsgToTable(data)
end

---结果通知
---@param data zjh_game_result_ntc @数据
function zjh_table:ntfMsgToGameResult(data)
    self:ntfMsgToTable(data)
end

return zjh_table