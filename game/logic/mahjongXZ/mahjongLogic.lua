--[[
    file:GameLogic.lua
    desc:血战麻将
    auth:Karl Luo
]]

local ipairs = ipairs

local class = require("class")
local table = require("extend_table")
local sort = require("sort")
local mjHelper = require("mahjongHelper")

local mahjongLogic = class("mahjongPokerLogicXZ")

---@param rule 游戏规则
function mahjongLogic:cotr(rule)

    ---@field rule 游戏规则
    self.rule = rule

    ---@field left_mahjong 剩余麻将
    self.left_mahjong = {
        --[[
            [1~n:108] = mj
        ]]
    }

    ---@field left_mahjong 已发麻将
    self.deal_mahjong = {
        --[[
            [mj] = count
        ]]
    }

    ---@field show_mahjong 明牌麻将
    self.show_mahjong = {
        --[[
            [mj] = count
        ]]
    }

    ---@field left_mahjong 玩家麻将
    self.user_mahjong = {
    }

    ---@field work_mahjong 动作记录
    self.work_mahjong = {
        --[[
            [self.out_uniq] = {
                [1~n] = {
                    wt =  摸牌  出牌 碰牌  杠牌  胡牌
                    mj =  麻将
                    sit = 哪个玩家的操作
                    pos =  哪家的牌：摸牌出牌 都是自己 碰牌杠牌胡牌 自己或者别人
                }
            }
        ]]
    }

    ---@field out_uniq 出牌id
    self.out_uniq = 0

end

---@field initialize 数据初始化
function mahjongLogic:initialize()
    table.clear(self.left_mahjong)
    table.clear(self.deal_mahjong)
    table.clear(self.show_mahjong)
    table.clear(self.user_mahjong)
    table.clear(self.work_mahjong)
    ---@field out_uniq 出牌id
    self.out_uniq = 0

    --初始化
    for sit=1,self.rule.sitCount do
        self.user_mahjong[sit] = {
            ---@field hand 玩家手牌
            hand = {
                --[[
                    [1~14] = mj
                ]]
            },

            ---@field gang 玩家杠牌
            gang = {
                --[[
                    [1~n:4] = {
                        mj = 杠牌
                        gt = 类型  暗杠  明杠  补杠
                        st = 杠哪家牌
                    }
                ]]
            },
            ---@field peng 玩家碰牌
            peng = {
                --[[
                    [1~n:4] = {
                        mj = 碰牌
                        st = 碰哪家牌
                    }

                ]]
            },

            ---@field hsz_set 换三张换出去
            hsz_set = {
                --[[
                    [1~3] = mj
                ]]
            },

            ---@field hsz_get 换三张换回来
            hsz_get = {
                --[[
                    [1~3] = mj
                ]]
            },

            ---@field hsz_get 换三张换回来
            hsz_get = {
                --[[
                    [1~3] = mj
                ]]
            },

            ---@field out_mj 玩家出牌
            out_mj = {--如果 被吃 碰 杠 胡 不在此列
                --[[
                    [1~n] = mj
                ]]
            },
            
            ---@field dq_color 定缺花色
            dq_color = nil,
            ---@field hu_type 胡牌类型
            hu_type = nil,
        }
    end
end


---@field gameStartXP 洗牌
function mahjongLogic:gameStartXP()
    --初始化数据
    self:initialize()
    --拷贝扑克
    table.absorb(self.left_mahjong,self.rule.mahjongCard)
    --麻将乱序
    sort.shuffle(self.left_mahjong)
end

---@field gameStartFP 发牌
---@param bankerID 庄家
function mahjongLogic:gameStartFP(bankerID)
    ---@field bankerID 庄家
    self.bankerID = bankerID
    local max_sit = self.rule.sitCount
    for i=1,13 do
        for sit=bankerID,bankerID+max_sit do
            if sit > max_sit then
                self:gamePlayingMP(sit-max_sit)
            else
                self:gamePlayingMP(sit)
            end
        end
    end
    --庄家再摸一张
    self:gamePlayingMP(bankerID)
end


---@field gamePlayingMP 摸牌
---@param sit 位置
---@return 摸了那张牌
function mahjongLogic:gamePlayingMP(sit)

    local hand = self.user_mahjong[sit].hand
    local left = self.left_mahjong
    local last = #left
    local mj = left[last]
    
    table.insert(hand,mj)
    table.remove(left,last)

    --记录已发扑克
    local deal = self.deal_mahjong
    deal[mj] = (deal[mj] or 0)+1

    --记录动作
    local wt = mjHelper.wk_mp()
    self:gamePlayingWork(sit,wt,mj,sit)
    return last
end


