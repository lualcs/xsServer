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
        [senum.dragon()] = {--和
            area = senum.dragon(),
            maxi = 100000,
            odds = 1,
        },
        [senum.peace()] = {--虎
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
        200,
    },
}