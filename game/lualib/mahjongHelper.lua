--[[
]]

local ipairs = ipairs
local pairs = pairs

local mahjongName = require("mahjongName")
local table = require("extend_table")
local math = require("extend_math")
local sort = require("sort")

--1:各种刻子
local wan111 = {[0x01]=3}
local wan222 = {[0x02]=3}
local wan333 = {[0x03]=3}
local wan444 = {[0x04]=3}
local wan555 = {[0x05]=3}
local wan666 = {[0x06]=3}
local wan777 = {[0x07]=3}
local wan888 = {[0x08]=3}
local wan999 = {[0x09]=3}

local suo111 = {[0x11]=3}
local suo222 = {[0x12]=3}
local suo333 = {[0x13]=3}
local suo444 = {[0x14]=3}
local suo555 = {[0x15]=3}
local suo666 = {[0x16]=3}
local suo777 = {[0x17]=3}
local suo888 = {[0x18]=3}
local suo999 = {[0x19]=3}

local ton111 = {[0x21]=3}
local ton222 = {[0x22]=3}
local ton333 = {[0x23]=3}
local ton444 = {[0x24]=3}
local ton555 = {[0x25]=3}
local ton666 = {[0x26]=3}
local ton777 = {[0x27]=3}
local ton888 = {[0x28]=3}
local ton999 = {[0x29]=3}

--2:各种顺子
local wan123 = {[0x01]=1,[0x02]=1,[0x03]=1}
local suo123 = {[0x11]=1,[0x12]=1,[0x13]=1}
local ton123 = {[0x21]=1,[0x22]=1,[0x23]=1}

local wan234 = {[0x02]=1,[0x03]=1,[0x04]=1}
local suo234 = {[0x12]=1,[0x13]=1,[0x14]=1}
local ton234 = {[0x22]=1,[0x23]=1,[0x24]=1}

local wan345 = {[0x03]=1,[0x04]=1,[0x05]=1}
local suo345 = {[0x13]=1,[0x14]=1,[0x15]=1}
local ton345 = {[0x23]=1,[0x24]=1,[0x25]=1}

local wan456 = {[0x04]=1,[0x05]=1,[0x06]=1}
local suo456 = {[0x14]=1,[0x15]=1,[0x16]=1}
local ton456 = {[0x24]=1,[0x25]=1,[0x26]=1}

local wan567 = {[0x05]=1,[0x06]=1,[0x07]=1}
local suo567 = {[0x15]=1,[0x16]=1,[0x17]=1}
local ton567 = {[0x25]=1,[0x26]=1,[0x27]=1}

local wan678 = {[0x06]=1,[0x07]=1,[0x08]=1}
local suo678 = {[0x16]=1,[0x17]=1,[0x18]=1}
local ton678 = {[0x26]=1,[0x27]=1,[0x28]=1}

local wan789 = {[0x07]=1,[0x08]=1,[0x09]=1}
local suo789 = {[0x17]=1,[0x18]=1,[0x19]=1}
local ton789 = {[0x27]=1,[0x28]=1,[0x29]=1}

--2:扑克隐射
local wttMap = {
    --万
    [0x01] = {wan123,wan111},
    [0x02] = {wan123,wan234,wan222},
    [0x03] = {wan123,wan234,wan345,wan333},
    [0x04] = {wan234,wan345,wan456,wan444},
    [0x05] = {wan345,wan456,wan567,wan555},
    [0x06] = {wan456,wan567,wan789,wan666},
    [0x07] = {wan567,wan678,wan789,wan777},
    [0x08] = {wan678,wan789,wan888},
    [0x09] = {wan789,wan999},

    --条
    [0x11] = {suo123,suo111},
    [0x12] = {suo123,suo234,suo222},
    [0x13] = {suo123,suo234,suo345,suo333},
    [0x14] = {suo234,suo345,suo456,suo444},
    [0x15] = {suo345,suo456,suo567,suo555},
    [0x16] = {suo456,suo567,suo789,suo666},
    [0x17] = {suo567,suo678,suo789,suo777},
    [0x18] = {suo678,suo789,suo888},
    [0x19] = {suo789,suo999},
	
	--筒
    [0x21] = {ton123,ton111},
    [0x22] = {ton123,ton234,ton222},
    [0x23] = {ton123,ton234,ton345,ton333},
    [0x24] = {ton234,ton345,ton456,ton444},
    [0x25] = {ton345,ton456,ton567,ton555},
    [0x26] = {ton456,ton567,ton789,ton666},
    [0x27] = {ton567,ton678,ton789,ton777},
    [0x28] = {ton678,ton789,ton888},
    [0x29] = {ton789,ton999},
}

