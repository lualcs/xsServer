--[[
    file:zjh_table.lua 
    desc:扎金花
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local zjh_enum = require("poker_zjh.zjh_enum")
local pokerTable = require("pokerTable")
---@class zjh_table:pokerTable
local zjh_table = class(pokerTable)
local this = zjh_table

---构造
function zjh_table:ctor()
end

---请求
---@param player        zjh_player  @玩家
---@param msg           gameMsg     @消息
---@return boolean,string|any
function zjh_table:onRequest(player,msg)
    local ok,error = self:super(this,"onRequest",player,msg)
    if ok then
        return ok,error
    end
    local cmd = table.lastBy(msg.channel)
    if cmd == zjh_enum.zjh_kp() then
        ok,error = self:gameSeeCard(player)--看牌
    elseif cmd == zjh_enum.zjh_qp() then
        ok,error = self:gameCastCard(player)--弃牌
    elseif cmd == zjh_enum.zjh_gz() then
        ok,error = self:gameWithBet(player)--跟注
    elseif cmd == zjh_enum.zjh_jz() then
        local index = msg.details
        ok,error = self:gameRefuelBet(player,index)--加注
    elseif cmd == zjh_enum.zjh_sh() then
        ok,error = self:gameShowhandBet(player)--梭哈
    elseif cmd == zjh_enum.zjh_gdd() then
        ok,error = self:gameTraceBet(player)--跟到底
    end
    return ok,error
end

---看牌
---@param player       zjh_player
function zjh_table:gameSeeCard(player)
    if not player:isGamepay() then
        return false,"看牌:非参与者"
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

---放弃通知
---@param data zjh_giveup_ntc @数据
function zjh_table:ntfMsgToGiveup(data)
    self:ntfMsgToTable(data)
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