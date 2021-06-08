--[[
    desc:策略
    auth:Carol Luo
]]

local math = math
local pairs = pairs
local class = require("class") 
local gameSystem = require("gameSystem")
---@class hundredSystem:gameSystem
local hundredSystem = class(gameSystem)
local this = hundredSystem

---构造 
function hundredSystem:ctor()
end

---重启
function hundredSystem:dataReboot()
    self:super(this,"dataReboot")
    ---随机上庄
    self._tim:appendEver(5*1000,function()
        self:autoUpBanker()
    end)
end


---自动上庄
function hundredSystem:autoUpBanker(robot)
    ---比赛
    ---@type hundredTable
    local competition = self._table

    ---遍历
    if not robot then
        local mapPlayer = competition._mapPlayer
        for _,player in pairs(mapPlayer) do
            if player:ifRobot() then
                self:autoUpBanker(player)
            end
        end
    end

    local bankerCnt = competition:numBanker()
    local upBankerCnt = competition:numUpBanker()
    local maxBankerCnt = competition:maxBanker()
    
    if bankerCnt + upBankerCnt > math.min(1,maxBankerCnt / 2) then
        return
    end

    competition:applyForUpBanker(robot)
end


return hundredSystem