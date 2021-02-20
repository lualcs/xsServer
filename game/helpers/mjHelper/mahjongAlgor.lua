--[[
    file:mahjongAlgor.lua 
    desc:胡牌算法
    auth:Carol Luo
]]

local math = math
local next = next
local pairs = pairs
local ipairs = ipairs
local class = require("class")
local sort = require("sort")
local table = require("extend_table")
local gameAlgor = require("gameAlgor")
local mapHuCards = require("mahjong.mapHuCards")
---@class mahjongAlogor:gameAlgor @麻将算法
local mahjongAlogor = class(gameAlgor)
local this = mahjongAlogor

---构造函数
function mahjongAlogor:ctor()
    ---七对-默认支持
    ---@type boolean                    
    self.support_7pairs         = true
    ---四混-默认关闭
    ---@type boolean                    
    self.support_4laizi         = false
    ---七对癞子参与-默认关闭
    ---@type boolean                    
    self.support_7laizi         = false
    ---癞子牌-默认关闭
    ---@type mjCard|nil                 
    self.support_dinglz         = nil
    ---癞子表-默认空表
    ---@type table<mjCard,boolean>      
    ---固定将对-默认空表
    self.support_laizis         = {nil}
    ---@type table<mjCard,boolean>      
    self.support_jiangs         = {nil}
    ---顺子分组-默认空表
    ---@type table<mjCard,mjUnit>       
    self.support_classs         = {nil}
    ---@type table<index,mjUnit>       
    self.support_mclass         = {nil}
    ---调用信息-默认空表
    ---@type mjUsag
    self.current_usages         =  {nil}
end

---七对开关
---@param sport boolean @true:开启 false:关闭
function mahjongAlogor:setSupport7pairs(sport)
    self.support_7pairs = sport
end

---四混开关
---@param sport boolean @true:开启 false:关闭
function mahjongAlogor:setSupport4laizi(sport)
    self.support_4laizi = sport
end

---七癞开关
---@param sport boolean @true:开启 false:关闭
function mahjongAlogor:setSupport7laizi(sport)
    self.support_7laizi = sport
end

---清空癞子
function mahjongAlogor:clrSupportLaizis()
    local maps = self.support_laizis
    table.clear(maps)
end

---添加癞子
---@param mj mjCard  @癞子牌
function mahjongAlogor:addSupportLaizis(mj)
    local maps = self.support_laizis
    maps[mj] = true
end

---删除癞子
---@param mj mjCard  @癞子牌
function mahjongAlogor:delSupportLaizis(mj)
    local maps = self.support_laizis
    maps[mj] = nil
end

---获取癞子
---@return table<mjCard,boolean>
function mahjongAlogor:getSupportLaizis()
    return self.support_laizis
end

---获取癞子
---@return mjCard
function mahjongAlogor:getSupportLaizi()
    return self.support_dinglz
end


---清空将对
function mahjongAlogor:clrSupportJiangs()
    local maps = self.support_jiangs
    table.clear(maps)
end

---添加将对
---@param mj mjCard  @癞子牌
function mahjongAlogor:addSupportJiangs(mj)
    local maps = self.support_jiangs
    self.support_dinglz = mj
    maps[mj] = true
end

---删除将对
---@param mj mjCard  @癞子牌
function mahjongAlogor:delSupportJiangs(mj)
    local maps = self.support_jiangs
    self.support_dinglz = next(maps)
    maps[mj] = nil
end

---顺子分类
---@param ts mjUnit[]
function mahjongAlogor:setSupportClasss(ts)
    ---@type mahjongHelper  @麻将辅助
    local hlp = self._hlp
    local maps = self.support_classs
    local mmas = self.support_mclass
    for idx,unit in ipairs(ts) do
        for value = unit.start,unit.close do
            local mj = hlp.getCard(unit.color,value)
            unit.class = idx
            maps[mj] = unit
            mmas[idx] = unit
        end
    end
end

---麻将
---@param  mj   mjCard      @麻将
---@return index
function mahjongAlogor:getSupportClassID(mj)
    local maps = self.support_classs
    return maps[mj].class
