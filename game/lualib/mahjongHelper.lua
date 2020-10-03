--[[
    file:game\lualib\mahjongHelper.lua
    desc:麻将辅助 + 胡牌 + 听牌 算法
    auto:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local setmetatable = setmetatable
local skynet = require("skynet")
local mahjongName = require("mahjongName")
local groupMap = require("mahjongGroup")
local table = require("extend_table")
local math = require("extend_math")
local sort = require("extend_sort")
local tostring = require("extend_tostring")


---@class 麻将辅助对象
local helper = {
    support_qidui = true
}
local this = helper

---@field setSupportQiDui 设置七对标志
function helper.setSupportQiDui(suppor)
    this.support_qidui = suppor
end

---@field getColor 麻将花色
function helper.getColor(mj)
    return math.floor(mj/16)
end

---@field getValue 麻将值
function helper.getValue(mj)
    return mj % 16
end

---@field getCard 合成麻将
function helper.getCard(color,card)
    return color * 16 + card
end

---@field is_wan 万
function helper.is_wan(mj)
    return 0 == this.getColor(mj)
end

---@field is_tiao 条
function helper.is_tiao(mj)
    return 1 == this.getColor(mj)
end

---@field is_tong 筒
function helper.is_tong(mj)
    return 2 == this.getColor(mj)
end

---@field is_wtt 万条筒
function helper.is_wtt(mj)
    return mj >= 0x01 and mj <= 0x29
end

---@field is_zi 东南西北中发白
function helper.is_zi(mj)
    return 3 == this.getColor(mj)
end

---@field is_hua 春夏秋冬菊梅兰竹
function helper.is_hua(mj)
    return 4 == this.getColor(mj)
end

---@field is_feng 东南西北
function helper.is_feng(mj)
    return mj >= 0x31 and mj <= 0x34
end

---@field is_zfb 中发白
function helper.is_zfb(mj)
    return mj >= 0x35 and mj <= 0x37
end

---@field getChiLis 获取吃牌列表
function helper.getChiLis(mj)
    if not this.is_wtt(mj) then
        return table.fortab()
    end

    local lis = table.copy(groupMap[mj])
    --去除刻子
    local len = #lis
    lis[len] = nil
    return lis
end

---@field has_mt 转 arr_mt
function helper.hasToArr(mt)
    local arr = table.fortab()
    for mj,count in pairs(mt) do
        table.push_repeat(arr,mj,count)
    end
    table.sort(arr)
    return arr
end

---@field getName 单张麻将名字
function helper.getName(mj)
    return mahjongName[mj]
end

---@field getString 多张扑克名字
function helper.getString(mjCard)
    local t = table.fortab()
    for _,mj in ipairs(mjCard) do
        table.insert(t,this.getName(mj))
    end
    return table.concat(t)
end

---@field Sort 排序万条筒东南西北菊梅兰竹
function helper.Sort(mjCard)
	table.sort(mjCard)
end

---@field shuffle 扑克乱序
function helper.shuffle(mjCard)
	sort.shuffle(mjCard)
end


---@field getHasCount 统计麻将数量
function helper.getHasCount(mjCard)
    return table.has_count(mjCard)
end

---@field getHasCount_wtt 统计麻将数量万条筒
function helper.getHasCount_wtt(mjCard)
    local has = table.has_count(mjCard)
    for mj,count in pairs(has) do
        if not groupMap[mj] then
            has[mj] = nil
        end
    end
    return has
end

--[[
    @mjCard         手牌麻将
    @lz_mj     癞子麻将
    return {
        hasCard		= {扑克数量},
        hasColor    = {扑克花色}
        lz_num    = 癞子数量
    }
]]
---@param getAnalyze 麻将分析
function helper.getAnalyze(mjCard,lz_mj)

    local an = table.fortab()
    local hasCard = table.fortab()
    local hasColor = table.fortab()
    for _inx,_mj in pairs(mjCard) do

        local color = this.getColor(_mj)
        hasCard[_mj] = (hasCard[_mj] or 0) + 1
        hasColor[color] = (hasColor[color] or 0) + 1
    end

    an.hasCard = hasCard
    an.hasColor = hasColor
    an.lz_num = hasCard[lz_mj] or 0

    --清楚癞子
    if lz_mj then
        hasCard[lz_mj] = nil
        local lz_color = this.getColor(lz_mj)
        hasColor[lz_color] = hasColor[lz_color] - an.lz_num
    end 

	return an
end

---@field getHasType 统计万条筒可以组牌类型
function helper.getHasType(has_wtt)
    
    local has = table.fortab()
    for mj,count in pairs(has_wtt) do
        local ts = groupMap[mj]  --牌型列表
        local sc = #ts - 1     --0~sc 顺子牌型下标
        --刻子牌型
        if count >= 3 then
            local mt = ts[#ts]
            has[mt] = math.floor(count / 3)
        end

        --顺子牌型
        for i=1,sc do
            local mt = ts[i]
            local mc = count
            for _mj,_count in pairs(mt) do
                local cc = has_wtt[_mj] or 0
                mc = math.min(mc,cc)
            end

            has[mt] = mc
        end
    end
    return has
end


---@field checkSun 检查顺子数量
function helper.checkSun(hasType,mj,count)
    local ts = groupMap[mj]
    local sc = #ts - 1
    local sz_count = 0
    for i=1,sc do
        sz_count = sz_count + (hasType[ts[i]] or 0)
    end

    return sz_count >= count
end



---@field checkKe 检查刻子数量
function helper.checkKe(hasType,mj,count)
    local ts = groupMap[mj]
    local ki = #ts
    local kt = ts[ki]
    local kz_count = hasType[kt]
    return kz_count >= count
end

---@field checkSunKe    检查顺子和刻子数量
---@param hasType       类型统计
---@param mj            参与麻将
---@param sc            顺子数量
---@param kc            刻子数量
function helper.checkSunKe(hasType,mj,sc,kc)
    return this.checkSun(hasType,mj,sc) and this.checkKe(hasType,mj,kc)
end


---@field checkAbleHu  胡牌检查
---@param mjCard       手牌麻将
function helper.checkAbleHu(mjCard)

    --数量检查
    local len = #mjCard
    if 2 ~= len % 3 then
        return false
    end

    if this.support_qidui then
        if this.checkQiDui(mjCard) then
            return true
        end
    end

    local an = this.getAnalyze(mjCard)
    local hasCard = an.hasCard
    local hasColor = an.hasColor
    for _mj,count in pairs(hasCard) do
        if count >= 2 then
            local c = this.getColor(_mj)
            hasCard[_mj] = hasCard[_mj] - 2
            hasColor[c] = hasColor[c] - 2
            if this.checkPing(hasCard,hasColor,an.lz_num) then
                return true
            end
            hasCard[_mj] = hasCard[_mj] + 2
            hasColor[c] = hasColor[c] + 2
        end
    end
    return false
end

--七对检查
function helper.checkQiDui(mjCard,lz_mj)
    local len = #mjCard
    if 14 ~= len then
        return false
    end
    local an = this.getAnalyze(mjCard,lz_mj)
    local has = helper.getHasCount(mjCard)
    local lz_num = an.lz_num
    for _,count in pairs(an.hasCard) do
        if 0 ~= count % 2 then
            return false
        end
    end

    return true
end

--平胡检查
function helper.checkPing(hasMahjong,hasColor,lz_num)
	--每个花色数量
    for c,count in pairs(hasColor) do
        if 0 ~= count % 3 then
            return false
        end
    end
  
    return this.helpPing(hasMahjong,lz_num)
end

--平胡检查
function helper.helpPing(hasMahjong,lz_num)

    local has_wtt = table.fortab()
    local hasColor = table.fortab()
    for v,count in pairs(hasMahjong) do
        --万条筒
        if this.is_wtt(v) then
            has_wtt[v] = count
            local c = this.getColor(v)
            hasColor[c] = (hasColor[c] or 0) + count
        --字牌
        else
            if 0 ~= count % 3 then
                return false
            end
        end
    end

    return this.wttPing(has_wtt,hasColor,lz_num)
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

--统计表和
function table.sum_has_k(t)
	local sum = 0
	for k,_ in pairs(t) do
		sum = sum + k
	end
	return sum
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
    @param has_wtt = {--mj:只包含万条筒
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
function helper.wttPing(has_wtt,hasColor,lz_num)

    local has_mt = helper.getHasType(has_wtt)
    local mjCount = table.sum_has(has_wtt)
    local mtCount = table.sum_has(has_mt)

    if mtCount < math.floor(mjCount/3) then
        return false
    end

    local group = table.fortab()
    for mj,count in pairs(has_wtt) do
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
            if this.checkSun(has_mt,mj,count) then
                table.insert(unit,groupType.sz3)--3个顺子
            end
            table.insert(unit,groupType.kz1)--1个刻子
        elseif 4 == count then
            local ok = false
            if this.checkSun(has_mt,mj,count) then
                table.insert(unit,groupType.sz4)--4个顺子
                ok = true
            end
            if this.checkSunKe(has_mt,mj,1,1) then
                table.insert(unit,groupType.ks1)--1刻子+1顺子
                ok = true
            end
            if not ok then
                return false
            end
        end
    end

    --统计允许牌型
    local may_mt = table.fortab()
    for _mj,_lis in pairs(group) do
        local ts = groupMap[_mj]
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
            table.push_repeat(arr_mt,_mt,_count)
        else
            has_mt[_mt] = nil
        end
    end

    --排序 先取刻子 然后取顺子
    table.sort(arr_mt,helper.mt_compare)

    return this.dg_group_hu(has_wtt,arr_mt,has_mt,0)
end


---@field mt_compare 牌型比较
---@param a wan111
---@param b wan111
function helper.mt_compare(a,b)
    local av = get_sk_logic(a)
    local bv = get_sk_logic(b)
    return av > bv
end




local dg_count = 0
---@param has_wtt 万条筒统计
---@param arr_mt  牌型数组
---@param has_mt  牌型统计
---@param deep    递归深度
local function dg_group_hu(has_wtt,arr_mt,has_mt,deep)
    dg_count = dg_count + 1

    --扑克刚好取完
    local mj_count = table.sum_has(has_wtt)
    if 0 == mj_count then
        return true
    end

    --无法组合牌型
    local mt_count = table.sum_has(has_mt)
    if 0 == mt_count then
        return false
    end
    
    local has_rmt = table.fortab()
    for _inx,_mt in ipairs(arr_mt) do
        --类型过滤
        if has_mt[_mt] - (has_rmt[_mt] or 0) > 0 then
			
			--记录取牌
			for _mj,_count in pairs(_mt) do
				has_wtt[_mj] = has_wtt[_mj] - _count
			end
			
			--取出类型
			has_rmt[_mt]  = (has_rmt[_mt] or 0) + 1
	
			--取出扑克-影响其他顺子牌型无法构成
			for _mj,_count in pairs(_mt) do
				for _,_mt in pairs(groupMap[_mj]) do
					--顺子
					if is_shun(_mt) and has_mt[_mt] then
						local left_mj = has_wtt[_mj]
						local left_mt = has_mt[_mt] - (has_rmt[_mt] or 0)
						if left_mt > left_mj then
							has_rmt[_mt] = (has_rmt[_mt] or 0) + 1
						end
					--刻子也要减
					elseif is_ke(_mt) and has_mt[_mt]  then
						local left_mj = has_wtt[_mj]
						local left_mt = has_mt[_mt] - (has_rmt[_mt] or 0)
						if left_mt > math.floor(left_mj / 3) then
							has_rmt[_mt] = (has_rmt[_mt] or 0) + 1
						end
					end
				end
			end
	
			--移除数据
			table.ventgas(has_mt,has_rmt)
			if dg_group_hu(has_wtt,arr_mt,has_mt,deep+1) then
				return true
			end
			--恢复数据
			table.absorb(has_mt,has_rmt)
			table.clear(has_rmt)
	
			--还原取牌
			for _mj,_count in pairs(_mt) do
				has_wtt[_mj] = has_wtt[_mj] + _count
			end

        end
    end

    return false
end

--[[
    bug 1 可胡
    {0x18,0x18,0x27,0x27,0x27,0x34,0x35,0x36,0x36,0x36,0x37,0x37,0x38,0x38}
    bug 2 不能胡
    {0x14,0x14,0x14,0x27,0x28,0x28,0x28,0x29,0x41,0x41,0x26}
]]

---@field dg_group_hu 万条筒组牌递归
helper.dg_group_hu = dg_group_hu

--[[听牌提示
    @param arrMahjong = {           --玩家手牌
        [1~n] = mj
    }
    
    @param hasMahjong = {           --听牌映射
        [mj] = count
    }

    @param lz_mahjong 癞子麻将

    @return ting = {--mj:麻将
        [mj] = {--inx:1~n
            [inx] = mj
        }
    }
]]

local for_able_count = 0
---@field getTingInfo 获取听牌提示
---@param hand 手牌数据
---@param hasfull 包含麻将
---@return MJTing
function helper.getTingInfo(hand,hasfull)
    local ting = table.fortab()
    local handCopy = table.copy(hand)
    local an = this.getAnalyze(handCopy,this.lz_mj)

    local hasMahjongSelf = this.getHasCount(handCopy)
    for _out_mj,_count in pairs(hasMahjongSelf) do

        table.find_remove(handCopy,_out_mj)

        for _ting_mj,_count in pairs(hasfull) do
            --自己没有的不检查
            if an.hasColor[this.getColor(_ting_mj)] then
                table.insert(handCopy,_ting_mj)
                for_able_count = for_able_count + 1
                if this.checkAbleHu(handCopy,this.lz_mj) then
                    ting[_out_mj] = ting[_out_mj] or table.fortab()
                    ting[_out_mj][_ting_mj] = true
                end
                table.remove(handCopy,#handCopy)
            end
        end
        table.insert(handCopy,_out_mj)
    end
    return ting
end

function helper.start_dg_count()
    for_able_count = 0
    dg_count = 0
end

function helper.Look_dg_count()
    if 0 == for_able_count then
        for_able_count = 1
    end
    skynet.error("递归次数：",dg_count,"听检查次数：",for_able_count,"平均递归次数",dg_count//for_able_count)
end

return helper


--[[
   {
       this.lz_mj = 癞子麻将值 nil 表示没有癞子
       this.support_qidui = true 默认支持七对
   }
]]