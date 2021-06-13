--[[
    file:bullType.lua 
    desc:类型判断  所有牌型：  3162510
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
function type:getCardType(hands)
    ---@type bullAlgor
    local algor = self._gor
    ---@type bullMethod
    local analy = algor:getMethod(hands,true)
     --双王牛
    if self:asBullDoubleKing(hands,analy) then
        return bullEnum.bullDoubleKing()
    --五炸牛
    elseif self:asBullFiveBomb(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullFiveBomb()
    --同花顺
    elseif self:asBullStraightFlush(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullStraightFlush()
    --炸弹牛
    elseif self:asBullBomb(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullBomb()
    --五小牛
    elseif self:asBullFiveSmall(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullFiveSmall()
    --五花牛
    elseif self:asBullFiveFlower(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullFiveFlower()
    --顺子牛
    elseif self:asBullStraight(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullStraight()
    --葫芦牛
    elseif self:asBullCalabash(hands,analy) then
        return bullEnum.bullCalabash()
    --小王牛
    elseif self:asBullKinglet(hands,analy) then
        return bullEnum.bullKinglet()
    --同花牛
    elseif self:asBullFlush(hands,analy) then
        algor:cardSort(hands,true)
        return bullEnum.bullFlush()
    else
        local point = algor:getBullCount(hands)
        if point == 10 then
            return bullEnum.bullBull()
        elseif point == 9 then
            return bullEnum.bullNine()
        elseif point == 8 then
            return bullEnum.bullEight()
        elseif point == 7 then
            return bullEnum.bullSeven()
        elseif point == 6 then
            return bullEnum.bullSix()
        elseif point == 5 then
            return bullEnum.bullFiveF()
        elseif point == 4 then
            return bullEnum.bullFour()
        elseif point == 3 then
            return bullEnum.bullThree()
        elseif point == 2 then
            return bullEnum.bullTwo()
        elseif point == 1 then
            return bullEnum.bullOne()
        else
            return bullEnum.bullZero()
        end
    end
end

---五炸牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullFiveBomb(hands,analy)
    local lzs = analy.lzs

    if 1 == #lzs then
        --普通炸弹
        if not table.empty(analy.fourles) then
            return true
        end
    elseif 5 == #lzs then
        --癞子炸弹
        if not table.empty(analy.fourles) then
            return true
        end 
    end
    return false
end

---炸弹牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:bullBomb(hands,analy)
    local lzs = analy.lzs
    if not table.empty(analy.fourles) then
        return true
    elseif not table.empty(analy.triples) then
        if not table.empty(analy.lzs) then
            return true
        end
    elseif not table.empty(analy.doubles) then
        if table.arrElementtCount(analy.lzs) >= 2 then
            ---@type bullAlgor
            local algor = self._gor
            for _,card in ipairs(analy.doubles) do
                if not algor:isLaizi(card) then
                    return true
                end
            end
        end
    elseif not table.empty(analy.singles) then
        if table.arrElementtCount(analy.lzs) >= 3 then
            ---@type bullAlgor
            local algor = self._gor
            for _,card in ipairs(analy.singles) do
                if not algor:isLaizi(card) then
                    return true
                end
            end
        end
    end
    return false
end

---五小牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullFiveSmall(hands,analy)
    ---@type bullHelper
    local hp = self._hlp
    local total = #(analy.lzs)
    for _,card in ipairs(analy.sps) do
        local point = hp:getPoint(card)
        if point > 5 then
            total = total + point
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
---@param analy bullMethod @分析数据
---@return boolean 
function type:asA2345(hands,analy)
    if not self:asBullStraight(hands,analy) then
        return false
    end
    ---牛牛帮助
    ---@type bullHelper
    ---单牌检查
    local hp = self._hlp
    for _,card in ipairs(analy.sps) do
        if hp:getValue(card) > 5 then
            return false
        end
    end
    return true
end

---顺子牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullStraight(hands,analy)
    ---癞子列表
    local lzs = analy.lzs
    ---手牌列表
    local sps = analy.sps
    ---牛牛算法
    ---@type bullAlgor
    local algor = self._gor
    algor:cardSort(sps)
    ---牛牛帮助
    ---@type bullHelper
    local hp = self._hlp
    local lc = #lzs
    for i,card in ipairs(sps) do
        local n = i + 1
        if sps[n] then
            local av = hp:getValue(card)
            local bv = hp:getValue(sps[n])
            local di = bv - av - 1
            if di > 0 then
                if lc < di then
                    return false
                else
                    lc = lc - di
                end
            end
        end
    end
    return true
end

---同花牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullFlush(hands,analy)
    local hlp = self._hlp
    local sps = analy.sps
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
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullStraightFlush(hands,analy)
    return self:asBullFlush(hands,analy) and self:asBullStraight(hands,analy)
end

---五花牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullFiveFlower(hands,analy)
    ---@type bullHelper
    local hlp = self._hlp
    local sps = analy.sps
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

---双王牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullDoubleKing(hands,analy)
    
    local lzs = analy.lzs
    if not table.exitst(lzs,0x4e) then
        return false
    end

    if not table.exist(lzs,0x4f) then
        return false
    end

   
    if #lzs >= 3 then
        return false
    end

    local ds = 0
    ---@type bullHelper
    local hlp = self._hlp
    for _,card in ipairs(analy.sps) do
        ds = ds + hlp:getPoint(card)
    end

    if ds % 10 ~= 0 then
        return false
    end

    return true
end

---小王牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullKinglet(hands,analy)
    
    if not table.exist(analy.lzs,0x4e) then
        return false
    end

    if table.arrElementtCount(analy.lzs) >= 2 then
        return true
    end

    ---@type bullAlgor
    local algor = self._gor
    local point = algor:getBullCount(hands)
    if 10 ~= point then
        return false
    end
    
    return true
end

---大王牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullKing(hands,analy)
    
    if not table.exist(analy.lzs,0x4e) then
        return false
    end

    if table.arrElementtCount(analy.lzs) >= 2 then
        return true
    end

    ---@type bullAlgor
    local algor = self._gor
    local point = algor:getBullCount(hands)
    if 10 ~= point then
        return false
    end
    
    return true
end

---葫芦牛
---@param hands pkCard[] @手牌数据
---@param analy bullMethod @分析数据
---@return boolean 
function type:asBullCalabash(hands,analy)

    --3个癞子
    local lzCount = #(analy.lzs)
    if lzCount >= 3 then
        return true
    end

    --三条+对子
    if #analy.doubles == 1 and #analy.triples == 1 then
        return true
    end

    --两对+癞子*1
    if #analy.doubles == 2 and lzCount == 1 then
        return true
    end

    --三条+癞子*2
    if #analy.triples == 1 and lzCount == 2 then
        return true
    end
    
    return false
end


return type