local helper = {}
local this = helper
function helper.getColor(mj)
    return (mj & 0x0f)>>4
end

function helper.getValue(mj)
    return mj & 0xf0
end

function helper.getCard(color,card)
    return (color<<4)|card
end

function helper.is_wan(mj)
    return 0 == this.getColor(mj)
end

function helper.is_tiao(mj)
    return 1 == this.getColor(mj)
end

function helper.is_tong(mj)
    return 2 == this.getColor(mj)
end

function helper.is_wtt(mj)
    return mj >= 0x01 and mj <= 0x29
end

function helper.is_zi(mj)
    return 3 == this.getColor(mj)
end

function helper.is_hua(mj)
    return 4 == this.getColor(mj)
end

function helper.is_feng(mj)
    return mj >= 0x31 and mj <= 0x34
end

function helper.is_zfb(mj)
    return mj >= 0x35 and mj <= 0x37
end

function helper.getName(mj)
    return mahjongName[mj]
end

function helper.getString(mjCard)
    local t = table.fortab()
    for _,mj in ipairs(mjCard) do
        table.insert(t,this.getName(mj))
    end
    local s = table.concat(t)
    table.recycle(t)
    return s
end

--逻辑值排序
function helper.Sort(mjCard)
	table.sort(mjCard)
end

--扑克乱序
function helper.shuffle(mjCard)
	sort.shuffle(mjCard)
end

