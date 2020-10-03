--[[
    file:mahjongAI.lua 
    desc:麻将AI算法
    auth:Carol Luo
]]

local mjHelper = require("mahjongHelper")

local AI = {}

---@field initData 初始化数据
function AI:initData(level,seat,left,deal,show,logic,game)
    self.level = level      --AI等级
    self.seat = seat        --AI玩家
    self.left = left        --剩余牌
    self.deal = deal        --已发牌
    self.deal = show        --可见牌
    self.logic = logic      --作弊权
    self.game = game        --操作权
end


---@field doAction 智能动作
function AI:doAction()
    if 1 == self.level then
        return AI.actionNormal()
    elseif 2 == self.level then
        return AI.actionMaster()
    elseif 3 == self.level then
        return AI.actionXray()
    elseif 4 == self.level then
        return AI.actionPartner()
    elseif 5 == self.level then
        return AI.actionCheat()
    elseif 6 == self.level then
        return AI.actionDeity()
    end
end

---@field actionNormal 普通级操作
function AI:actionNormal()
end

---@field actionMaster 高手级操作
function AI:actionMaster()
end

---@field actionXray 透视级操作
function AI:actionXray()
end

---@field actionPartner 伙牌级操作
function AI:actionPartner()
end

---@field actionCheat 做弊级操作
function AI:actionCheat()
end

---@field actionDeity 必胜级操作
function AI:actionDeity()
end

return AI

--[[
    用于机器人自动玩麻将

    AI智能等级
    1：胡-杠-碰-吃-无用                                   普通级

    2：择优操作                                          高手级

    3：择优操作+知道所有牌                                透视级

    4：择优操作+知道所有牌+机器配合                        伙牌级

    5：择优操作+知道所有牌+机器配合+换牌操作                作弊级

    6：择优操作+知道所有牌+机器配合+换牌操作+配牌操作        必胜级 

]]