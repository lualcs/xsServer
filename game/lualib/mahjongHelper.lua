--[[
]]

local ipairs = ipairs
local pairs = pairs

local mahjongName = require("mahjongName")
local table = require("extend_table")
local math = require("extend_math")
local sort = require("sort")

local helper = {}
local this = helper
function helper.getColor(v)
    return (v & 0x0f)>>4
end

function helper.getValue(v)
    return v & 0xf0
end

function helper.getCard(color,card)
    return (color<<4)|card
end

function helper.is_wan(v)
    return 0 == this.getColor(v)
end

function helper.is_tiao(v)
    return 1 == this.getColor(v)
end

function helper.is_tong(v)
    return 2 == this.getColor(v)
end

function helper.is_wtt(v)
    return v >= 0x01 and v <= 0x29
end

function helper.is_zi(v)
    return 3 == this.getColor(v)
end

function helper.is_hua(v)
    return 4 == this.getColor(v)
end

function helper.is_feng(v)
    return v >= 0x31 and v <= 0x34
end

function helper.is_zfb(v)
    return v >= 0x35 and v <= 0x37
end

function helper.getName(v)
    return mahjongName[v]
end

function helper.getString(arrMahjong)
    local t = table.fortab()
    for _,v in ipairs(arrMahjong) do
        table.insert(t,this.getName(v))
    end
    local s = table.concat(t)
    table.recycle(t)
    return s
end

--逻辑值排序
function helper.Sort(arrMahjong)
	table.sort(arrMahjong)
end

--扑克乱序
function helper.shuffle(arrMahjong)
	sort.shuffle(arrMahjong)
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
function helper.getHasCount(arrMahjong)
    local has = table.fortab()
    for _,_mj in ipairs(arrMahjong) do
        has[_mj] = (has[_mj] or 0) + 1
    end
    return has
end

--[[
    return {
        hasCard		= {扑克数量},
        hasColor    = {扑克花色}
    }
]]

--麻将分析
function helper.getAnalyze(arrMahjong)
    local an = this.newAnalyzeData()
    local hasCard = an.hasCard 
    local hasColor = an.hasColor 
    for k,v in pairs(arrMahjong) do
        local color = this.getColor(v)
        hasCard[v] = (hasCard[v] or 0) + 1
        hasColor[color] = (hasColor[color] or 0) + 1
    end
	return an
end



--胡牌检查
function helper.checkAbleHu(arrMahjong)
    
    --数量检查
    if 2 ~= len % 3 then
        return false
    end

    if this.checkQiDui(arrMahjong) then
        return true
    end

    local an = this.getAnalyze(arrMahjong)
    local hasCard = an.hasCard
    local hasColor = an.hasColor
    for k,count in pairs(arrMahjong) do
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
function helper.checkQiDui(arrMahjong)
    local len = #arrMahjong
    if 14 ~= len then
        return false
    end
    local has = helper.getHasCount(arrMahjong)
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
    sz1 = 1,--1个顺子的情况
    sz2 = 2,--2个顺子的情况
    sz3 = 3,--3个顺子的情况
    sz4 = 4,--4个顺子的情况
    kz1 = 5,--1个刻子的情况
    ks1 = 6,--1个刻子+1顺子
}

function helper.wttPing(hasWTT,hasColor)
    local group = table.fortab()
    for mj,count in pairs(hasWTT) do
        local unit = {}
        group[mj] = unit
        if 1 == count then
            table.insert(unit,groupType.sz1)
        elseif 2 == count then
            table.insert(unit,groupType.sz2)
        elseif 3 == count then
            table.insert(unit,groupType.kz1)
            table.insert(unit,groupType.sz3)
        elseif 4 == count then
            table.insert(unit,groupType.sz4)
            table.insert(unit,groupType.ks1)
        end
    end
end



return helper


--[[
   
]]