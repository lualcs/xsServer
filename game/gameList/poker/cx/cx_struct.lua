--[[
    file:cx_struct.lua 
    desc:扯旋
    auth:Caorl Luo
]]

---@alias cx_score number 
---积分

---@alias cx_double number
---倍数

---@alias cx_type senum
---牌型

---@alias cx_index number
---下标

---@alias cx_enum senum
---枚举

---@alias cx_seat number
---位置

---@alias cx_card number
---牌值

---@alias cx_value number
---牌值 

---@alias cx_color number
---花色

---@class cx_seat_cards                    @玩家手牌
---@field seatID    cx_seat                @玩家
---@field hand      cx_card[]              @手牌

---@class cx_deal_ntc                      @发牌通知
---@field seatID    cx_seat                @玩家
---@field count     cx_count               @张数

---@class cx_see_ntc                       @看牌通知
---@field seatID    cx_seat                @玩家
---@field hand      cx_card[]              @手牌

---@class cx_giveup_ntc                    @放弃通知
---@field seatID    cx_seat                @玩家
---@field hand      cx_card[]              @手牌

---@class cx_bet_refuel_ntc                @加注通知
---@field seatID    cx_seat                @玩家
---@field score     cx_score               @下注
---@field blance    cx_score               @余额

---@class cx_bet_with_ntc                  @跟注通知
---@field seatID    cx_seat                @玩家
---@field score     cx_score               @下注
---@field blance    cx_score               @余额

---@class cx_bet_all_ntc                   @梭哈通知
---@field seatID    cx_seat                @玩家
---@field score     cx_score               @下注
---@field blance    cx_score               @余额

---@class cx_cmp_card_ntc                  @比牌通知
---@field originID    cx_seat              @发起玩家
---@field targetID    cx_seat              @目标玩家
---@field winnerID    cx_seat              @胜利玩家
---@field originSP    cx_card[]            @发起手牌
---@field targetSP    cx_card[]            @目标手牌
---@field originPX    cx_type              @发起牌型
---@field targetPX    cx_type              @目标牌型
---@field comparCB    cx_score             @比牌成本
---@field blanceLY    cx_score             @剩余分数

---@class cx_game_result_ntc               @结果通知
---@field winnerID    cx_seat              @胜利玩家
---@field reaScore    cx_score             @实际得分
---@field ducScore    cx_score             @应得分数
---@field blanceLJ    cx_score             @剩余分数
---@field openseat    cx_seat[]            @开牌状态
---@field giveseat    cx_seat[]            @放弃状态
---@field loseseat    cx_seat[]            @淘汰状态
---@field cardseat    cx_seat_cards[][]    @玩家手牌


---@class cx_game_start_ntc:game_start_ntc @开始通知