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
local mjHelper = require("mahjongHelper")
---@class arithmetic 麻将算法
---@field ableHu 胡牌检查
---@field init   是否初始化
local arithmetic = {
    init = false,       --是否初始化
    
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

local function mappingKey4(a,b,c,d)
    return mappingKey(a,b,c,d)
end

local function mappingKey3(a,b,c)
    return mappingKey(a,b,c)
end

local function mappingKey2(a,b)
    return mappingKey(a,b)
end

local function mappingKey1(a)
    return mappingKey(a)
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


local mapSun = {            --允许组顺子
    [0x01] = true,     --1万
    [0x02] = true,     --2万
    [0x03] = true,     --3万
    [0x04] = true,     --4万
    [0x05] = true,     --5万
    [0x06] = true,     --6万
    [0x07] = true,     --7万
    [0x08] = true,     --8万
    [0x09] = true,     --9万

    [0x11] = true,     --1条
    [0x12] = true,     --2条
    [0x13] = true,     --3条
    [0x14] = true,     --4条
    [0x15] = true,     --5条
    [0x16] = true,     --6条
    [0x17] = true,     --7条
    [0x18] = true,     --8条
    [0x19] = true,     --9条

    [0x21] = true,     --1筒
    [0x22] = true,     --2筒
    [0x23] = true,     --3筒
    [0x24] = true,     --4筒
    [0x25] = true,     --5筒
    [0x26] = true,     --6筒
    [0x27] = true,     --7筒
    [0x28] = true,     --8筒
    [0x29] = true,     --9筒
}

function arithmetic.inittialize()
    --避免重复初始化
    if this.init then
        return
    end

    --填充隐射
    -- for _,m1 in ipairs(arrGroup) do
    --     for _,m2 in ipairs(arrGroup) do
    --         for _,m3 in ipairs(arrGroup) do
    --             for _,m4 in ipairs(arrGroup) do
    --                 mapping[mappingKey4(m1,m2,m3,m4)] = true
    --                 mapping[mappingKey3(m1,m2,m3)] = true
    --                 mapping[mappingKey2(m1,m2)] = true
    --                 mapping[mappingKey1(m1)] = true
    --             end
    --         end
    --     end
    -- end

    -- skynet.error("mahjong:",tostring(mapping))


    --标记初始化
    this.init = true
end

---@field ableKanHu 坎胡检查
---@param hasHand  手牌
---@return an       分析数据
---@return mj      将对麻将
function arithmetic.analyze(hasHand)
    local an = {}
    --统计每种花色的牌
    local dui = 0
    --只能组成刻子牌
    local jiang = false
    for mj,count in pairs(hasHand) do
        if mapSun[mj] then
            local color = mjHelper.getColor(mj)
            local value = mjHelper.getValue(mj)
            local has = an[color] or {}
            has[value] = count
            an[color] = has
        else
            if 0 == count % 2 then
                jiang = mj
                dui = dui + 1
            elseif 0 ~= count % 2 and 0 ~= count % 3 then
                return false
            end
        end
        
    end

    --只能有一个将对
    if dui > 1 then
        return false
    end

    return an,jiang
end

---@field ableHu 胡牌检查
---@param hand  手牌
function arithmetic.ableHu(hand)

    local len = #hand
    if 2 == len then
        return hand[1] == hand[2]
    end

    if 2 ~= len % 3 then
        return false
    end

    local has = table.has_count(hand)
    local an,jiang = this.analyze(has)
   
    if not an then
        return false
    end

    local mks = {}

    --如果将对固定了
    if jiang then
        return this.ableKanHu(an,mks)
    end
    
    for mj,count in pairs(has) do
        local color = mjHelper.getColor(mj)
        local value = mjHelper.getValue(mj)
        --去除将对
        if count >= 2 then
            if mapSun[mj] then
                mks[color] = nil
                an[color][value] = an[color][value] - 2
                if this.ableKanHu(an,mks) then
                    return true
                end
                an[color][value] = an[color][value] + 2
            end
        end      
    end

    --判断是否七对
    if mjHelper.checkQiDui(hand) then
        return true
    end

    return false
end

---@field ableKanHu 坎胡检查
---@param an  分析数据
function arithmetic.ableKanHu(an,mks)
    --判断每种花色
    for color,has in pairs(an) do
        mks[color] = mks[color] or mappingKey(has)
        if not mapping[mks[color]] then
            return false
        end
    end
    --require("skynet").error("ableKanHu:",tostring({mks=mks,an=an}))
    return true
end

arithmetic.inittialize()

return arithmetic



--[[
    胡牌思路
    查表法 总数量 46375 种
]]