--[[
    desc:类型判断
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local class = require("class")
local sort = require("sort")
local table = require("extend_table")
local bullEnum = require("bull.enum")
local pokerType = require("poker.type")
---@class bullType:pokerType
local type = class(pokerType)

---构造函数
function type:ctor()
end

---获取牌型
---@param hands pkCard[] @手牌 
---@return senum
function type:getPokerType(hands)
    ---牛牛算法
    ---@type bullAlgor
    local algor = self._gor
    ---扑克分析
    ---@type pokerLayout
    local layout = algor:getLayout(hands,true)
    ---神癞牛
    if self:ifGodRuffian(hands,layout) then
        return bullEnum.godRuffian()
    ---神话牛
    elseif self:ifMythCattle(hands,layout) then
        return bullEnum.mythCattle()
    ---天王牛
    elseif self:ifSkyKing(hands,layout) then
        return bullEnum.skyKing()
    ---地王牛
    elseif self:ifLandKing(hands,layout) then
        return bullEnum.landKing()
    ---对王牛
    elseif self:ifPairKing(hands,layout) then
        return bullEnum.pairKing()
    ---五炸牛
    elseif self:ifFiveBomb(hands,layout) then
        algor:cardSort(hands,true)
        return bullEnum.fiveBomb()
    ---同花顺
    elseif self:ifStraightFlush(hands,layout) then
        algor:cardSort(hands,true)
        return bullEnum.straightFlush()
    ---炸弹牛
    elseif self:ifBomb(hands,layout) then
        algor:cardSort(hands,true)
        return bullEnum.bomb()
    ---五小牛
    elseif self:ifFiveLittle(hands,layout) then
        algor:cardSort(hands,true)
        return bullEnum.fiveLittle()
    ---五花牛
    elseif self:ifFiveFlower(hands,layout) then
        algor:cardSort(hands,true)
        return bullEnum.fiveFlower()
    ---葫芦牛
    elseif self:ifCalabash(hands,layout) then
        return bullEnum.calabash()
    ---同花牛
    elseif self:ifFlush(hands,layout) then
        algor:cardSort(hands,true)
        return bullEnum.flush()
    ---顺子牛
    elseif self:ifStraight(hands,layout) then
        algor:cardSort(hands,true)
    return bullEnum.straight()
    ---大王牛
    elseif self:ifLargeKing(hands,layout) then
        return bullEnum.largeKing()
    ---小王牛
    elseif self:ifSmallKing(hands,layout) then
        return bullEnum.smallKing()
    else
        local point = algor:getCattleWho(hands)
        if point == 10 then
            return bullEnum.bullCattle()
        elseif point == 9 then
            return bullEnum.nineCattle()
        elseif point == 8 then
            return bullEnum.eightCattle()
        elseif point == 7 then
            return bullEnum.sevenCattle()
        elseif point == 6 then
            return bullEnum.sixCattle()
        elseif point == 5 then
            return bullEnum.fiveCattle()
        elseif point == 4 then
            return bullEnum.fourCattle()
        elseif point == 3 then
            return bullEnum.threeCattle()
        elseif point == 2 then
            return bullEnum.towCattle()
        elseif point == 1 then
            return bullEnum.oneCattle()
        else
            return bullEnum.zeroCattle()
        end
    end
end

local kingSky = {0x4e,0x4f,0x5f}
---神癞牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifGodRuffian(hands,layout)

    ---癞子列表
    ---@type pkCard[]
    local laizis = layout.laizis

    ---必须都是癞子
    if #laizis < 5 then
        return false
    end

    ---大王小王天牌
    if not table.existVals(laizis,kingSky) then
        return false
    end

    return true
end

---神话牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifMythCattle(hands,layout)

    ---癞子列表
    ---@type pkCard[]
    local laizis = layout.laizis
    ---大王小王天牌
    if not table.existVals(laizis,kingSky) then
        return false
    end

    ---牛牛辅助
    ---@type bullHelper
    local h = self._hlp
    ---JQK
    local pokers = layout.pokers
    for _,card in ipairs(pokers) do
        if h.getValue(card) < 11 then
            return false
        end
    end

    return true
end

---天地对王牛
---@param hands  pkCard[] @手牌数据
---@param fixed  pkCard[] @必含扑克
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifWhoForKing(hands,layout,fixed)
    ---癞子列表
    ---@type pkCard[]
    local laizis = layout.laizis
    ---检查对王
    if not table.existVals(laizis,fixed) then
        return false
    end

    ---牛牛辅助
    ---@type bullHelper
    local help = self._hlp
    ---斗牛判断
    local cards = help.getFilters(hands,fixed)
    if not help:ifFightBull(cards) then
        return false
    end

    return true
end

local fixedCards = {0x4f,0x5f}
---天王牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifSkyKing(hands,layout)
    return self:ifWhoForKing(hands,layout,fixedCards)
end

local fixedCards = {0x4e,0x5f}
---地王牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifSkyKing(hands,layout)
    return self:ifWhoForKing(hands,layout,fixedCards)
end

local fixedCards = {0x4e,0x4f,0x5f}
---对王牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifPairKing(hands,layout)
    return self:ifWhoForKing(hands,layout,fixedCards)
end

---五炸牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifFiveBomb(hands,layout)
    local laizis = layout.laizis
    local pokers = layout.pokers
    if 1 == #laizis and 4 == #pokers then
        --普通炸弹
        if not table.empty(layout.tetrads) then
            return true
        end
    elseif 5 == #laizis then
        --癞子炸弹
        if not table.empty(layout.tetrads) then
            return true
        end 
    end
    return false
end

---炸弹牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifBomb(hands,layout)
    local laizis = layout.laizis
    if not table.empty(layout.tetrads) then
        return true
    elseif not table.empty(layout.triples) then
        if #laizis >= 1 then
            return true
        end
    elseif not table.empty(layout.doubles) then
        if #laizis >= 2 then
            return true
        end
    end

    return #laizis >= 3
end

---五小牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifFiveLittle(hands,layout)
    ---@type bullHelper
    local helpe = self._hlp
    local total = #(layout.lzs)
    for _,card in ipairs(layout.sps) do
        local value = helpe.getValue(card)
        if value >= 5 then
            total = total + value
            return false
        end

        if total > 10 then
            return false
        end
    end
    return true
end


---一条龙
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:asA2345(hands,layout)
    if not self:ifStraight(hands,layout) then
        return false
    end
    ---牛牛帮助
    ---@type bullHelper
    ---单牌检查
    local help = self._hlp
    for _,card in ipairs(layout.sps) do
        if help.getValue(card) > 5 then
            return false
        end
    end
    return true
end

local copy1 = {nil}
local copy2 = {0X1,0xa,0xb,0xc,0xd}
---顺子牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifStraight(hands,layout)
    ---癞子列表
    local laizis = layout.laizis
    
    ---牛牛算法
    ---@type bullHelper
    local help = self._hlp
    ---牛牛算法
    ---@type bullAlgor
    local algor = self._gor
    local cards = table.clear(copy1)
    for _,card in ipairs(hands) do
        if not algor:ifRuffian(card) then
            local value = help.getValue(card)
            table.insert(cards,value)
        end
    end

    ---排序
    table.sort(cards)
    ---A10JQK
    local special = copy2
    local needlzi = 0
    local index = 1
    for _,value in ipairs(cards) do
        if value ~= special[index] then
            if needlzi >= #laizis then
                return false
            else
                index = index + 1 
            end
        end
        index = index + 1
    end


    return true
end

---同花牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifFlush(hands,layout)
    local hlp = self._hlp
    local sps = layout.sps
    for i,card in ipairs(sps) do
        local n = i + 1
        if sps[n] then
            local aColor = hlp:getColor(card)
            local bColor = hlp:getColor(sps[n])
            if aColor ~= bColor then
                return false
            end
        end
    end
    return true
end

---同花顺
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifStraightFlush(hands,layout)
    return self:ifFlush(hands,layout) and self:ifStraight(hands,layout)
end

---五花牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifFiveFlower(hands,layout)
    ---@type bullHelper
    local hlp = self._hlp
    local sps = layout.sps
    for i,card in ipairs(sps) do
        local n = i + 1
        if sps[n] then
            if hlp:getValue(card) <= 10 then
                return false
            end
        end
    end
    return true
end


---小王牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifSmallKing(hands,layout)
    
    if not table.exist(layout.lzs,0x4e) then
        return false
    end

    if table.arrElementtCount(layout.lzs) >= 2 then
        return true
    end

    ---@type bullAlgor
    local algor = self._gor
    local point = algor:getCattleWho(hands)
    if 10 ~= point then
        return false
    end
    
    return true
end

---大王牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:asBullKing(hands,layout)
    
    if not table.exist(layout.lzs,0x4e) then
        return false
    end

    if table.arrElementtCount(layout.lzs) >= 2 then
        return true
    end

    ---@type bullAlgor
    local algor = self._gor
    local point = algor:getCattleWho(hands)
    if 10 ~= point then
        return false
    end
    
    return true
end

---葫芦牛
---@param hands pkCard[] @手牌数据
---@param layout pokerLayout @分析数据
---@return boolean 
function type:ifCalabash(hands,layout)

    --3个癞子
    local lzCount = #(layout.lzs)
    if lzCount >= 3 then
        return true
    end

    --三条+对子
    if #layout.doubles == 1 and #layout.triples == 1 then
        return true
    end

    --两对+癞子*1
    if #layout.doubles == 2 and lzCount == 1 then
        return true
    end

    --三条+癞子*2
    if #layout.triples == 1 and lzCount == 2 then
        return true
    end
    
    return false
end


return type