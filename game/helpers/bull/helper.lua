--[[
    file:bullHelper.lua 
    desc:只做最简单的功能
    auth:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local class = require("class")
local table = require("extend_table")
local math = require("extend_math")
local pokerHelper = require("poker.helper")

---@class bullHelper:pokerHelper @扑克辅助
local helper = class(pokerHelper)
local this = helper

---构造函数
function helper:ctor()
end

---比较牌值
---@param card cardPoker @花色
---@return number
function pokerHelper.getLogicValue(card)
    return this.getValue(card)
end

---单牌点数
---@param card pkCard @扑克 
---@return bullNumber
function helper.getValueForCount(card)
    local value = this.getValue(card)
    return math.min(value,10)
end

local copy1 = {nil}
---过滤扑克
---@param   hands pkCard[] @扑克列表
---@param   donts pkCard[] @排除列表
function helper.getFilters(hands,donts,out)
    local cards = table.clear(out or copy1)
    for _,card in ipairs(hands) do
        if table.exist(donts,card) then
            table.insert(cards,card)
        end
    end
    return cards
end


---斗牛判断
---@param   hands pkCard[] @扑克列表
function helper:ifFightBull(hands)

    ---牛牛算法
    ---@type bullAlgor
    local algor = self._gor
    local count = 0
    for _,card in ipairs(hands) do
        if not algor:ifLaizi(card) then
            return true
        else
            count = count + this.getValueForCount(card) 
        end
    end
    return 0 == count % 10
end

return helper