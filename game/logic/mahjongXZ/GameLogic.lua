--[[
    file:GameLogic.lua
    desc:血战麻将
    auth:Karl Luo
]]

local class = require("class")
local mahjongLogic = require("game.logic.mahjongXZ.mahjongLogic")

local GameLogic = class("mahjongGameLogicXZ")

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
function GameLogic:cotr(rule)
    --游戏规则
    self.rule = rule
    --游戏逻辑
    self.logic = mahjongLogic:new(rule)
end

---@field gameStart 游戏开始
---@param playerLis 用户列表
function GameLogic:gameStart(playerLis)
    self.playerLis = playerLis --[[
        [sitID] = {
                rid  = 用户id,
                name = 名字,
                logo = 头像,
                coin = 金钱,
            },
    ]]

    local logic = self.logic

    logic:gameStartXP()

end


--[[游戏结束
]]
function GameLogic:gameClose()
end

--[[
    通知游戏开始
    {
        bankerID = 庄家
        
    }
]]