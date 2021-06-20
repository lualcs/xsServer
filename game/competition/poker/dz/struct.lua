--[[
    desc:德州扑克
    auth:Caorl Luo
]]

---@alias dz_score number 
---积分

---@alias dz_double number
---倍数

---@alias dz_type senum
---牌型

---@alias dz_index number
---下标

---@alias dz_enum senum
---枚举

---@alias dz_seat number
---位置

---@alias dz_card number
---牌值

---@alias dz_value number
---牌值 

---@alias dz_color number
---花色

---@class dz_seat_cards                    @玩家手牌
---@field seatID    dz_seat                @玩家
---@field hand      dz_card[]              @手牌

---@class dz_deal_ntc                      @发牌通知
---@field seatID    dz_seat                @玩家
---@field count     dz_count               @张数

---@class dz_see_ntc                       @看牌通知
---@field seatID    dz_seat                @玩家
---@field hand      dz_card[]              @手牌

---@class dz_giveup_ntc                    @放弃通知
---@field seatID    dz_seat                @玩家
---@field hand      dz_card[]              @手牌

---@class dz_bet_refuel_ntc                @加注通知
---@field seatID    dz_seat                @玩家
---@field score     dz_score               @下注
---@field blance    dz_score               @余额

---@class dz_bet_with_ntc                  @跟注通知
---@field seatID    dz_seat                @玩家
---@field score     dz_score               @下注
---@field blance    dz_score               @余额

---@class dz_bet_all_ntc                   @梭哈通知
---@field seatID    dz_seat                @玩家
---@field score     dz_score               @下注
---@field blance    dz_score               @余额

---@class dz_cmp_card_ntc                  @比牌通知
---@field originID    dz_seat              @发起玩家
---@field targetID    dz_seat              @目标玩家
---@field winnerID    dz_seat              @胜利玩家
---@field originSP    dz_card[]            @发起手牌
---@field targetSP    dz_card[]            @目标手牌
---@field originPX    dzType              @发起牌型
---@field targetPX    dzType              @目标牌型
---@field comparCB    dz_score             @比牌成本
---@field blanceLY    dz_score             @剩余分数

---@class dz_game_result_ntc               @结果通知
---@field winnerID    dz_seat              @胜利玩家
---@field reaScore    dz_score             @实际得分
---@field ducScore    dz_score             @应得分数
---@field blanceLJ    dz_score             @剩余分数
---@field openseat    dz_seat[]            @开牌状态
---@field giveseat    dz_seat[]            @放弃状态
---@field loseseat    dz_seat[]            @淘汰状态
---@field cardseat    dz_seat_cards[][]    @玩家手牌


---@class dz_game_start_ntc:game_start_ntc @开始通知