end

---麻将
---@param  mj   mjCard      @麻将
---@return index
function mahjongAlogor:getSupportClassInfo(mj)
    local maps = self.support_classs
    return maps[mj]
end

---可以成顺
---@param jid   index      @麻将
---@return      boolean
function mahjongAlogor:isJoint(jid)
    local map = self.support_mclass
    return map[jid].joint
end


---是癞子
---@param mj    mjCard      @麻将
---@return      boolean
function mahjongAlogor:isLaizi(mj)
    local map = self.support_laizis
    if map[mj] then
        return true
    end
    return false
end

---使用者
---@param player mahjongPlayer  @玩家
function mahjongAlogor:setUsages(player,mjFull)
    local info = self.current_usages
    info.player = player
    info.mjFull = mjFull or self._lgc:getFMahjongMaps()
end

---使用者
---@return mjUsag
function mahjongAlogor:getUsages()
    local info = self.current_usages
    return info
end

---统一手牌
---@param hands   mjHands       @手牌
---@param ot      table|nil     @外带
---@return mjUnify      @手牌,癞子
function mahjongAlogor:getUnifyHands(hands)
    ---@type mjHands        @手牌
    local mjhands = {nil}
    ---@type mjMapkc        @映射
    local mjMpasw = {nil}
    ---@type mjMapkc        @映射
    local mjMpacw = {nil}
    ---@type mahjongHelper  @麻将辅助
    local mjhelp = self._hlp
    ---@type mjClass
    local mjClass = {
        [1] = {nil},--万
        [2] = {nil},--条
        [3] = {nil},--筒
        [4] = {nil},--箭
        [5] = {nil},--风
        [6] = {nil},--花
    }
    local mjGapls = {
        [1] = {min=9,max=0,num=0},--万
        [2] = {min=9,max=0,num=0},--条
        [3] = {min=9,max=0,num=0},--筒
        [4] = {min=9,max=0,num=0},--箭
        [5] = {min=9,max=0,num=0},--风
        [6] = {min=9,max=0,num=0},--花
    }
    ---@type table<mjCard,mjCount>  @映射
    local sanjosr = {nil}
    ---@type mjUnify 
    local ufy = {
        lzcount = 0,
        spcount = #hands,
        mjhands = mjhands,
        mjMpasw = mjMpasw,
        mjMpacw = mjMpacw,
        mjClass = mjClass,
        sanjosr = sanjosr,
        mjGapls = mjGapls,
    }
    for _,mj in ipairs(hands) do
        local cl = mjhelp.getColor(mj)
        local cn = mjMpacw[cl] or 0
        mjMpacw[cl] = cn + 1
        if not self:isLaizi(mj) then
            table.insert(mjhands,mj)
        else
            ufy.lzcount = ufy.lzcount + 1
        end
        --顺子分类
        local ji = self:getSupportClassID(mj)
        ---记录数据
        local ve = mjhelp.getValue(mj)
        local cv = mjClass[ji][ve] or 0
        mjClass[ji][ve] = cv + 1
        ---记录大小
        local vue = math.min(ve,mjGapls[ji].min)
        mjGapls[ji].min = vue
        vue = math.max(ve,mjGapls[ji].max)
        mjGapls[ji].max = vue
        vue = mjGapls[ji].num
        mjGapls[ji].num = vue + 1
    end
    mjMpasw = table.arrToHas(mjhands,mjMpasw)
    table.sort(mjhands)
    return ufy
end