--分析数据库存
local anStock = {}
function helper.newAnalyzeData()
    local an = anStock[#anStock]
    anStock[#anStock] = nil
    return an or {
        hasCard={},
        hasColor={},
    }
end

--分析数据回收
function helper.delAnalyzeData(an)
    table.clearEmpty(an)
    anStock[#anStock+1] = an
end

--扑克统计
function helper.getHasCount(mjCard)
    return table.has_count(mjCard)
end

--[[
    return {
        hasCard		= {扑克数量},
        hasColor    = {扑克花色}
    }
]]

--麻将分析
function helper.getAnalyze(mjCard)
    local an = this.newAnalyzeData()
    local hasCard = an.hasCard 
    local hasColor = an.hasColor 
    for k,v in pairs(mjCard) do
        local color = this.getColor(v)
        hasCard[v] = (hasCard[v] or 0) + 1
        hasColor[color] = (hasColor[color] or 0) + 1
    end
	return an
end

--分析可以组合哪些牌型 仅仅支持万条筒
function helper.getHasType(harMahjong)
    local has = {}

    for mj,count in pairs(harMahjong) do
        local ts = wttMap[mj]  --牌型列表
        local sc = #ts - 1     --0~sc 顺子牌型下标
        --刻子牌型
        if count >= 3 then
            local mt = ts[#ts]
            has[mt] = (has[mt] or 0) + (count // 3)
        end

        --顺子牌型
        for i=1,sc do
            local mt = ts[i]
            local mc = count
            for _mj,_count in pairs(mt) do
                mc = math.min(mc,_count)
            end
            has[mt] = (has[mt] or 0) + mc
        end
    end
    return has
end


--检查顺子数量
function helper.checkSun(hasType,mj,count)
    local ts = wttMap[mj]
    local sc = #ts - 1
    local sz_count = 0
    for i=1,sc do
        sz_count = sz_count + (hasType[ts[i]] or 0)
    end

    return sz_count >= count
end



--检查刻子数量
function helper.checkKe(hasType,mj,count)
    local ts = wttMap[mj]
    local ki = #ts
    local kt = ts[ki]
    local kz_count = hasType[kt]
    return kz_count >= count
end

--检查顺刻
function helper.checkSunKe(hasType,mj,sc,kc)
    return this.checkSun(hasType,mj,sc) and this.checkKe(hasType,mj,kc)
end


--胡牌检查
function helper.checkAbleHu(mjCard)
    
    --数量检查
    local len = #mjCard
    if 2 ~= len % 3 then
        return false
    end

    if this.checkQiDui(mjCard) then
        return true
    end

    local an = this.getAnalyze(mjCard)
    local hasCard = an.hasCard
    local hasColor = an.hasColor
    for k,count in pairs(mjCard) do
        if count >= 2 then
            local c = this.getColor(k)
            hasCard[k] = hasCard[k] - 2
            hasColor[c] = hasColor[c] - 2
            if this.checkPing(hasCard,hasColor) then
                return true
            end
            hasCard[k] = hasCard[k] + 2
            hasColor[c] = hasColor[c] + 2
        end
    end

    return false
end

--七对检查
function helper.checkQiDui(mjCard)
    local len = #mjCard
    if 14 ~= len then
        return false
    end
    local has = helper.getHasCount(mjCard)
    for _,count in pairs(has) do
        if 0 ~= count % 2 then
            return false
        end
    end

    return true
end

--平胡检查
function helper.checkPing(hasCard,hasColor)

    --每个花色数量
    for c,count in pairs(hasColor) do
        if 0 ~= count % 3 then
            return false
        end
    end
    
    return this.helpPing(hasCard)
end

--平胡检查
function helper.helpPing(hasMahjong)

    local hasWTT = table.fortab()
    local hasColor = table.fortab()
    for v,count in pairs(hasMahjong) do
        --万条筒
        if this.is_wtt(v) then
            hasWTT[v] = count
            local c = this.getColor(v)
            hasColor[c] = (hasColor[c] or 0) + count
        --字牌
        else
            if 0 ~= count % 3 then
                return false
            end
        end
    end

    return this.wttPing(hasWTT,hasColor)
end

--是否顺子
local function is_shun(t)
    for mj,count in pairs() do
        if 1 == count then
            return true
        end
    end
    return false
end

--是否刻子
local function is_ke(t)
    for mj,count in pairs() do
        if 3 == count then
            return true
        end
    end
    return false
end

local groupType = {
    sz1 = 1,--1个顺子的情况 1张牌必须有包含此牌的顺子1个
    sz2 = 2,--2个顺子的情况 2张牌必须有包含此牌的顺子2个
    sz3 = 3,--3个顺子的情况 3张牌必须有包含此牌的顺子3个                or kz1:情况
    sz4 = 4,--4个顺子的情况 4张牌必须有包含此牌的顺子4个                or ks1:情况         4个顺子直接胡牌
    kz1 = 5,--1个刻子的情况 3张牌必须有包含此牌的刻子1个                or sz3
    ks1 = 6,--1个刻子+1顺子 4张牌必须有包含此牌的(顺子刻子)             or sz4:情况
}

local function is_allow_sz(group)
    return (groupType.sz1 >= group and group <= groupType.sz4) or (group == groupType.ks1)
end

local function is_allow_kz(group)
    return (not(groupType.sz1 >= group and group <= groupType.sz4)) or (group == groupType.ks1)
end


--[[
    检查 万条筒 是否可胡

    --手牌里的万条筒-麻将统计
    @param hasWTT = {--mj:只包含万条筒
        [mj] = count,
    }

    --手牌里的万条筒-花色统计
    @param hasColor = {--color:万条筒 花色数量
        [color] = count,
    }

    --手牌里的万条筒-牌型统计
    @local hasType = { type:只包含万条筒的牌型：表地址
        [table:type] = count,
    }
 
    --手牌里的万条筒-组合统计 参考：groupType
    @local group = {--mj:只包含万条筒
        [mj] = {--index:1~n
            [index] = groupType.xxx
        }
    }

    --筛选允许牌型
    @local may_types = {--
        [table:type] = true
    }

    --允许组合牌型
    @local mj_types {--index:1 ~ n
        [index] = table:type 牌型表
    }

    @param 
]]
function helper.wttPing(hasWTT,hasColor)
    local hasType = helper.getHasType(hasWTT)

    local mjCount = table.sum_has(hasWTT)
    local mtCount = table.sum_has(hasType)

    --直接胡
    if mtCount == mjCount // 3 then
        return true
    end

    local group = table.fortab()
    for mj,count in pairs(hasWTT) do
        local unit = table.fortab()
        group[mj] = unit
        if 1 == count  then
            if not this.checkSun(hasType,mj,count) then
                return false
            end
            table.insert(unit,groupType.sz1)--1个顺子
        elseif 2 == count then
            if not this.checkSun(hasType,mj,count) then
                return false
            end
            table.insert(unit,groupType.sz2)--2个顺子
        elseif 3 == count then
            table.insert(unit,groupType.kz1)--1个刻子
            if this.checkSun(hasType,mj,count) then
                table.insert(unit,groupType.sz3)--3个顺子
                --[[
                    4444：分析情况
                    {
                        --其他情况类似
                        1:234 + 345 + 456
                        2:234 + 345 + 345
                        3:234 + 234 + 345
                        4:234 + 234 + 456
                        5:234 + 234 + 234
                    }

                ]]

            end
        elseif 4 == count then
            --4个顺子
            if this.checkSun(hasType,mj,count) then
                return true--直接胡牌
                --[[
                    4444：分析情况
                    {
                        --其他情况类似
                        1:234+345+456+456
                        2:234+345+345+456
                        3:234+345+345+345
                        4:234+456+456+456
                        5:234+234+345+456
                        6:234+234+345+345
                        7:234+234+456+456
                        7:234+234+234+345
                        8:234+234+234+456
                    }

                ]]
            end
            if this.checkSunKe(hasType,mj,1,1) then
                table.insert(unit,groupType.ks1)--1刻子+1顺子
            else
                return false
            end
            
        end
    end

    --统计允许牌型
    local may_types = table.fortab()
    for _mj,_lis in pairs(hasType) do
        local ts = #wttMap[_mj]
        for _inx,_group in pairs(_lis) do
            if is_allow_sz(_group) then
                local kp = #ts
                local kt = ts[kp]
                for _,_mt in ipairs(ts) do
                    if kt == kt then
                       break
                    end
                    may_types[_mt] = true
                end
            end
            if is_allow_kz(_group) then
                local kp = #ts
                local kt = ts[kp]
                may_types[kt] = true
            end
        end
    end

    --获得实际牌型
    local mj_types = table.fortab()
    for _mt,_count in pairs(hasType) do
        if may_types[_mt] then
            table.insert(mj_types,_mt)
        end
    end

    --递归执行组合
    return this.dg_group_hu(hasWTT,mj_types)
end

local function dg_group_hu(hasWTT,mj_types)
    local mjCount = table.sum_has(hasWTT)
    if 0 == mjCount then
        return true
    end
    
    local hasBack = table.fortab()
    for _inx,_mt in pairs(mj_types) do
        local ok = true
        for _mj,_count in pairs(_mt) do
            if (hasWTT[_mj] or 0) < _count then
                --数据还原
                table.mergeNumber(hasWTT,hasBack)
                ok = false
                break
            else
                --统计数据
                hasWTT[_mj] = hasWTT[_mj] - _count
                hasBack[_mj] = (hasBack[_mj] or 0) + _count
            end
        end
        --取牌成功
        if ok then
            --移除类型
            mj_types[_inx] = nil
            if dg_group_hu(hasWTT,mj_types) then
                --数据还原
                table.mergeNumber(hasWTT,hasBack)
                mj_types[_inx] = _mt
                return true
            else
                --数据还原
                table.mergeNumber(hasWTT,hasBack)
                mj_types[_inx] = _mt
            end
        end
    end

    return false
end

helper.dg_group_hu = dg_group_hu

--[[听牌提示
    @param mjCard = {
        [1~n] = mj
    }
    @param mjCards = {--一整副麻将
        [1~n] = mj
    }
    @return ting = {--mj:麻将
        [mj] = {--inx:1~n
            [inx] = mj
        }
    }
]]

function helper.getTingInfo(mjCard,mjCards,hasMahjongFull)
    local ting = table.fortab()

    local len = #mjCard
    if 14 == mjCard then
        local mjCardCopy = table.copy(mjCard)
        local hasMahjongSelf = this.getHasCount(mjCardCopy)
        for _out_mj,_count in pairs(hasMahjongSelf) do
            table.find_remove(mjCardCopy,_out_mj)
            for _ting_mj,_count in pairs(hasMahjongFull) do
                table.insert(mjCardCopy,_ting_mj)
                if hasMahjongSelf[_ting_mj] < 4 and this.checkAbleHu(mjCardCopy) then
                    ting[_out_mj] = ting[_out_mj] or table.fortab()
                    ting[_out_mj][_ting_mj] = true
                end
                table.remove(mjCardCopy,_ting_mj)
            end
            table.insert(mjCardCopy,_out_mj)
        end
    end
    return ting
end



return helper


--[[
   
]]