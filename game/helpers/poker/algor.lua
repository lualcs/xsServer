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
end

---分析
---@param hand pkCard[]         @手牌
---@param repe boolean|nil      @true:重复 false:唯一
---@return pkMethod
function algor:getMethod(hands,repe)
    local as = {nil}
    local bs = {nil}
    local cs = {nil}
    local ds = {nil}
    local pkMethod = {
        singles = as,
        doubles = bs,
        triples = cs,
        tetrads = ds,
    }
    local maps = table.arrToHas(hands)
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
    return pkMethod
end

return algor