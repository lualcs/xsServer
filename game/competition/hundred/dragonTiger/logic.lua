--[[
    desc:龙虎
    auth:Carol Luo
]]

local math = math
local table = table
local pairs = pairs
local ipairs = ipairs
local setmetatable = setmetatable
local random = require("random")
local class = require("class")
local ifNumber = require("ifNumber")
local hundredLogic = require("hundred.logic")
local senum = require("dragonTiger.enum")
---@class dragonTigerLogic:hundredLogic
local logic = class(hundredLogic)
local this = logic

---构造 
function logic:ctor()
    
end

---重置数据
function logic:dataReboot()
    self:super(this,"dataReboot")
    local cfg = self._competition:getGameConf()
    local poker = cfg.pokers
    self._pokers = setmetatable({nil},
    {
        __index = function(t,index)
            return poker[index]
        end
    })
    self._count = #poker
end

---清除数据
function logic:dataClear()
    self:super(this,"dataClear")
    table.clear(self._pokers)
    ---龙牌
    ---@type pkCard
    self._dragonCard = nil
    ---虎牌
    ---@type pkCard
    self._tigerCard = nil
    ---结果
    ---@type senum
    self._winner = nil
end

---发牌
function logic:dealCards()
    self:dealDragonCard()
    self:dealTigerCard()
    self:dealCompare()
end

---发牌龙牌
function logic:dealDragonCard()
    local poker = self._pokers
    local index = math.random(1,self._count)
    self._dragonCard = poker[index]
    poker[1],poker[index] = poker[index],poker[1]
end

---发牌龙牌
function logic:dealTigerCard()
    local poker = self._pokers
    local index = math.random(2,self._count)
    self._tigerCard = poker[index]
    poker[2],poker[index] = poker[index],poker[2]
end

---发牌结果
function logic:dealCompare()
    ---龙虎算法
    ---@type dragonTigerAlgor
    local algor = self._gor
    self._winner = algor:compare(self._dragonCard,self._tigerCard)
end


---龙区发牌
---@return pkCard
function logic:getDragonCard()
    return self._dragonCard
end

---龙区发牌
---@return pkCard
function logic:getTigerCard()
    return self._tigerCard
end

---龙区发牌
---@return pkCard
function logic:getWinner()
    return self._winner
end


return logic