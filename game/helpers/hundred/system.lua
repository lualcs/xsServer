--[[
    desc:策略
    auth:Carol Luo
]]

local math = math
local pairs = pairs
local class = require("class") 
local gameSystem = require("game.system")
---@class hundredSystem:gameSystem
local system = class(gameSystem)
local this = system

---构造 
function system:ctor()
end

---重启
function system:dataReboot()
    self:super(this,"dataReboot")
    ---随机上庄
    self._tim:appendEver(5*1000,function()
        self:autoUpBanker()
    end)
end


---自动上庄
---@param player hundredPlayer
function system:autoUpBanker(player)
    ---百人游戏
    ---@type hundredTable
    local game = self._competition

    ---上庄数量
    local maxBankerCount = game:maxBanker()
    local bankerCount = game:numBanker()
    local waitCount = game:numWaitBanker()
    local wantCount = math.min(1,game:maxBanker() // 2)
    if wantCount < (bankerCount + waitCount) then
        return
    end

    if not player then
        ---遍历
        local mapPlayer = game._mapPlayer
        for _,_player in pairs(mapPlayer) do
            if _player:ifRobot() then
            if not _player:ifBanker() then
            if not _player:ifWaitDownBanker() then
                self:autoUpBanker(_player)
            end
            end
            end
        end
        return
    else
        
        ---概率
        if math.random(1,100) > 20 then
            return
        end
    end

    game:tryUpBanker(player)
end


return system