---@field gamePlayingCP 出牌
---@param sit 位置
---@return 出了那张牌
function mahjongLogic:gamePlayingCP(sit,mj)

    --移除一张牌
    local hand = self.user_mahjong[sit].hand
    if not table.find_remove(hand,mj) then
        return false
    end

    --记录出牌
    local out_mj = self.user_mahjong[sit].out_mj
    table.insert(out_mj,mj)

    --记录出牌id
    self.out_uniq = self.out_uniq + 1

    --记录明牌
    local show_mahjong = self.show_mahjong
    show_mahjong[mj] = (show_mahjong[mj] or 0) + 1

    --记录动作
    local wt = mjHelper.wk_cp()
    self:gamePlayingWork(sit,wt,mj,sit)
    return mj
end

---@field gamePlayingPeng 碰
---@param sit 位置
---@param mj 麻将
function mahjongLogic:gamePlayingPeng(sit,mj)

    --来自哪里
    local work = self.work_mahjong[self.out_uniq]
    local len = #work
    local pos = work[len].pos
   
    --移除麻将
    local hand = self.user_mahjong[sit].hand
    if not table.find_remove(hand,mj,2) then
        return false
    end

    --记录碰牌
    local peng = self.user_mahjong[sit].peng
    local pq = table.fortab()
    pq.mj = mj
    pq.st = pos
    table.insert(peng,pq)

    --记录明牌
    local show_mahjong = self.show_mahjong
    show_mahjong[mj] = (show_mahjong[mj] or 0) + 3

    --记录动作
    local wt = mjHelper.wk_peng()
    self:gamePlayingWork(sit,wt,mj,pos)
    return true
end

---@field gamePlayingGang 杠
---@param sit 位置
---@param mj 麻将
function mahjongLogic:gamePlayingGang(sit,mj,wt)

    --来自哪里
    local work = self.work_mahjong[self.out_uniq]
    local len = #work
    local pos = work[len].pos

    --记录杠牌
    local peng = self.user_mahjong[sit].peng
    local gp = table.fortab()
    gp.mj = mj
    gp.st = pos
    table.insert(peng,gp)

    --记录动作
    self:gamePlayingWork(sit,wt,mj,pos)
    return true
end

---@field gamePlayingGang 明杠
function mahjongLogic:gamePlayingMingGang(sit,mj)
    --移除麻将
    local hand = self.user_mahjong[sit].hand
    table.find_remove(hand,mj,3)

    --记录明牌
    local show_mahjong = self.show_mahjong
    show_mahjong[mj] = 4

    self:gamePlayingGang(sit,mj,mjHelper.wk_ming_gang())
end

---@field gamePlayingAnGang 暗杠
function mahjongLogic:gamePlayingAnGang(sit,mj)
    --移除麻将
    local hand = self.user_mahjong[sit].hand
    table.find_remove(hand,mj,4)

    --记录明牌
    local show_mahjong = self.show_mahjong
    show_mahjong[mj] = 0

    self:gamePlayingGang(sit,mj,mjHelper.wk_an_gang())
end

---@field gamePlayingBuGang 补杠
function mahjongLogic:gamePlayingBuGang(sit,mj)
    --移除麻将
    local hand = self.user_mahjong[sit].hand
    table.find_remove(hand,mj,1)
    --移除碰牌
    local peng = self.user_mahjong[sit].peng
    for pos,item in ipairs(peng) do
        if mj == item.mj then
            table.remove(peng,pos)
            break
        end
    end

    --记录明牌
    local show_mahjong = self.show_mahjong
    show_mahjong[mj] = 4

    self:gamePlayingGang(sit,mj,mjHelper.wk_bu_gang())
end

---@field gamePlayingHu 胡
---@param sit 位置
---@param mj 麻将
---@param huClass 胡牌类型
function mahjongLogic:gamePlayingHu(sit,mj,huClass)

    --来自哪里
    local work = self.work_mahjong[self.out_uniq]
    local len = #work
    local pos = work[len].pos
   
    --移除麻将
    local hand = self.user_mahjong[sit].hand
    if not table.find_remove(hand,mj,3) then
    end

    --记录胡
    local user = self.user_mahjong[sit]
    user.hu_type = huClass

    --记录动作
    local wt = mjHelper.wk_hu()
    self:gamePlayingWork(sit,wt,mj,pos)
    return true
end

---@param sit 座位
---@param wt  动作
---@param mj  麻将
---@param st  麻将来自哪个玩家座位
---@field gamePlayingWork  记录动作
function mahjongLogic:gamePlayingWork(sit,wt,mj,pos)
    --记录动作数据
    local action = table.fortab()
    action.sit = sit
    action.pos = pos
    action.wt = wt
    action.mj = mj
    local work = self.work_mahjong[self.out_uniq]
    if not work then
        work = table.fortab()
        self.work_mahjong[self.out_uniq] = work
    end

    table.insert(work,action)
end


return mahjongLogic