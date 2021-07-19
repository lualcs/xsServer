--[[
    file:sg_struct.lua 
    desc:三公
    auth:Caorl Luo
]]

---@alias sg_score number 
---积分

---@alias sg_double number
---倍数

---@alias sg_type senum
---牌型

---@alias sg_index number
---下标

---@alias sg_enum senum
---枚举

---@alias sg_seat number
---位置

---@alias sg_card number
---牌值

---@alias sg_value number
---牌值 

---@alias sg_color number
---花色

---@class sg_seat_cards                    @玩家手牌
---@field seatID    sg_seat                @玩家
---@field hand      sg_card[]              @手牌

---@class sg_deal_ntc                      @发牌通知
---@field seatID    sg_seat                @玩家
---@field count     sg_count               @张数

---@class sg_see_ntc                       @看牌通知
---@field seatID    sg_seat                @玩家
---@field hand      sg_card[]              @手牌

---@class sg_giveup_ntc                    @放弃通知
---@field seatID    sg_seat                @玩家
---@field hand      sg_card[]              @手牌

---@class sg_bet_refuel_ntc                @加注通知
---@field seatID    sg_seat                @玩家
---@field score     sg_score               @下注
---@field blance    sg_score               @余额

---@class sg_bet_with_ntc                  @跟注通知
---@field seatID    sg_seat                @玩家
---@field score     sg_score               @下注
---@field blance    sg_score               @余额

---@class sg_bet_all_ntc                   @梭哈通知
---@field seatID    sg_seat                @玩家
---@field score     sg_score               @下注
---@field blance    sg_score               @余额

---@class sg_cmp_card_ntc                  @比牌通知
---@field originID    sg_seat              @发起玩家
---@field targetID    sg_seat              @目标玩家
---@field winnerID    sg_seat              @胜利玩家
---@field originSP    sg_card[]            @发起手牌
---@field targetSP    sg_card[]            @目标手牌
---@field originPX    sgType              @发起牌型
---@field targetPX    sgType              @目标牌型
---@field comparCB    sg_score             @比牌成本
---@field blanceLY    sg_score             @剩余分数

---@class sg_game_result_ntc               @结果通知
---@field winnerID    sg_seat              @胜利玩家
---@field reaScore    sg_score             @实际得分
---@field ducScore    sg_score             @应得分数
---@field blanceLJ    sg_score             @剩余分数
---@field openseat    sg_seat[]            @开牌状态
---@field giveseat    sg_seat[]            @放弃状态
---@field loseseat    sg_seat[]            @淘汰状态
---@field cardseat    sg_seat_cards[][]    @玩家手牌


---@class sg_game_start_ntc:game_start_ntc @开始通知