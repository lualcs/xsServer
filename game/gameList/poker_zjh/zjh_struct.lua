--[[
    file:zjh_struct.lua 
    desc:炸金花
    auth:Caorl Luo
]]

---@alias zjh_score number 
---积分

---@alias zjh_double number
---倍数

---@alias zjh_type senum
---牌型

---@alias zjh_index number
---下标

---@alias zjh_enum senum
---枚举

---@alias zjh_seat number
---位置

---@alias zjh_card number
---牌值

---@alias zjh_value number
---牌值 

---@alias zjh_color number
---花色

---@class zjh_seat_cards                    @玩家手牌
---@field seatID    zjh_seat                @玩家
---@field hand      zjh_card[]              @手牌

---@class zjh_deal_ntc                      @发牌通知
---@field seatID    zjh_seat                @玩家
---@field count     zjh_count               @张数

---@class zjh_see_ntc                       @看牌通知
---@field seatID    zjh_seat                @玩家
---@field hand      zjh_card[]              @手牌

---@class zjh_giveup_ntc                    @放弃通知
---@field seatID    zjh_seat                @玩家
---@field hand      zjh_card[]              @手牌

---@class zjh_bet_refuel_ntc                @加注通知
---@field seatID    zjh_seat                @玩家
---@field score     zjh_score               @下注
---@field blance    zjh_score               @余额

---@class zjh_bet_with_ntc                  @跟注通知
---@field seatID    zjh_seat                @玩家
---@field score     zjh_score               @下注
---@field blance    zjh_score               @余额

---@class zjh_bet_all_ntc                   @梭哈通知
---@field seatID    zjh_seat                @玩家
---@field score     zjh_score               @下注
---@field blance    zjh_score               @余额

---@class zjh_cmp_card_ntc                  @比牌通知
---@field originID    zjh_seat              @发起玩家
---@field targetID    zjh_seat              @目标玩家
---@field winnerID    zjh_seat              @胜利玩家
---@field originSP    zjh_card[]            @发起手牌
---@field targetSP    zjh_card[]            @目标手牌
---@field originPX    zjh_type              @发起牌型
---@field targetPX    zjh_type              @目标牌型
---@field comparCB    zjh_score             @比牌成本
---@field blanceLY    zjh_score             @剩余分数

---@class zjh_game_result_ntc               @结果通知
---@field winnerID    zjh_seat              @胜利玩家
---@field reaScore    zjh_score             @实际得分
---@field ducScore    zjh_score             @应得分数
---@field blanceLJ    zjh_score             @剩余分数
---@field openseat    zjh_seat[]            @开牌状态
---@field giveseat    zjh_seat[]            @放弃状态
---@field loseseat    zjh_seat[]            @淘汰状态
---@field cardseat    zjh_seat_cards[][]    @玩家手牌


---@class zjh_game_start_ntc:game_start_ntc @开始通知