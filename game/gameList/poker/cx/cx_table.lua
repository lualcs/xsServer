--[[
    file:cx_table.lua 
    desc:扯旋
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local cx_enum = require("poker_cx.cx_enum")
local pokerTable = require("pokerTable")
---@class cx_table:pokerTable
local cx_table = class(pokerTable)
local this = cx_table

---构造
function cx_table:ctor()
end

---请求
---@param player        cx_player  @玩家
---@param msg           messabeBody @消息
---@return boolean,string|any
function cx_table:message(player,msg)
    local ok,error = self:super(this,"message",player,msg)
    if ok then
        return ok,error
    end
    local cmd = table.last(msg.cmds) 
    if cmd == cx_enum.cx_qp() then
        ok,error = self:gameCastCard(player)--弃牌
    elseif cmd == cx_enum.cx_gz() then
        ok,error = self:gameWithBet(player)--跟注
    elseif cmd == cx_enum.cx_jz() then
        local index = msg.details
        ok,error = self:gameRefuelBet(player,index)--加注
    elseif cmd == cx_enum.cx_sh() then
        ok,error = self:gameShowhandBet(player)--梭哈
    elseif cmd == cx_enum.cx_gdd() then
        ok,error = self:gameTraceBet(player)--跟到底
    end
    return ok,error
end

---看牌
---@param player       cx_player
function cx_table:gameSeeCard(player)
    --本局玩家
    local senum = cx_enum.join()
    if not player:getStatusBy(senum) then
        return false,"看牌:非参与者"
    end

    --重复检查
    local senum = cx_enum.cx_kp()
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
---@param player       cx_player
function cx_table:gameCastCard(player)
    --本局玩家
    local senum = cx_enum.join()
    if not player:getStatusBy(senum) then
        return false,"弃牌:非参与者"
    end

    --重复检查
    local senum = cx_enum.cx_qp()
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
---@param player       cx_player
function cx_table:gameWithBet(player)
    --本局玩家
    local senum = cx_enum.join()
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
---@param data cx_game_start_ntc @数据
function cx_table:ntfMsgToStart(data)
    self:ntfMsgToTable(data)
end

---发牌通知
---@param data cx_deal_ntc @数据
function cx_table:ntfMsgToDealCard(data)
    self:ntfMsgToTable(data)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---看牌通知
---@param data cx_see_ntc @数据
function cx_table:ntfMsgToSeeCard(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable(data,see_info)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---放弃通知
---@param data cx_giveup_ntc @数据
function cx_table:ntfMsgToGiveup(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable(data,see_info)
end

---加注通知
---@param data cx_bet_refuel_ntc @数据
function cx_table:ntfMsgToRefuel(data)
    self:ntfMsgToTable(data)
end

---跟注通知
---@param data cx_bet_with_ntc @数据
function cx_table:ntfMsgToBetWith(data)
    self:ntfMsgToTable(data)
end

---梭哈通知
---@param data cx_bet_all_ntc @数据
function cx_table:ntfMsgToBetAll(data)
    self:ntfMsgToTable(data)
end

---结果通知
---@param data cx_game_result_ntc @数据
function cx_table:ntfMsgToGameResult(data)
    self:ntfMsgToTable(data)
end

return cx_table