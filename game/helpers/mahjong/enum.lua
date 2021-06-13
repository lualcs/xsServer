--[[
    file:mahjongEnum.lua 
    desc:麻将枚举
    auth:Caorl Luo
]]

local class = require("class")
local gameEnum = require("game.enum")

---@class mahjongEnum:gameEnum @麻将枚举
local enum = class(gameEnum)
local this = enum

---构造 
function enum:ctor()
end

---庄家
---@return senum
function enum.zhuang()
    return "zhuang"
end

---庄家
---@return senum
function enum.zhuangs()
    return "zhuangs"
end

---慌庄
---@return senum
function enum.huangs()
    return "huangs"
end

---定庄
---@return senum
function enum.dingZhuang()
    return "dingZhuang"
end

---牌库
---@return senum
function enum.paiKu()
    return "paiKu"
end

---映射
---@return senum
function enum.baoHan()
    return "baoHan"
end

---发牌
---@return senum
function enum.faPai()
    return "faPai"
end

---操作
---@return senum
function enum.handle()
    return "handle"
end

---补花
---@return senum
function enum.buHua()
    return "buHua"
end
---出牌
---@return senum
function enum.chuPai()
    return "chuPai"
end
---摸牌
---@return senum
function enum.moPai()
    return "moPai"
end
---吃牌
---@return senum
function enum.chiPai()
    return "chiPai"
end
---碰牌
---@return senum
function enum.pengPai()
    return "pengPai"
end
---直杠|点杠|明杠
---@return senum
function enum.zhiGang()
    return "zhiGang"
end
---饶杠|补杠|巴杠
---@return senum
function enum.raoGang()
    return "raoGang"
end
---暗杠
---@return senum
function enum.anGang()
    return "anGang"
end
---点炮
---@return senum
function enum.dianPao()
    return "dianPao"
end
---抢杠
---@return senum
function enum.qiangGang()
    return "qiangGang"
end
---自摸
---@return senum
function enum.ziMo()
    return "ziMo"
end

---平胡|鸡胡
---@return senum
function enum.pingHu()
    return "pingHu"
end

---七对|暗七对
---@return senum
function enum.qiDui()
    return "qiDui"
end

---龙七对
---@return senum
function enum.longQiDui()
    return "longQiDui"
end

---清七对
---@return senum
function enum.qingQiDui()
    return "qingQiDui"
end

---清龙七对
---@return senum
function enum.qingLongQiDui()
    return "qingLongQiDui"
end

---清一色
---@return senum
function enum.qingYiSe()
    return "qingYiSe"
end

---门清
---@return senum
function enum.menQing()
    return "menQing"
end

---清碰
---@return senum
function enum.qingPeng()
    return "qingPeng"
end

---大对子
---@return senum
function enum.daDuiZi()
    return "daDuiZi"
end

---卡二条
---@return senum
function enum.kaErTiao()
    return "kaErTiao"
end

---四归一
---@return senum
function enum.siGuiYi()
    return "siGuiYi"
end

---金钩钓
---@return senum
function enum.jinGouDiao()
    return "jinGouDiao"
end

---金钩炮
---@return senum
function enum.jingGouPao()
    return "jingGouPao"
end

---一般高
---@return senum
function enum.yiBanGao()
    return "yiBanGao"
end

---碰碰
---@return senum
function enum.pengPeng()
    return "pengPeng"
end

---海底胡
---@return senum
function enum.haiDiHu()
    return "haiDiHu"
end

---海底炮
---@return senum
function enum.haiDiPao()
    return "haiDiPao"
end

---海底捞
---@return senum
function enum.haiDiLao()
    return "haiDiLao"
end

---点杠花
---@return senum
function enum.dianGangHua()
    return "dianGangHua"
end

---杠上花
---@return senum
function enum.gangShangHua()
    return "gangShangHua"
end

---杠上炮
---@return senum
function enum.gangShangPao()
    return "gangShangPao"
end

---天胡
---@return senum
function enum.tianHu()
    return "tianHu"
end

---地胡
---@return senum
function enum.diHu()
    return "diHu"
end

---巴倒烫
---@return senum
function enum.baDaoTang()
    return "baDaoTang"
end

---陪大叫
---@return senum
function enum.peiDaJiao()
    return "peiDaJiao"
end

---查大叫
---@return senum
function enum.chaDaJiao()
    return "chaDaJiao"
end

---豹子
---@return senum
function enum.baoZi()
    return "baoZi"
end

---报叫
---@return senum
function enum.baoJiao()
    return "baoJiao"
end

---报听
---@return senum
function enum.baoTing()
    return "baoTing"
end

---亮倒
---@return senum
function enum.liangDao()
    return "liangDao"
end

return enum