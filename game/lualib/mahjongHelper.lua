--[[
]]

local ipairs = ipairs
local pairs = pairs
local setmetatable = setmetatable
local skynet = require("skynet")
local mahjongName = require("mahjongName")
local table = require("extend_table")
local math = require("extend_math")
local sort = require("sort")

local tostring = require("tostring")

--设置tostring 好做打印 调试
local function set_mt_tostring(t)
    local mt_tostring = t.__tostring
    t.__tostring = nil
    setmetatable(t,{__tostring=mt_tostring})
end

--1:各种刻子
local wan111 = {[0x01]=3,__tostring = function() return "wan111" end}  set_mt_tostring(wan111)
local wan222 = {[0x02]=3,__tostring = function() return "wan222" end}  set_mt_tostring(wan222)
local wan333 = {[0x03]=3,__tostring = function() return "wan333" end}  set_mt_tostring(wan333)
local wan444 = {[0x04]=3,__tostring = function() return "wan444" end}  set_mt_tostring(wan444)
local wan555 = {[0x05]=3,__tostring = function() return "wan555" end}  set_mt_tostring(wan555)
local wan666 = {[0x06]=3,__tostring = function() return "wan666" end}  set_mt_tostring(wan666)
local wan777 = {[0x07]=3,__tostring = function() return "wan777" end}  set_mt_tostring(wan777)
local wan888 = {[0x08]=3,__tostring = function() return "wan888" end}  set_mt_tostring(wan888)
local wan999 = {[0x09]=3,__tostring = function() return "wan999" end}  set_mt_tostring(wan999)

local suo111 = {[0x11]=3,__tostring = function() return "suo111" end}   set_mt_tostring(suo111)
local suo222 = {[0x12]=3,__tostring = function() return "suo222" end}   set_mt_tostring(suo222)
local suo333 = {[0x13]=3,__tostring = function() return "suo333" end}   set_mt_tostring(suo333)
local suo444 = {[0x14]=3,__tostring = function() return "suo444" end}   set_mt_tostring(suo444)
local suo555 = {[0x15]=3,__tostring = function() return "suo555" end}   set_mt_tostring(suo555)
local suo666 = {[0x16]=3,__tostring = function() return "suo666" end}   set_mt_tostring(suo666)
local suo777 = {[0x17]=3,__tostring = function() return "suo777" end}   set_mt_tostring(suo777)
local suo888 = {[0x18]=3,__tostring = function() return "suo888" end}   set_mt_tostring(suo888)
local suo999 = {[0x19]=3,__tostring = function() return "suo999" end}   set_mt_tostring(suo999)

local ton111 = {[0x21]=3,__tostring = function() return "ton111" end}   set_mt_tostring(ton111)
local ton222 = {[0x22]=3,__tostring = function() return "ton222" end}   set_mt_tostring(ton222)
local ton333 = {[0x23]=3,__tostring = function() return "ton333" end}   set_mt_tostring(ton333)
local ton444 = {[0x24]=3,__tostring = function() return "ton444" end}   set_mt_tostring(ton444)
local ton555 = {[0x25]=3,__tostring = function() return "ton555" end}   set_mt_tostring(ton555)
local ton666 = {[0x26]=3,__tostring = function() return "ton666" end}   set_mt_tostring(ton666)
local ton777 = {[0x27]=3,__tostring = function() return "ton777" end}   set_mt_tostring(ton777)
local ton888 = {[0x28]=3,__tostring = function() return "ton888" end}   set_mt_tostring(ton888)
local ton999 = {[0x29]=3,__tostring = function() return "ton999" end}   set_mt_tostring(ton999)

--2:各种顺子
local wan123 = {[0x01]=1,[0x02]=1,[0x03]=1,__tostring = function() return "wan123" end} set_mt_tostring(wan123) 
local suo123 = {[0x11]=1,[0x12]=1,[0x13]=1,__tostring = function() return "suo123" end} set_mt_tostring(suo123)
local ton123 = {[0x21]=1,[0x22]=1,[0x23]=1,__tostring = function() return "ton123" end} set_mt_tostring(ton123)

