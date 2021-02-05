--[[
    file:mahjongEnum.lua 
    desc:麻将枚举
    auth:Caorl Luo
]]

local class = require("class")
local gameEnum = require("gameEnum")

---@class mahjongEnum:gameEnum @麻将枚举
local mahjongEnum = class(gameEnum)
local this = mahjongEnum

---构造 
function mahjongEnum:ctor()
end

---发牌
---@return senum
function mahjongEnum.faPai()
    return "faPai"
end

---补花
---@return senum
function mahjongEnum.buHua()
    return "buHua"
end
---出牌
---@return senum
function mahjongEnum.chuPai()
    return "chuPai"
end
---摸牌
---@return senum
function mahjongEnum.moPai()
    return "moPai"
end
---吃牌
---@return senum
function mahjongEnum.chiPai()
    return "chiPai"
end
---碰牌
---@return senum
function mahjongEnum.pengPai()
    return "pengPai"
end
---直杠|点杠|明杠
---@return senum
function mahjongEnum.zhiGang()
    return "zhiGang"
end
---饶杠|补杠|巴杠
---@return senum
function mahjongEnum.raoGang()
    return "raoGang"
end
---暗杠
---@return senum
function mahjongEnum.anGang()
    return "anGang"
end
---点炮
---@return senum
function mahjongEnum.dianPao()
    return "dianPao"
end
---抢杠
---@return senum
function mahjongEnum.qiangGang()
    return "qiangGang"
end
---自摸
---@return senum
function mahjongEnum.ziMo()
    return "ziMo"
end

---平胡|鸡胡
---@return senum
function mahjongEnum.pingHu()
    return "pingHu"
end

---七对|暗七对
---@return senum
function mahjongEnum.qiDui()
    return "qiDui"
end

---龙七对
---@return senum
function mahjongEnum.longQiDui()
    return "longQiDui"
end

---清七对
---@return senum
function mahjongEnum.qingQiDui()
    return "qingQiDui"
end

---清龙七对
---@return senum
function mahjongEnum.qingLongQiDui()
    return "qingLongQiDui"
end

---清一色
---@return senum
function mahjongEnum.qingYiSe()
    return "qingYiSe"
end

---门清
---@return senum
function mahjongEnum.menQing()
    return "menQing"
end

---清碰
---@return senum
function mahjongEnum.qingPeng()
    return "qingPeng"
end

---大对子
---@return senum
function mahjongEnum.daDuiZi()
    return "daDuiZi"
end

---卡二条
---@return senum
function mahjongEnum.kaErTiao()
    return "kaErTiao"
end

---四归一
---@return senum
function mahjongEnum.siGuiYi()
    return "siGuiYi"
end

---金钩钓
---@return senum
function mahjongEnum.jinGouDiao()
    return "jinGouDiao"
end

---金钩炮
---@return senum
function mahjongEnum.jingGouPao()
    return "jingGouPao"
end

---一般高
---@return senum
function mahjongEnum.yiBanGao()
    return "yiBanGao"
end

---碰碰
---@return senum
function mahjongEnum.pengPeng()
    return "pengPeng"
end

---海底胡
---@return senum
function mahjongEnum.haiDiHu()
    return "haiDiHu"
end

---海底炮
---@return senum
function mahjongEnum.haiDiPao()
    return "haiDiPao"
end

---海底捞
---@return senum
function mahjongEnum.haiDiLao()
    return "haiDiLao"
end

---点杠花
---@return senum
function mahjongEnum.dianGangHua()
    return "dianGangHua"
end

---杠上花
---@return senum
function mahjongEnum.gangShangHua()
    return "gangShangHua"
end

---杠上炮
---@return senum
function mahjongEnum.gangShangPao()
    return "gangShangPao"
end

---天胡
---@return senum
function mahjongEnum.tianHu()
    return "tianHu"
end

---地胡
---@return senum
function mahjongEnum.diHu()
    return "diHu"
end

---巴倒烫
---@return senum
function mahjongEnum.baDaoTang()
    return "baDaoTang"
end

---陪大叫
---@return senum
function mahjongEnum.peiDaJiao()
    return "peiDaJiao"
end

---查大叫
---@return senum
function mahjongEnum.chaDaJiao()
    return "chaDaJiao"
end

---豹子
---@return senum
function mahjongEnum.baoZi()
    return "baoZi"
end

---报叫
---@return senum
function mahjongEnum.baoJiao()
    return "baoJiao"
end

---报听
---@return senum
function mahjongEnum.baoTing()
    return "baoTing"
end

---亮倒
---@return senum
function mahjongEnum.liangDao()
    return "liangDao"
end

return mahjongEnum