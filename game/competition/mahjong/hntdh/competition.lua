--[[
    file:hntdhTable.lua 
    desc:河南推倒胡
    auth:Carol Luo
]]


local class = require("class")
local mahjongCompetition = require("mahjong.competition")
local senum = require("hntdh.enum")
---@class hntdhTable:gameCompetition @河南推倒胡
local hntdhTable = class(mahjongCompetition)
local this = hntdhTable


---构造函数
function hntdhTable:ctor()
    ---行为优先
    self._prioritys = {
        [senum.xiapao()]    = 1,
        [senum.chuPai()]    = 2,
        [senum.pengPai()]   = 3,
        [senum.zhiGang()]   = 4,
        [senum.raoGang()]   = 5,
        [senum.anGang()]    = 6,
        [senum.dianPao()]   = 7,
        [senum.qiangGang()] = 8,
        [senum.ziMo()]      = 9,
    }

    ---扑克逻辑
    ---@type mahjongLogic
    local lgc = self._lgc
    ---行为数据
    self._behaviors = {
        [senum.xiapao()] = {--下跑阶段
            [senum.xiapao()]  = lgc.ableXiapao;
        },
        [senum.game()] = {--摸打阶段
            [senum.chuPai()]    = lgc.ableChuPai;      --出牌
            [senum.pengPai()]   = lgc.ablePengPai;     --碰牌
            [senum.zhiGang()]   = lgc.ableZhiGang;     --直杠
            [senum.raoGang()]   = lgc.ableRaoGang;     --饶杠
            [senum.anGang()]    = lgc.ableAnGang;      --暗杠
            [senum.dianPao()]   = lgc.ableDianPao;     --点炮
            [senum.qiangGang()] = lgc.ableQiangGang;   --抢杠
            [senum.ziMo()]      = lgc.ableZiMo;        --自摸
        },
    }
end

return hntdhTable