local wan234 = {[0x02]=1,[0x03]=1,[0x04]=1,__tostring = function() return "wan234" end} set_mt_tostring(wan234)
local suo234 = {[0x12]=1,[0x13]=1,[0x14]=1,__tostring = function() return "suo234" end} set_mt_tostring(suo234)
local ton234 = {[0x22]=1,[0x23]=1,[0x24]=1,__tostring = function() return "ton234" end} set_mt_tostring(ton234)

local wan345 = {[0x03]=1,[0x04]=1,[0x05]=1,__tostring = function() return "wan345" end} set_mt_tostring(wan345)
local suo345 = {[0x13]=1,[0x14]=1,[0x15]=1,__tostring = function() return "suo345" end} set_mt_tostring(suo345)
local ton345 = {[0x23]=1,[0x24]=1,[0x25]=1,__tostring = function() return "ton345" end} set_mt_tostring(ton345)

local wan456 = {[0x04]=1,[0x05]=1,[0x06]=1,__tostring = function() return "wan456" end} set_mt_tostring(wan456)
local suo456 = {[0x14]=1,[0x15]=1,[0x16]=1,__tostring = function() return "suo456" end} set_mt_tostring(suo456)
local ton456 = {[0x24]=1,[0x25]=1,[0x26]=1,__tostring = function() return "ton456" end} set_mt_tostring(ton456)

local wan567 = {[0x05]=1,[0x06]=1,[0x07]=1,__tostring = function() return "wan567" end} set_mt_tostring(wan567)
local suo567 = {[0x15]=1,[0x16]=1,[0x17]=1,__tostring = function() return "suo567" end} set_mt_tostring(suo567)
local ton567 = {[0x25]=1,[0x26]=1,[0x27]=1,__tostring = function() return "ton567" end} set_mt_tostring(ton567)

local wan678 = {[0x06]=1,[0x07]=1,[0x08]=1,__tostring = function() return "wan678" end} set_mt_tostring(wan678)
local suo678 = {[0x16]=1,[0x17]=1,[0x18]=1,__tostring = function() return "suo678" end} set_mt_tostring(suo678)
local ton678 = {[0x26]=1,[0x27]=1,[0x28]=1,__tostring = function() return "ton678" end} set_mt_tostring(ton678)

local wan789 = {[0x07]=1,[0x08]=1,[0x09]=1,__tostring = function() return "wan789" end} set_mt_tostring(wan789)
local suo789 = {[0x17]=1,[0x18]=1,[0x19]=1,__tostring = function() return "suo789" end} set_mt_tostring(suo789)
local ton789 = {[0x27]=1,[0x28]=1,[0x29]=1,__tostring = function() return "ton789" end} set_mt_tostring(ton789)

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
    return (mj & 0xf0)>>4
end

function helper.getValue(mj)
    return mj & 0x0f
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
    for _inx,_mj in pairs(mjCard) do

        if 10 == _mj then
            skynet.error("error getAnalyze:",tostring(mjCard))
        end

        local color = this.getColor(_mj)
        hasCard[_mj] = (hasCard[_mj] or 0) + 1
        hasColor[color] = (hasColor[color] or 0) + 1
    end
	return an
end

