--[[
    file:mahjongType.lua 
    desc:类型 
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local class = require("class")
local gameType = require("game.type")
---@class mahjongType:gameType 
local type = class(gameType)


---构造
function type:ctor()
end

---平胡
---@param mjUnify mjUnify @数据
---@return boolean
function type:isPingHu(mjUnify)
    return true
end

---七对
---@param mjUnify mjUnify @数据
---@return boolean
function type:isQiDui(mjUnify)
    ---手牌数量
    if 14 ~= mjUnify.spcount then
        return false
    end
    ---麻将算法
    ---@type mahjongAlogor
    local algor = self._gor
    local laizi = mjUnify.lzcount
    local support = algor._support_7laizi
    for _,count in pairs(mjUnify.mjMpasw) do
        --成对
        local md = count % 2
        if 0 ~= md then
            --赖子七对
            if support then
                laizi = laizi - md
                if laizi < 0 then
                    return false
                end
            else
                return false
            end
        end
    end
    return true
end


---类型
---@param mjUnify mjUnify @数据
---@return mjPeg
function type:getPegItem(mjUnify)
    return true
end

return type