---数据变更
---@param ufy mjUnify @统一数据
---@param add mjCount @增加数量
---@param cmj mjCard  @增加数量
---@param kfd string  @记录键值
function mahjongAlogor:clamp_unity(ufy,add,cmj,kfd)
    --如果是癞子
    if self:isLaizi(cmj) then
        ufy.lzcount = ufy.lzcount + add
        return
    end
    ---@type mahjongHelper
    local mjHlp = self._hlp
    ---手牌
    ufy.spcount = ufy.spcount + add
    ---花色
    local clor = mjHlp.getColor(cmj)
    local ccnt = ufy.mjMpacw[clor] or 0
    ufy.mjMpacw[clor] = ccnt + add
    ---牌表
    local jcnt = ufy.mjMpasw[cmj] or 0
    ufy.mjMpasw[cmj] = jcnt + add
    ---顺牌
    local ji = self:getSupportClassID(cmj)
    local jv = self._hlp.getValue(cmj)
    ---记录大小
    local vue = math.max(ufy.mjGapls[ji].max,jv)
    ufy.mjGapls[ji].max = vue
    vue = math.min(ufy.mjGapls[ji].min,jv)
    ufy.mjGapls[ji].min = vue
    vue = ufy.mjGapls[ji].num
    ufy.mjGapls[ji].num = vue + add

    --设置拿牌
    if 1 == add then
        ufy[kfd] = cmj
    elseif -1 == add then
        ufy[kfd] = nil
    end
end

---听哪些
---@param   hands mjHands        @手牌
---@return  table<mjCard,mjPeg>  @提示
function mahjongAlogor:getWhoTings(hands)
    ---@type mjTings        @胡牌映射
    local rtings = {nil}
    ---@type mjUsag         @使用信息
    local mjUsag = self:getUsages()
    ---@type mjUnify        @统一手牌
    local ufy = self:getUnifyHands(hands)
    local mjMpacw = ufy.mjMpacw
    ---@type mjCount        @癞子数量
    local lzcount = ufy.lzcount
    ---@type mahjongHelper  @麻将辅助
    local mjhelp = self._hlp
    ---@type mahjongType  @麻将类型
    local mjPeg  = self._tye
    ---遍历牌库
    for deal,_ in pairs(mjUsag.mjFull) do
        local ok = true
        local clor = mjhelp.getColor(deal)
        ---没有癞子
        if lzcount <= 0 then
            --不是癞子
            if not self:isLaizi(deal) then
                local ccnt = mjMpacw[clor] or 0
                local mnum = (ccnt+1)%3
                if 2 ~= mnum and 0 ~= mnum then
                    --要么取将-要么成扑
                    ok = false
                end
            end
        end

        if ok then
            ---数据变更
            self:clamp_unity(ufy,1,deal,"getCard")
            --检查胡牌
            if self:isHuCards(ufy) then
                rtings[deal] = mjPeg:getPegItem(ufy)
            end
            ---数据变更
            self:clamp_unity(ufy,-1,deal,"getCard")
        end
    end

    local lz = self:getSupportLaizi()
    ---添加癞子
    if not table.empty(rtings) then
        local lzs = self:getSupportLaizis()
        for lzmj,_ in pairs(lzs) do
            if not rtings[lzs] then
                ufy.getCard = lzmj
                rtings[lzmj] = mjPeg:getPegItem(ufy)
                ufy.getCard = nil
            end
        end
    end

    return rtings
end

---选那些
---@param   hands mjHands        @手牌
---@return  mjXuaks              @提示
function mahjongAlogor:getWhoXuans(hands)
    ---@type mjXuaks        @选牌映射
    local rXuaks = {nil}
    ---@type mjUsag         @使用信息
    local mjUsag = self:getUsages()
    ---@type mjUnify        @统一手牌
    local ufy = self:getUnifyHands(hands)
    local mjMpasw = ufy.mjMpasw
    ---@type mjCount        @癞子数量
    local lzcount = ufy.lzcount
    ---@type mahjongHelper  @麻将辅助
    local mjhelp = self._hlp
    ---@type mahjongType  @麻将类型
    local mjPeg  = self._tye
    ---遍历牌库
    for cast,_ in pairs(mjMpasw) do
        ---数据变更
        self:clamp_unity(ufy,-1,cast,"casCard")
        for deal,_ in pairs(mjUsag.mjFull) do
            self:clamp_unity(ufy,1,cast,"getCard")
            if self:isHuCards(ufy) then
                ---@type mjTings    @胡牌信息
                local tings = rXuaks[cast] or {nil}
                rXuaks[cast] = tings
                tings[deal]  = mjPeg:getPegItem(ufy)
            end
            self:clamp_unity(ufy,-1,cast,"getCard")
        end
        self:clamp_unity(ufy,1,cast,"casCard")
    end
    ---添加癞子
    local lzs = self:getSupportLaizis()
    for _,tings in pairs(rXuaks) do
        if not table.empty(tings) then
            for lzmj,_ in pairs(lzs) do
                if not tings[lzs] then
                    ufy.getCard = lzmj
                    tings[lzmj] = mjPeg:getPegItem(ufy)
                    ufy.getCard = nil
                end
            end
        end
    end
    return rXuaks
