--[[
    desc:机器人策略
    auth:Carol Luo
]]


return {

    ---龙虎斗
    [20001] = {
        ---热度配置
        hotspot = {
            ---热度重置 分*秒*毫秒
            opportunity = 5*60*1000,
            seasonLists = {
                 ---冷场配置
                {
                    sum = 10000,
                    lis = {
                        {weight=1000,min=0,max=0},
                        {weight=2000,min=1,max=3},
                        {weight=3000,min=4,max=5},
                        {weight=3000,min=6,max=8},
                        {weight=1000,min=9,max=10},
                    },
                },
                ---改善配置
                {
                    sum = 10000,
                    lis = {
                        {weight=1000,min=11,max=20},
                        {weight=2000,min=21,max=30},
                        {weight=3000,min=31,max=40},
                        {weight=3000,min=41,max=50},
                        {weight=1000,min=51,max=60},
                    },
                },
                ---火热配置
                {
                    sum = 10000,
                    lis = {
                        {weight=1000,min=50,max=60},
                        {weight=2000,min=61,max=70},
                        {weight=3000,min=71,max=80},
                        {weight=3000,min=81,max=90},
                        {weight=1000,min=91,max=100},
                    },
                },
            },
           
            ---热度时间
            seasonDate = {
                [1] = {
                    [0]  = 2,[1]  = 1,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 2,
                    [6]  = 2,[7]  = 2,[8]  = 2,[9]  = 1,[10] = 1,[11] = 2,
                    [12] = 2,[13] = 2,[14] = 2,[15] = 1,[16] = 1,[17] = 1,
                    [18] = 2,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 2,
                    
                },
                [2] = {
                    [0]  = 2,[1]  = 1,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 2,
                    [6]  = 2,[7]  = 2,[8]  = 2,[9]  = 1,[10] = 1,[11] = 2,
                    [12] = 2,[13] = 2,[14] = 2,[15] = 1,[16] = 1,[17] = 1,
                    [18] = 2,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 2,
                },
                [3] = {
                    [0]  = 2,[1]  = 1,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 2,
                    [6]  = 2,[7]  = 2,[8]  = 2,[9]  = 1,[10] = 1,[11] = 2,
                    [12] = 2,[13] = 2,[14] = 2,[15] = 1,[16] = 1,[17] = 1,
                    [18] = 2,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 2,
                },
                [4] = {
                    [0]  = 2,[1]  = 1,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 2,
                    [6]  = 2,[7]  = 2,[8]  = 2,[9]  = 1,[10] = 1,[11] = 2,
                    [12] = 2,[13] = 2,[14] = 2,[15] = 1,[16] = 1,[17] = 1,
                    [18] = 2,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 2,
                },
                [5] = {
                    [0]  = 2,[1]  = 1,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 2,
                    [6]  = 2,[7]  = 2,[8]  = 2,[9]  = 1,[10] = 1,[11] = 2,
                    [12] = 2,[13] = 2,[14] = 2,[15] = 1,[16] = 1,[17] = 1,
                    [18] = 2,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 3,
                },
                [6] = {
                    [0]  = 2,[1]  = 1,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 2,
                    [6]  = 2,[7]  = 2,[8]  = 2,[9]  = 2,[10] = 2,[11] = 2,
                    [12] = 2,[13] = 3,[14] = 3,[15] = 3,[16] = 3,[17] = 3,
                    [18] = 3,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 3,
                },
                [7] = {
                    [0]  = 2,[1]  = 3,[2]  = 1,[3]  = 1,[4]  = 1,[5]  = 3,
                    [6]  = 2,[7]  = 3,[8]  = 3,[9]  = 3,[10] = 3,[11] = 3,
                    [12] = 2,[13] = 3,[14] = 3,[15] = 3,[16] = 3,[17] = 3,
                    [18] = 3,[19] = 3,[20] = 3,[21] = 3,[22] = 3,[23] = 3,
                },
            }

        },
        ---携带权重 携带 = min(最小浮动,最大浮动) * 随机携带 // 1
        carry = {
            ---总和权重
            sum = 10000,
            ---最小浮动 
            floatMini = 1,
            ---最大浮动
            floatMaxi = 1,
            ---浮动总和
            floatSumm = 1,
            ---权重列表
            lis = {
                {weight=10000,asset = 1000},
            },
        },
        ---机器入场
        enter = {
            ---时机
            opportunity = 10*1000,
        },
        ---离开配置
        leave = {
            ---最低资产
            asset = 1,
            ---最多时间
            timer = {
                min = 10*60*1000,
                max = 30*60*1000,
            }
        },
        ---下注策略
        strategy = {
            sumProbability = 100,
            betProbability = 50,
            betAreas = {
                sum = 100,
                lis = {
                    {
                        weight = 45,
                        areas = {
                            "dragon",
                        },
                    },
                    {
                        weight = 45,
                        areas = {
                            "tiger",
                        },
                    },
                    {
                        weight = 6,
                        areas = {
                            "peace",
                        },
                    },
                    {
                        weight = 2,
                        areas = {
                            "dragon",
                            "peace",
                        },
                    },
                    {
                        weight = 2,
                        areas = {
                            "tiger",
                            "peace",
                        },
                    },
                },
                
            },
            sum = 2000,
            lis = {
                ---100%
                {weight = 400,ratio = 1.0},
                ---50%
                {weight = 200,ratio = 0.5},
                ---20%
                {weight = 200,ratio = 0.2},
                ---10%
                {weight = 200,ratio = 0.1},
                ---筹码
                {weight = 100,chips = {1},},
                ---筹码
                {weight = 100,chips = {2},},
                ---筹码
                {weight = 100,chips = {3},},
                ---筹码
                {weight = 100,chips = {4},},
                ---筹码
                {weight = 100,chips = {5},},
                ---随机多个筹码
                {weight = 500,rands = {
                    min=1,
                    max=10,
                    lis={1,2,2,3,3,3,4,4,4,4,5,5,5,5,5}
                },},
            },
        },
    }
}

---@alias robotEnterMap table<gameID,robotEnter>
---机器人入场配置

---@class robotEnter @入场配置
---@field hotspot   enterHotspot    @游戏热度
---@field carry     enterCarry      @资产携带


---@class enterCarry          @入场携带
---@field floatMini number    @携带浮动
---@field floatMaxi number    @携带浮动
---@field floatSumm number    @浮动比例
---@field sum integer         @总和权重 
---@field lis assetwt[]       @携带权重


---@class assetwt @资产权重
---@field weight integer   @权重数值
---@field asset  integer   @单元资产 n * 底分

---@class enterHotspot               @入场热度
---@field opportunity   sec          @重置热度
---@field lonelyRange   enterRange   @冷场人数
---@field betterRange   enterRange   @暖场人数
---@field fieryRange    enterRange   @热场人数
---@field seasonDate    seasonDate   @热场时间

---@class enterRange          @入场携带
---@field sum integer         @总和权重 
---@field lis countWight[]    @携带权重

---@class countWight @数量权重
---@field weight    integer   @权重数值
---@field min       integer   @最少数量
---@field max       integer   @最多数量

---@alias seasonDate table<week,table<hour,integer>>
---热场等级时机段