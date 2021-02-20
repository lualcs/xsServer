--[[
    file:mahjongType.lua 
    desc:类型 
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local class = require("class")
local gameType = require("gameType")
---@class mahjongType:gameType 
local mahjongType = class(gameType)


---构造
function mahjongType:ctor()
end

---平胡
---@param mjUnify mjUnify @数据
---@return boolean
function mahjongType:isPingHu(mjUnify)
    return true
end

---七对
---@param mjUnify mjUnify @数据
---@return boolean
function mahjongType:isQiDui(mjUnify)
    ---手牌数量
    if 14 ~= mjUnify.spcount then
        return false
    end
    ---麻将算法
    ---@type mahjongAlogor
    local algor = self._gor
    local laizi = mjUnify.lzcount
    for _,count in pairs(mjUnify.mjMpasw) do
        --成对
        if 0 ~= count then
            --赖子
            if algor.support_7laizi then
                
            end
        end
    end
    return true
end


---类型
---@param mjUnify mjUnify @数据
---@return mjPeg
function mahjongType:getPegItem(mjUnify)
    return true
end

return mahjongType