--分析可以组合哪些牌型 仅仅支持万条筒
function helper.getHasType(hasMahjong)
    
    local has = {}
    for mj,count in pairs(hasMahjong) do
        local ts = wttMap[mj]  --牌型列表
        local sc = #ts - 1     --0~sc 顺子牌型下标
        --刻子牌型
        if count >= 3 then
            local mt = ts[#ts]
            has[mt] = (count // 3)
        end

        --顺子牌型
        for i=1,sc do
            local mt = ts[i]
            local mc = count
            for _mj,_count in pairs(mt) do
                mc = math.min(mc,hasMahjong[_mj] or 0)
            end
            has[mt] = mc
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
    for _mj,count in pairs(hasCard) do
        if count >= 2 then
            local c = this.getColor(_mj)
            hasCard[_mj] = hasCard[_mj] - 2
            hasColor[c] = hasColor[c] - 2
            if this.checkPing(hasCard,hasColor) then
                return true
            end
            hasCard[_mj] = hasCard[_mj] + 2
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
    for mj,count in pairs(t) do
        if 1 == count then
            return true
        end
    end
    return false
end

--是否刻子
local function is_ke(t)
    for mj,count in pairs(t) do
        if 3 == count then
            return true
        end
    end
    return false
end

--[[
    获取排序值 poker = 255 * 3
]]
local function get_sk_logic(t)
    local sum = table.sum_has_k(t)
    if is_ke(t) then
        sum = sum + 1000
    end
    return sum
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
    return (groupType.sz1 <= group and group <= groupType.sz4) or (group == groupType.ks1)
end

local function is_allow_kz(group)
    return groupType.kz1 <= group and group <= groupType.ks1
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
    @local has_mt = { type:只包含万条筒的牌型：表地址
        [table:type] = count,
    }
 
    --手牌里的万条筒-组合统计 参考：groupType
    @local group = {--mj:只包含万条筒
        [mj] = {--index:1~n
            [index] = groupType.xxx
        }
    }

    --筛选允许牌型
    @local may_mt = {--
        [table:type] = true
    }

    --允许组合牌型
    @local arr_mt {--index:1 ~ n
        [index] = table:type 牌型表
    }

    @param 
]]
function helper.wttPing(hasWTT,hasColor)


    local has_mt = helper.getHasType(hasWTT)
    local mjCount = table.sum_has(hasWTT)
    local mtCount = table.sum_has(has_mt)

    if mtCount < mjCount // 3 then
        return false
    end

    local group = table.fortab()
    for mj,count in pairs(hasWTT) do
        local unit = table.fortab()
        group[mj] = unit
        if 1 == count  then
            if not this.checkSun(has_mt,mj,count) then
                return false
            end
            table.insert(unit,groupType.sz1)--1个顺子
        elseif 2 == count then
            if not this.checkSun(has_mt,mj,count) then
                return false
            end
            table.insert(unit,groupType.sz2)--2个顺子
        elseif 3 == count then
            table.insert(unit,groupType.kz1)--1个刻子
            if this.checkSun(has_mt,mj,count) then
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
            if this.checkSun(has_mt,mj,count) then
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
            if this.checkSunKe(has_mt,mj,1,1) then
                table.insert(unit,groupType.ks1)--1刻子+1顺子
            else
                return false
            end
            
        end
    end

    --统计允许牌型
    local may_mt = table.fortab()
    for _mj,_lis in pairs(group) do
        local ts = wttMap[_mj]
        for _inx,_group in pairs(_lis) do
            if is_allow_sz(_group) then
                local kp = #ts
                local kt = ts[kp]
                for _inx,_mt in ipairs(ts) do
                    if kt == _mt then
                       break
                    end
                    may_mt[_mt] = true
                end
            end
            if is_allow_kz(_group) then
                local kp = #ts
                local kt = ts[kp]
                may_mt[kt] = true
            end
        end
    end

    --获得实际牌型
    local arr_mt = table.fortab()
    for _mt,_count in pairs(has_mt) do
        if may_mt[_mt] then
            table.insertEx(arr_mt,_mt,_count)
        else
            has_mt[_mt] = nil
        end
    end

    if this.first then
        return false
    end

    if not this.first then
        --递归执行组合
        skynet.error(tostring{
            hasWTT = hasWTT,
            arr_mt = arr_mt,
            has_mt = has_mt,
        })
        this.first = true
    end

    --排序
    table.sort(arr_mt,helper.mt_compare)

    return this.dg_group_hu(hasWTT,arr_mt,has_mt)
end

