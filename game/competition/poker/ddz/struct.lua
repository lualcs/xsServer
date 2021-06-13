--[[
    file:ddz_struct.lua 
    desc:炸金花
    auth:Caorl Luo
]]

---@alias ddz_score number 
---积分

---@alias ddz_double number
---倍数

---@alias ddz_type senum
---牌型

---@alias ddz_index number
---下标

---@alias ddz_enum senum
---枚举

---@alias ddz_seat number
---位置

---@alias ddz_card number
---牌值

---@alias ddz_value number
---牌值 

---@alias ddz_color number
---花色

---@class ddz_seat_cards                    @玩家手牌
---@field seatID    ddz_seat                @玩家
---@field hand      ddz_card[]              @手牌

---@class ddz_deal_ntc                      @发牌通知
---@field seatID    ddz_seat                @玩家
---@field count     ddz_count               @张数

---@class ddz_see_ntc                       @看牌通知
---@field seatID    ddz_seat                @玩家
---@field hand      ddz_card[]              @手牌

---@class ddz_giveup_ntc                    @放弃通知
---@field seatID    ddz_seat                @玩家
---@field hand      ddz_card[]              @手牌

---@class ddz_bet_refuel_ntc                @加注通知
---@field seatID    ddz_seat                @玩家
---@field score     ddz_score               @下注
---@field blance    ddz_score               @余额

---@class ddz_bet_with_ntc                  @跟注通知
---@field seatID    ddz_seat                @玩家
---@field score     ddz_score               @下注
---@field blance    ddz_score               @余额

---@class ddz_bet_all_ntc                   @梭哈通知
---@field seatID    ddz_seat                @玩家
---@field score     ddz_score               @下注
---@field blance    ddz_score               @余额

---@class ddz_cmp_card_ntc                  @比牌通知
---@field originID    ddz_seat              @发起玩家
---@field targetID    ddz_seat              @目标玩家
---@field winnerID    ddz_seat              @胜利玩家
---@field originSP    ddz_card[]            @发起手牌
---@field targetSP    ddz_card[]            @目标手牌
---@field originPX    ddz_type              @发起牌型
---@field targetPX    ddz_type              @目标牌型
---@field comparCB    ddz_score             @比牌成本
---@field blanceLY    ddz_score             @剩余分数

---@class ddz_game_result_ntc               @结果通知
---@field winnerID    ddz_seat              @胜利玩家
---@field reaScore    ddz_score             @实际得分
---@field ducScore    ddz_score             @应得分数
---@field blanceLJ    ddz_score             @剩余分数
---@field openseat    ddz_seat[]            @开牌状态
---@field giveseat    ddz_seat[]            @放弃状态
---@field loseseat    ddz_seat[]            @淘汰状态
---@field cardseat    ddz_seat_cards[][]    @玩家手牌


---@class ddz_game_start_ntc:game_start_ntc @开始通知