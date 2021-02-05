--[[
    file:hntdhTable.lua 
    desc:河南推倒胡
    auth:Carol Luo
]]


local class = require("class")
local mahjongTable = require("mahjongTable")
local senum = require("hntdhEnum")
---@class hntdhTable:gameTable @河南推倒胡
local hntdhTable = class(mahjongTable)
local this = hntdhTable


---构造函数
function hntdhTable:ctor()
    ---动作优先级
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
    ---动作检查项
    self._ablecheck = {
        [senum.xiapao()] = {--下跑阶段
            [senum.xiapao()]  = self._lgc.xiapaoCheck;
        },
        [senum.game()] = {--摸打阶段
            [senum.chuPai()]    = self._lgc.chupaiCheck;      --出牌
            [senum.moPai()]     = self._lgc.mopaiCheck;       --摸牌
            [senum.pengPai()]   = self._lgc.pengPaiCheck;     --碰牌
            [senum.zhiGang()]   = self._lgc.zhiGangCheck;     --直杠
            [senum.raoGang()]   = self._lgc.raoGangCheck;     --饶杠
            [senum.anGang()]    = self._lgc.anGangCheck;      --暗杠
            [senum.dianPao()]   = self._lgc.dianPaoCheck;     --点炮
            [senum.qiangGang()] = self._lgc.qiangGangCheck;   --抢杠
            [senum.ziMo()]      = self._lgc.ziMoCheck;        --自摸
        },
    }
end

return hntdhTable