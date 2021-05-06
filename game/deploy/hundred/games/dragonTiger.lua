--[[
    desc:龙虎
    auth:Carol Luo
]]

local senum = require("dragonTiger.dragonTigerEnum")

---@class dragonTigerDeploy:hundredDeploy @龙虎配置

return {
    ---下注区域
    ---@type table<senum,hundredAreaInf>
    areas = {
        [senum.dragon()] = {--龙
            area = senum.dragon(),
            maxi = 100000,
            odds = 1,
        },
        [senum.dragon()] = {--虎
            area = senum.dragon(),
            maxi = 100000,
            odds = 1,
        },
        [senum.peace()] = {--和
            area = senum.peace(),
            maxi = 100000,
            odds = 16,
        },
    },

    ---下注筹码
    jettons = {
        1,
        5,
        10,
        20,
        50,
        100,
        500,
        1000,
    },

    ---上庄配置
    bankers = {
        doorsill = 1000,    ---上庄门槛
        continue = 10,      ---连续当庄
        minimum  = 1,       ---最少庄家
        maximum  = 6,       ---最多庄家
    },
}