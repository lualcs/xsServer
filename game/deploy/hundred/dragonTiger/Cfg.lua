--[[
    desc:龙虎
    auth:Carol Luo
]]

local senum = require("dragonTiger.enum")

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

    ---游戏牌库
    pokers = {
        0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0a,0x0b,0x0c,0x0d,
        0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1a,0x1b,0x1c,0x1d,
        0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2a,0x2b,0x2c,0x2d,
        0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3a,0x3b,0x3c,0x3d,
    },
}