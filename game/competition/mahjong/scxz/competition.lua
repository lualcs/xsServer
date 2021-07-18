--[[
    file:scxzTable.lua 
    desc:四川血战
    auth:Carol Luo
]]


local class = require("class")
local senum = require("scxz.enum")
local mjCompetition = require("mahjong.competition")
---@class scxzCompetition:gameCompetition @四川血战
local competition = class(mjCompetition)
local this = competition


---构造函数
function competition:ctor()
    ---行为优先
    self._prioritys = {
        [senum.chuPai()]    = 1,
        [senum.pengPai()]   = 2,
        [senum.zhiGang()]   = 3,
        [senum.raoGang()]   = 4,
        [senum.anGang()]    = 5,
        [senum.dianPao()]   = 6,
        [senum.qiangGang()] = 7,
        [senum.ziMo()]      = 8,
    }

    ---扑克逻辑
    ---@type mahjongLogic
    local lgc = self._lgc
    ---行为数据
    self._behaviors = {
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

return competition