--[[
    file:bullAlgor.lua 
    desc:算法
    auth:Caorl Luo
]]

local pairs = pairs
local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local pokerAlgor = require("poker.algor")
---@class bullAlgor:pokerAlgor
local algor = class(pokerAlgor)
local this = algor
---构造 
function algor:ctor()
    ---是否支持坎斗
    ---@type boolean
    self._bfTriplet = false
    ---是否支持顺斗
    self._bfStraight = false
end


---坎斗
---@return boolean
function algor:setSupportTriplet(support)
    self._bfTriplet = support
end

---顺斗
---@return boolean
function algor:setSupportTriplet(support)
    self._bfTriplet = support
end

---坎斗
---@return boolean
function algor:getSupportTriplet()
    return self._bfTriplet
end

---顺斗
---@return boolean
function algor:getSupportStraight()
    return self._bfStraight
end

local copy1 = {nil}
local copy2 = {nil}
---分析
---@param hands pkCard[]         @手牌
---@param repe boolean|nil      @true:重复 false:唯一
---@return bullMethod
function algor:getMethod(hands,repe)
    ---癞子
    ---@type pkCard[]
    local lzs = table.clear(copy1)
    ---手牌
    ---@type pkCard[]
    local sps = table.clear(copy2)

    for _,card in ipairs(hands) do
        if self:isLaizi(card) then
            table.insert(lzs,card)
        else
            table.insert(sps,card)
        end
    end
    local ana = self:super(this,"getMethod",hands,repe)
    ana.lzs = lzs
    ana.sps = sps
    return ana
end

local copy1 = {nil}
local copy2 = {nil}
---点数
---@param hands pkCard[] @手牌数据
---@return bullNumber,pkCard[]
function algor:getBullCount(hands)
    ---帮助
    ---@type bullHelper
    local hp = self._hlp
    ---坎斗
    ---@type boolean
    local kd = self:getSupportTriplet()
    ---顺斗
    ---@type boolean
    local sd = self:getSupportStraight()
    ---扑克分析
    local analy = self:getMethod(hands,true)
    local cpyls = table.copy(analy.sps,copy2)
    local lzs = analy.lzs
    local cnt = #lzs

    if cnt < 2 then
        --检查排除癞子是否有牛
        local max
        local fts
        for a,aCard in ipairs(cpyls) do
            for b,bCard in ipairs(cpyls) do
                if a ~= b then
                    for c,cCard in ipairs(cpyls) do
                        if c ~= a and c ~= a then
                            ---点数
                            local ad = hp:getPoint(aCard)
                            local bd = hp:getPoint(bCard)
                            local cd = hp:getPoint(cCard)
                            ---有牛
                            ---@type boolean
                            local yd = false
                            ---点数
                            ---@type number
                            local pd = 0

                            if 0 == (ad + bd + cd) % 10 then
                                --普通
                                yd = true
                            elseif ad == bd and bd == cd then
                                --坎斗
                                if kd then
                                    yd = true
                                end
                            elseif sd then
                                local av = hp:getValue(aCard)
                                local bv = hp:getValue(bCard)
                                local cv = hp:getValue(cCard)
                                --顺斗
                                if  (av+1 == bv and bv+1 == cv) or--123
                                    (av+1 == cv and cv+1 == bv) or--132
                                    (bv+1 == av and av+1 == cv) or--213
                                    (bv+1 == cv and cv+1 == av) or--231
                                    (cv+1 == av and av+1 == bv) or--312
                                    (cv+1 == bv and bv+1 == av)   --321
                                then
                                    yd = true
                                end
                            end

                            if yd then
                                if 0 == cnt then
                                    --计算牌点数
                                    local dd = hp:getPoint(table.remove(cpyls))
                                    local ed = hp:getPoint(table.remove(cpyls))
                                    local sd = (dd + ed) % 10
                                    pd = 0 == sd and 10 or sd
                                else
                                    pd = 10
                                end
                            end

                            if not max or max < pd then
                                max = pd
                                fts = function()
                                    ---提示
                                    local ts = table.clear(copy1)
                                    table.push_args(ts,aCard,bCard,cCard)
                                    --保存前三个
                                    table.push_args(ts,aCard,bCard,cCard)
                                    --降序前三个
                                    self:cardSort(ts,true)
                                    --保存后两个
                                    table.remove_args(cpyls,aCard,bCard,cCard)
                                    --排序后两个
                                    self:cardSort(cpyls,true)
                                    table.push_list(ts,cpyls)
                                    return pd,ts
                                end
                            end
                            --已经最大点数
                            if pd == 10 then
                                return fts()
                            end
                        end
                    end
                end
            end
        end
        return fts()
    end
    --单个癞子
    if cnt == 1 then
        --提示扑克数据
        local ts = table.clear(copy1)
        --组合最大点数
        local max
        local fts
        for a,dCard in ipairs(cpyls) do
            for b,eCard in ipairs(cpyls) do
                if a ~= b then
                    local dd = hp:getPoint(dCard)
                    local ed = hp:getPoint(eCard)
                    local sd = (dd + ed) % 10
                    local pd = 0 == sd and 10 or sd
                    if not max or max < pd then
                        max = pd
                        fts = function()
                            --填充前三个
                            table.remove_args(cpyls,dCard,eCard)
                            table.push_list(ts,cpyls)
                            table.insert(ts,table.remove(lzs))
                            --降序前三个
                            self:cardSort(ts,true)
                            --填充后两个
                            if self.cardCompart(dCard,eCard) then
                                table.insert(ts,dCard)
                                table.insert(ts,eCard)
                            else
                                table.insert(ts,eCard)
                                table.insert(ts,dCard)
                            end
                        end
                    end
                end
            end
        end
        return max,ts
    elseif cnt > 1 then
        local ts = table.clear(copy1)
        --填充前三个
        while #lzs > 1 and #ts < 3 do
            table.insert(ts,table.remove(lzs))
        end
        while #ts < 3 do
            table.insert(ts,table.remove(cpyls))
        end
        --降序前三个
        self:cardSort(ts,true)
        --填充后两个
        table.push_list(cpyls,lzs)
        --降序后两个
        self:cardSort(cpyls,true)
        table.push_args(ts,cpyls)

        return 10,ts
    end
    return 0,hands
end

return algor