end


local count = 0
---胡检查次数
function mahjongAlogor.getHuCardCount()
    return count
end
---胡检查次数
function mahjongAlogor.setHuCardCount(c)
    count = c
end
---胡牌判断
---@param ufy   mjUnify @信息
function mahjongAlogor:isHuCards(ufy)
    if count <= 0 then
        return false
    end
    count = count - 1
    --数量检查
    if 2 ~= ufy.spcount % 3 then
        return false
    end

    --支持四混
    if self.support_4laizi then
        if ufy.lzcount >= 4 then
            return true
        end
    end

    --支持七对
    if self.support_7pairs then
        if self:isHu7Pairs(ufy) then
            return true
        end
    end
    
    if ufy.lzcount <= 0 then
        --无癞子
        return self:nolaiziJiangHuCard(ufy)
    else
        --有癞子
        return self:oklaiziJiangHuCard(ufy)
    end
end

---胡牌判断
---@param ufy   mjUnify @信息
function mahjongAlogor:isHu7Pairs(ufy)
    --数量检查
    if 14 ~= ufy.spcount then
        return false
    end
    
    if self.support_7laizi then
        --癞子允许参与
        local lzcnt = ufy.lzcount
        for mj,ct in ipairs(ufy.mjMpasr) do
            if 0 ~= ct % 2 then
                lzcnt = lzcnt - 1
                if lzcnt < 0 then
                    return false
                end
            end
        end
    else
        --癞子不能参与
        for mj,ct in pairs(ufy.mjMpasr) do
            if 0 ~= ct % 2 then
                return false
            end
        end
    end

    return true
end

local copy1 = {}
---生成麻将映射值
---@param mjs table<mjValue,count>          @手牌
---@param min mjValue                       @最小
---@param max mjValue                       @最大
---@return number
local function isChannel(mjs,min,max)
    local lis = table.hasToArr(mjs,copy1)
    table.sort(lis)
    local min = lis[1]
    local max = lis[#lis]
    local len = max - min
    local int = 0
    for v=min,max do
        local c = mjs[v] or 0
        if c > 0 then
            local i = v-min+1
            int = int + (10^(len-i+1))*c
        end
    end
    return mapHuCards[int]
end

---无癞子有将对胡牌
---@param ufy   mjUnify @信息
---@return boolean
function mahjongAlogor:nolaiziJiangHuCard(ufy)
    local n2 = 0
    for ji,jvs in ipairs(ufy.mjClass) do
        if not table.empty(jvs) then
            --数量检查-是否符合 3*n + 2
            local gap = ufy.mjGapls[ji]
            local m = gap.num % 3
            if 1 == m then
                return false
            elseif 2 == m then
                n2 = n2 + 1
            end
            --只能有一个将对
            if n2 > 1 then
                return false
            end
            --成朴检查
            if self:isJoint(ji) then
                --可以成顺
                if not isChannel(jvs,gap.min,gap.max) then
                    return false
                end
            else
                --不能成顺
                for jv,jc in pairs(jvs) do
                    local md = jc % 3
                    if 2 ~= md and 0 ~= md then
                        return false
                    end
                end
            end
        end
    end
    --检查刻子
    return true
end


---癞子有将对胡牌
---@param ufy   mjUnify @信息
---@return boolean
function mahjongAlogor:oklaiziJiangHuCard(ufy)
    return true
end

return mahjongAlogor


--[[
    1:将牌
]]