function helper.mt_compare(a,b)
    local av = get_sk_logic(a)
    local bv = get_sk_logic(b)
    return av < bv
end




local dg_count = 0
local function dg_group_hu(hasWTT,arr_mt,has_mt)
    dg_count = dg_count + 1
    local mj_count = table.sum_has(hasWTT)
    if 0 == mj_count then
        return true
    end

    local mt_count = table.sum_has(has_mt)
    if 0 == mt_count then
        return false
    end
    
    local has_rmt = table.fortab()
    for _,_mt in ipairs(arr_mt) do
        --类型过滤
        if has_mt[_mt] <= 0 then
            goto continue
        end

        --记录取牌
        for _mj,_count in pairs(_mt) do
            hasWTT[_mj] = hasWTT[_mj] - _count
        end
        
        --取出类型
        has_rmt[_mt]  = (has_rmt[_mt] or 0) + 1

        --取出扑克-会影响其他-牌型的组合-是否还可以组成
        for _mj,_count in pairs(_mt) do
            for _,_mt in pairs(wttMap[_mj]) do
                --顺子
                if is_shun(_mt) and has_mt[_mt] then
                    local left_mj = hasWTT[_mj]
                    local left_mt = has_mt[_mt] - (has_rmt[_mt] or 0)
                    if left_mt > left_mj then
                        has_rmt[_mt] = (has_rmt[_mt] or 0) + 1
                    end
                end
            end
        end

         --移除数据
         table.ventgas(has_mt,has_rmt)
         if dg_group_hu(hasWTT,arr_mt,has_mt) then
             return true
         end
         --恢复数据
         table.absorb(has_mt,has_rmt)
         table.clear(has_rmt)

         --还原取牌
         for _mj,_count in pairs(_mt) do
            hasWTT[_mj] = hasWTT[_mj] + _count
        end

        ::continue::
    end

    return false
end

helper.dg_group_hu = dg_group_hu

--[[听牌提示
    @param mjCard = {
        [1~n] = mj
    }
   
    @return ting = {--mj:麻将
        [mj] = {--inx:1~n
            [inx] = mj
        }
    }
]]

local for_able_count = 0
function helper.getTingInfo(mjCard,hasMahjongFull)
    local ting = table.fortab()

    local len = #mjCard
    if 14 == len then
        local mjCardCopy = table.copy(mjCard)
        local an = this.getAnalyze(mjCardCopy)

        --听牌过滤花色 < 2的
        local smallColor = 0
        for _color,_count in pairs(an.hasColor) do
            --少于2张牌连 对子都无法组成
            if _count < 2 then
                return ting
            end

            --2个花色 <= 2 无法听牌
            if _count <= 2 then
                smallColor = smallColor + 1
            end
        end

        --最多一个花色的牌 为2张
        if smallColor > 1 then
            return ting
        end

        local hasMahjongSelf = this.getHasCount(mjCardCopy)
        for _out_mj,_count in pairs(hasMahjongSelf) do
            table.find_remove(mjCardCopy,_out_mj)
            for _ting_mj,_count in pairs(hasMahjongFull) do
                --花色 < 2 连将对都 无法组成
                local color = this.getColor(_ting_mj)
                local cNumber = an.hasColor[color] or 0
                if cNumber >= 2 then
                    table.insert(mjCardCopy,_ting_mj)
                    for_able_count = for_able_count + 1
                    if this.checkAbleHu(mjCardCopy) then
                        ting[_out_mj] = ting[_out_mj] or table.fortab()
                        ting[_out_mj][_ting_mj] = true
                    end
                    table.remove(mjCardCopy,#mjCardCopy)
                end
            end
            table.insert(mjCardCopy,_out_mj)
        end
    end
    
    return ting
end

function helper.start_dg_count()
    for_able_count = 0
    dg_count = 0
end

function helper.Look_dg_count()
    skynet.error("递归次数：",dg_count,"听检查次数：",for_able_count,"平均递归次数",dg_count//for_able_count)
end



return helper


--[[
   
]]