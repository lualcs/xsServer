--[[
    desc:扑克算法
    auth:Caorl Luo
]]

local pairs = pairs
local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local gameAlgor = require("game.algor")
---@class pokerAlgor:gameAlgor
local algor = class(gameAlgor)

---构造 
function algor:ctor()
    ---癞子表-默认空表
    ---@type table<mjCard,boolean>      
    self._support_laizis         = {nil}
end


---清空癞子
function algor:clrSupportLaizis()
    local maps = self._support_laizis
    table.clear(maps)
end

---添加癞子
---@param mj mjCard  @癞子牌
function algor:addSupportLaizis(mj)
    local maps = self._support_laizis
    maps[mj] = true
end

---删除癞子
---@param mj mjCard  @癞子牌
function algor:delSupportLaizis(mj)
    local maps = self._support_laizis
    maps[mj] = nil
end

---获取癞子
---@return table<mjCard,boolean>
function algor:getSupportLaizis()
    return self._support_laizis
end

---获取癞子
---@return mjCard
function algor:getSupportLaizi()
    return self._support_dinglz
end

---是癞子
---@param mj    mjCard      @麻将
---@return      boolean
function algor:ifRuffian(mj)
    local map = self._support_laizis
    if map[mj] then
        return true
    end
    return false
end

local cype1 = {nil}
local cype2 = {nil}
local cype3 = {nil}
local cype4 = {nil}
local cype5 = {nil}
local cype6 = {nil}
local cype7 = {nil}

---分析
---@param hand pkCard[]         @手牌
---@param repe boolean|nil      @true:重复 false:唯一
---@return pokerLayout
function algor:getLayout(hands,repe)
    local as = cype1
    local bs = cype2
    local cs = cype3
    local ds = cype4
    local es = cype5
    local fs = cype6
    local gs = cype7

    ---分析数据
    ---@type pokerLayout
    local pokerLayout = {
        singles = as,
        doubles = bs,
        triples = cs,
        tetrads = ds,
        laizis  = es,
        pokers  = fs,
        repeas  = gs,
    }
    ---扑克辅助
    ---@type pokerHelper
    local help = self._hlp
    local maps = table.clear(gs)
    for _,card in ipairs(hands) do

        if help.ifGeneralCard(card) then
            local val = help.getValue(card)
            local cnt = maps[val] or 0
            maps[val] = cnt + 1
        end

        if self.ifRuffian(card) then
            table.insert(es,card)
        else
            table.insert(fs,card)
        end
    end

    for v,c in ipairs(maps) do
        local ist = false
        if c >= 4 then
            if not ist or repe then
                table.insert(ds,v)
            end
            ist = true
        end
        if c >= 3 then
            if not ist or repe then
                table.insert(cs,v)
            end
            ist = true
        end
        if c >= 2 then
            if not ist or repe then
                table.insert(bs,v)
            end
            ist = true
        end
        if c >= 1 then
            if not ist or repe then
                table.insert(as,v)
            end
            ist = true
        end
    end
    table.sort(as)
    table.sort(bs)
    table.sort(cs)
    table.sort(ds)
    table.sort(es)
    table.sort(fs)
    return pokerLayout
end

return algor