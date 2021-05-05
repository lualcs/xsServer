--[[
    file:sg_table.lua 
    desc:三公
    auth:Caorl Luo
]]

local table = table
local class = require("class")
local sg_enum = require("poker_sg.sg_enum")
local pokerTable = require("pokerTable")
---@class sg_table:pokerTable
local sg_table = class(pokerTable)
local this = sg_table

---构造
function sg_table:ctor()
end

---请求
---@param player        sg_player  @玩家
---@param msg           messageInfo @消息
---@return boolean,string|any
function sg_table:message(player,msg)
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
---@param player       sg_player
function sg_table:gameSeeCard(player)
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
---@param player       sg_player
function sg_table:gameCastCard(player)
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
---@param player       sg_player
function sg_table:gameWithBet(player)
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
function sg_table:ntfMsgToStart(data)
    self:ntfMsgToTable(data)
end

---发牌通知
---@param data sg_deal_ntc @数据
function sg_table:ntfMsgToDealCard(data)
    self:ntfMsgToTable(data)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---看牌通知
---@param data sg_see_ntc @数据
function sg_table:ntfMsgToSeeCard(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable(data,see_info)
end

---@type message_see_info   @隐私
local see_info = {
    fields = {"hand"},
}
---放弃通知
---@param data sg_giveup_ntc @数据
function sg_table:ntfMsgToGiveup(data)
    see_info.chairs = {data.seatID}
    self:ntfMsgToTable(data,see_info)
end

---加注通知
---@param data sg_bet_refuel_ntc @数据
function sg_table:ntfMsgToRefuel(data)
    self:ntfMsgToTable(data)
end

---跟注通知
---@param data sg_bet_with_ntc @数据
function sg_table:ntfMsgToBetWith(data)
    self:ntfMsgToTable(data)
end

---梭哈通知
---@param data sg_bet_all_ntc @数据
function sg_table:ntfMsgToBetAll(data)
    self:ntfMsgToTable(data)
end

---结果通知
---@param data sg_game_result_ntc @数据
function sg_table:ntfMsgToGameResult(data)
    self:ntfMsgToTable(data)
end

return sg_table