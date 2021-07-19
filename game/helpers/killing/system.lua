--[[
    desc:策略
    auth:Carol Luo
]]

local math = math
local pairs = pairs
local class = require("class") 
local reusable = require("reusable")
local table = require("extend_table")
local debug = require("extend_debug")
local gameSystem = require("game.system")
---@class killingSystem:gameSystem
local system = class(gameSystem)
local this = system

---构造 
function system:ctor()
    ---下注结构仓库
    ---@type reusable
    self._robotBetReusable = reusable.new()
end

---重启
function system:dataReboot()
    self:super(this,"dataReboot")
    ---随机上庄
    self._tim:appendEver(5*1000,function()
        self:autoUpBanker()
    end)
end

---获取下注仓库
---@return reusable
function system:robotBetReusable()
    return self._robotBetReusable
end

---机器人策略
---@return reusable
function system:robotStrategy()
    ---比赛
    ---@type hundredCompetition
    local game = self._competition
    ---遍历
    local mapPlayer = game._mapPlayer
    for _,player in pairs(mapPlayer) do
        if player:ifRobot() then
            player:robotStrategy()
        end
    end
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

---机器下注
function system:robotBetting()
    ---自动下注
    local duration = self._stu:leftMilliscond()
    self._tim:append(100,duration // 100,function()
        self:autoBetting()
    end)
end

---自动下注
---@param player hundredPlayer
function system:autoBetting(player)
    ---百人游戏
    ---@type hundredCompetition
    local game = self._competition

    if not player then
        ---遍历
        local mapPlayer = game._mapPlayer
        for _,_player in pairs(mapPlayer) do
            if _player:ifRobot() then
            if not _player:ifBanker() then
                self:autoBetting(_player)
            end
            end
        end
    else

        ---下注信息
        local data = player:strategy()
        if table.empty(data.bets) then
            return
        end

        ---触发概率
        local duration = self._stu:leftMilliscond()
        local looptime = duration // 100
        local bettings = player:bettings()
        local probability = #bettings / looptime * 100
        if math.random(1,100) > probability then
            return
        end

        ---下注信息
        ---@type hundredRobotBetting
        local bet = table.remove(bettings)
        game:tryBetting(player,bet.area,bet.chip)
    end
end



return system