local senum = require("poker.cx.cx_enum")
---扯旋配置
---@type cxConfig
return {
    types = {
        senum.cx_ptp(),--普通牌
        senum.cx_ht9(),--虎头九
        senum.cx_ce9(),--长二九
        senum.cx_hw9(),--和五九
        senum.cx_rp9(),--人牌九
        senum.cx_dg9(),--地关九
        senum.cx_tg9(),--天关九
        senum.cx_dg(),--地杠
        senum.cx_tg(),--天杠
        senum.cx_ng(),--奶狗
        senum.cx_dz(),--对子
        senum.cx_dh(),--丁皇
    },
    cards = {
        {0x2c,0x0c},--红桃Q  方块Q                             
        {0x22,0x02},--红桃2  方块1                             
        {0x28,0x08},--红桃8  方块8                             
        {0x24,0x04},--红桃4  方块4                             
        {0x34,0x14,0x36,0x16,0x3a,0x1a},--黑4|6|10             
        {0x26,0x06,0x27,0x07,0x2a,0x0a,0x1b,0x3b},--红6|7|10|黑j
        {0x15,0x35,0x17,0x37,0x18,0x38,0x19,0x39,0x23,0x4f},--黑5|7|8|9|红3|大王  
    },
}


---@class cxConfig 
---@field xxx xxx xxx