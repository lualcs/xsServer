--[[
    file:mahjongArithmetic.lua 
    desc:胡牌算法
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local skynet = require("skynet")
local tostring = require("extend_tostring")
local string = require("extend_string")
local table = require("extend_table")
local math = require("extend_math")
local mjHelper = require("mahjongHelper")
---@class arithmetic 麻将算法
local arithmetic = {
    init = false,           --是否初始化
    support_qidui = true,   --默认支持七对
}

local this = arithmetic

---@class mapping 胡牌隐射
local mapping = require("mahjongMapping")

local keys = {}
local function mappingKey(...)
    local args = {...}
    table.clear(keys)
    for _,arr in ipairs(args) do
        for v,count in pairs(arr) do
            for i=1,count do
                table.insert(keys,v)
            end
        end
    end
    table.sort(keys)
    local key = 0
    for i,v in ipairs(keys) do
        key = key + (v << (i*4))
    end
    return key
end

--所有刻子
 local kz111 = {[1]=3}
 local kz222 = {[2]=3}
 local kz333 = {[3]=3}
 local kz444 = {[4]=3}
 local kz555 = {[5]=3}
 local kz666 = {[6]=3}
 local kz777 = {[7]=3}
 local kz888 = {[8]=3}
 local kz999 = {[9]=3}

 --所有顺子
 local sz123 = {[1]=1,[2]=1,[3]=1}
 local sz234 = {[2]=1,[3]=1,[4]=1}
 local sz345 = {[3]=1,[4]=1,[5]=1}
 local sz456 = {[4]=1,[5]=1,[6]=1}
 local sz567 = {[5]=1,[6]=1,[7]=1}
 local sz678 = {[6]=1,[7]=1,[8]=1}
 local sz789 = {[7]=1,[8]=1,[9]=1}


local arrGroup = {
    --所有刻子
    kz111,
    kz222,
    kz333,
    kz444,
    kz555,
    kz666,
    kz777,
    kz888,
    kz999,
    --所有顺子
    sz123,
    sz234,
    sz345,
    sz456,
    sz567,
    sz678,
    sz789,
}

local hasGroup = {
    [1] = {sz123,kz111},
    [2] = {sz123,sz234,kz222},
    [3] = {sz123,sz234,sz345,kz333},
    [4] = {sz234,sz345,sz456,kz444},
    [5] = {sz345,sz456,sz567,kz555},
    [6] = {sz456,sz567,sz678,kz666},
    [7] = {sz567,sz678,sz789,kz777},
    [8] = {sz678,sz789,kz888},
    [9] = {sz789,kz999},
}

--允许顺牌隐射
local mapSun = {}
--允许顺牌分组(为了兼容类似乱三风)
local sunGroup = {}

---@field inittialize 胡牌算法初始化
---@param sunData 允许顺的牌
function arithmetic.inittialize(sunData)
    --避免重复初始化
    if this.init then
        return
    end

    --填充允许顺子信息
    for _id,_item in pairs(sunData) do
        for value = _item.start,_item.close do
            local mj = mjHelper.getCard(_item.color,value)
            mapSun[mj] = true
            sunGroup[mj] = _id
        end
    end

    --填充隐射 不需要癞子
    -- for _,m1 in ipairs(arrGroup) do
    --     for _,m2 in ipairs(arrGroup) do
    --         for _,m3 in ipairs(arrGroup) do
    --             for _,m4 in ipairs(arrGroup) do
    --                 --没有癞子的情况
    --                 mapping[mappingKey(m1,m2,m3,m4)]=0
    --                 mapping[mappingKey(m1,m2,m3)]=0
    --                 mapping[mappingKey(m1,m2)]=0
    --                 mapping[mappingKey(m1)]=0
    --             end
    --         end
    --     end
    -- end

    -- skynet.error("mahjong:",tostring(mapping))


    --标记初始化
    this.init = true
end

---@field ableKanHu 坎胡检查
---@param hasHand   手牌
---@return an       分析数据
---@return jiang    将对麻将
function arithmetic.analyze(hasHand,lzCount)
    local an = {}
    --统计每种花色的牌
    local dui = 0
    --只能组成刻子牌
    local jiang = false
    --必须要有将对
    local hasJiang = false
    for mj,count in pairs(hasHand) do
        if mapSun[mj] then
            local sunID = sunGroup[mj]
            local value = mjHelper.getValue(mj)
            local has = an[sunID] or {}
            has[value] = count
            an[sunID] = has
        else
            --没有癞子的情况
            if 0 == lzCount then
                --可以取将
                if 0 == count % 2 then
                    jiang = mj
                    dui = dui + 1
                --无法取将并且无法成刻
                elseif 0 ~= count % 2 and 0 ~= count % 3 then
                    return false
                end
            end
        end

        if count > 1 then
            hasJiang = true
        end
    end

    --没有癞子的情况
    if 0 == lzCount then
        --只能有一个将对
        if dui > 1 then
            return false
        end
        --必须要有将对
        if not hasJiang then
            return false
        end
    end

    return an,jiang
end

 ---@field checkQiDui 判断是否七对
 ---@param lzCount 癞子数量
function arithmetic.checkQiDui(has,lzCount)
    local mjCount = lzCount
    for mj,count in pairs(has) do
        if 0 ~= count then
            lzCount = lzCount - 1
            if lzCount < 0 then
                return false
            end
        end
        mjCount = mjCount + count
    end
    return 14 == mjCount
end

---@field ableHu 胡牌检查
---@param hand  手牌
---@param lz 癞子麻将
function arithmetic.ableHu(hand,lz)

    local len = #hand
    if 2 == len then
        return hand[1] == hand[2]
    end

    if 2 ~= len % 3 then
        return false
    end

    local has = table.arrToHas(hand)

    local lzCount = has[lz] or 0
    if lz then
        has[lz] = nil
    end

    --癞子到达一定数量直接胡
    if lzCount > ((len-2)/3*2) then
        return true
    end

    --是否七对
    if this.support_qidui then
        if this.checkQiDui(has,lzCount) then
            return true
        end
    end

    return this.ableKanHu(has,lzCount)
end

function arithmetic.ableKanHu(has,lzCount)
    local an,jiang = this.analyze(has,lzCount)
   
    if not an then
        return false
    end

    local mks = {}

    --如果将对固定了
    if jiang then
        return this.ableKan(an,mks,lzCount)
    end
    
    --没有癞子
    if 0 == lzCount then
        for mj,count in pairs(has) do
            local value = mjHelper.getValue(mj)
            --去除将对
            if count >= 2 then
                --不成顺的不能做将牌
                if mapSun[mj] then
                    local sunID = sunGroup[mj]
                    mks[sunID] = nil

                    local lis = an[sunID]
                    --是否可以取将对
                    if 2 == count % 3 then
                        lis[value] = lis[value] - 2
                        if this.ableKan(an,mks,lzCount) then
                            return true
                        end
                        lis[value] = lis[value] + 2
                    end
                end
            end      
        end
    --存在癞子
    else
        for mj,count in pairs(has) do
            local value = mjHelper.getValue(mj)
            local sunID = sunGroup[mj]
            local lis = an[sunID]
            --清除key
            mks[sunID] = nil
            --去除将对
            if count < 2 then
                --包含癞子
                lis[value] = lis[value] - 1
                if this.ableKan(an,mks,lzCount - 1) then
                    return true
                end
                lis[value] = lis[value] + 1
            else
                --没有癞子
                lis[value] = lis[value] - 2
                if this.ableKan(an,mks,lzCount) then
                    return true
                end
                lis[value] = lis[value] + 2
            end
        end
    end

    return false
end

---@field ableKan 坎胡检查
---@param an  分析数据
---@param mks 隐射键
function arithmetic.ableKan(an,mks,lzCount)

    --判断已经存在的（避免不必要的mappingKey消耗）
    for sunID,key in pairs(mks) do
        if -1 == key then
            return false
        end
    end

    --判断每种花色
    local totalNeed = 0
    for sunID,has in pairs(an) do
        mks[sunID] = mks[sunID] or mappingKey(has)
        local need = this.needLaiZi(has,mks[sunID])

        --如果癞子不够了
        totalNeed = totalNeed + need
        if lzCount < totalNeed then
            return false
        end
    end
    --require("skynet").error("ableKan:",tostring({mks=mks,an=an}))
    return true
end


---@field needLaiZi 需要癞子数量
---@return number 需要的癞子数量
function arithmetic.needLaiZi(has,key)
    --不需要癞子
    if mapping[key] then
        return 0
    end
    
    --统计多少张牌
    local sum = table.sum_has(has)

    --一张牌一定缺2张癞子
    if 1 == sum then
        return 2
    end

    --2张牌
    local arr = table.hasToArr(has)
    if 2 == sum then
        --刻子
        if arr[1] == arr[2] then
            return 1
        end
        --顺子
        if math.abs(arr[1]-arr[2]) <= 2 then
            return 1
        end
    end
    
    --穷举所有可能-返回需要最小的癞子
    local max = sum * 2         --最大需要癞子
    local min = sum % 3         --最少需要癞子
    local fin = max             --实际需要癞子

    local hastm = this.referType(has)
    local arrtm = table.hasToArr(hastm)
    fin = this.poorLaiZi(has,arrtm)
    --最多就是自身2倍
    return fin
end

---@field referType 获得涉及的所有牌型
function arithmetic.referType(has)
    local hastm = table.fortab()
    for mj,_ in pairs(has) do
        for _,mt in pairs(hasGroup[mj]) do
            hastm[mt]=1
        end
    end
    return hastm
end

--穷举所有癞子
function arithmetic.poorLaiZi(has,arrtm)
end





---@field getTingInfo   听牌检查
---@param hand          手牌
---@param hasfull       所有牌
---@param lz_mj         癞子
function arithmetic.getTingInfo(hand,hasfull,lz_mj)
    local ting = table.fortab()
    --重新拷贝一份
    local hand = table.copy(hand)
    local an = mjHelper.getAnalyze(hand,lz_mj)

    local hasMahjongSelf = table.arrToHas(hand)
    for _out,_ in pairs(hasMahjongSelf) do
        --移除出牌
        table.find_remove(hand,_out)
        for _get,_ in pairs(hasfull) do
            --自己没有的不检查(除非有癞子)
            local color = mjHelper.getColor(_get)
            if an.hasColor[color] or an.lz_num > 0 then
                --添加获取
                table.insert(hand,_get)
                if this.checkAbleHu(hand,this.lz_mj) then
                    ting[_out] = ting[_out] or table.fortab()
                    ting[_out][_get] = true
                end
                --移除获取
                table.remove(hand,#hand)
            end
        end
        --还原出牌
        table.insert(hand,_out)
    end
    return ting
end

---@field setSupportQiDui 设置七对标志
function arithmetic.setSupportQiDui(suppor)
    this.support_qidui = suppor
end

return arithmetic



--[[

    {
        this.support_qidui = true 默认支持七对
    }

    胡牌思路
    查表法 总数量 46375 种

    听牌检查-无癞子情况
        1、自己没有的牌不用考虑
        2、无法得到将牌不用考虑

    将牌确定-无癞子情况
        1、字牌不成顺如果只有一对那么将牌就固定了
]]