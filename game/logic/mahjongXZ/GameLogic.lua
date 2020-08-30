--[[
    file:GameLogic.lua
    desc:血战麻将
    auth:Karl Luo
]]

local class = require("class")
local mahjongLogic = require("game.logic.mahjongXZ.mahjongLogic")

local gameLogic = class("mahjongGameLogicXZ")

--[[
    @param rule = {
        unitScore    = 单元积分:结算分数
        minScore     = 最少积分:入场限制
        maxScore     = 最多积分:入场限制
        maxPower     = 最大番数:最大番数

        roomName     = 房间名字
        sitCount     = 房间人数

        mahjongCard = { --麻将牌

        }
    }
]]
function gameLogic:cotr(rule)
    ---@field rule 游戏规则
    self.rule = rule
    ---@field logic 游戏逻辑
    self.logic = mahjongLogic:new(rule)
end

---@field gameStart 游戏开始
---@param playerLis 用户列表
function gameLogic:gameStart(playerLis)
    self.playerLis = playerLis --[[
        [sitID] = {
                rid  = 用户id,
                name = 名字,
                logo = 头像,
                coin = 金钱,
            },
    ]]

    --设庄
    self.logic:gameStartBanker()
    --洗牌
    self.logic:gameStartXP()
    --发牌
    self.logic:gameStartFP()
end


--[[游戏结束
]]
function gameLogic:gameClose()
end

--[[
    游戏开始-发牌
    
    游戏开始-换三张

    游戏开始-定缺
]]