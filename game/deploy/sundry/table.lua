--[[
    desc:桌子创建
    auth:Carol Luo
]]

return {
    ---炸金花
    [1] = {
        [1] = {
            unit = 1,   ---单元积分
            mini = 2,   ---最少桌子
            maxi = 100, ---最多桌子
            idle = 2,   ---保持空闲
        },
        [2] = {
            unit = 5,   ---单元积分
            mini = 2,   ---最少桌子
            maxi = 100, ---最多桌子
            idle = 2,   ---保持空闲
        },
    },
    ---龙虎斗
    [20001] = {
        [1] = {
            unit = 1,   ---单元积分
            mini = 3,   ---最少桌子
            maxi = 3,   ---最多桌子
            idle = nil, ---保持空闲
        },        
    }
}