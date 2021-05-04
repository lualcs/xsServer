--[[
    desc:桌子
    auth:Caorl Luo
]]
local class = require("class")
local ranking  = require("ranking")
local gameTable = require("gameTable")
---@class hundredTable:gameTable
local hundredTable = class(gameTable)
local this = hundredTable

---构造 
function hundredTable:ctor()
    ---神算子排行榜
    ---@type ranking
    self._ssz_rank = ranking.new(10)
    ---大富豪排行榜
    ---@type ranking
    self._dfh_rank = ranking.new(10)
    ---庄家列表数据
    ---@type seatID[]
    self._arrBanker = {nil}
    ---请求上庄列表
    ---@type seatID[]
    self._arrUpBanker = {nil}
end

---最少庄家
---@return count
function hundredTable:minBanker()
    local cfg = self:getGameConf()
    return cfg.minBanker
end

---最多庄家
---@return count
function hundredTable:maxBanker()
    local cfg = self:getGameConf()
    return cfg.maxBanker
end


return hundredTable