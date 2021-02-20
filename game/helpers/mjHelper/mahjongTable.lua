--[[
    file:mahjongLogic.lua 
    desc:麻将逻辑
    auth:Carol Luo
]]

local class = require("class")
local senum = require("mahjongEnum")
local gameTable = require("gameTable")
---@class mahjongTable:gameTable @麻将桌子
local mahjongTable = class(gameTable)
local this = mahjongTable


---构造函数
function mahjongTable:ctor()
    ---@type table<senum,number>                    @动作优先级
    self._prioritys = nil;
    ---@type table<status,table<senum,function>>    @动作检查表
    self._behaviors = nil;
end

---重制数据
function mahjongTable:dataReboot()
    self:super(this,"dataReboot")
end

---@class s2cMahjongStart @游戏开始

---游戏开始
---@param data s2cMahjongStart @数据
function mahjongTable:s2cMahjongStart(data)
    self:ntfMsgToTable(data);
end

---@class s2cMahjongClose @游戏结束

---游戏结束
---@param data s2cMahjongClose @数据
function mahjongTable:s2cMahjongClose(data)
    self:ntfMsgToTable(data);
end

---@class s2cMahjongDealCard @游戏发牌
---@field isBanker boolean  @是否庄家
---@field seatID   seatID   @发牌玩家
---@field counts   count    @发牌张数
---@field cards    mjCard[] @发牌数据

local see = {
    fields = {"cards"},
    chairs = {},
}
---游戏发牌
---@param data s2cMahjongDealCard @数据
function mahjongTable:s2cMahjongDealCard(data)
    see.chairs[1]=data.seatID
    self:ntfMsgToTable("s2cMahjongDealCard",senum.faPai(),data,see);
end

---@class s2cMahjongDetails @游戏详情
---@field seatID seatID @麻将详情
---@field status status @游戏状态
---@field pcards xxxxxx @玩家麻将

---游戏详情
---@param data table @数据
function mahjongTable:s2cMahjongDetails(data)
    local seat = data.seatID
    local player = self._arrPlayer[seat];
    self:ntfMsgToPlayer(player,"s2cMahjongDetails",senum.scene(),data);
end

---@class s2cMahjongBuHua   @补花通知
---@field seatID seatID     @补花玩家
---@field cards  mjCard[]   @补花数据

---补花通知
---@param data s2cMahjongBuHua @数据
function mahjongTable:s2cMahjongBuHua(data)
    self:ntfMsgToTable("s2cMahjongBuHua",senum.buHua(),data);
end

---@class s2cMahjongChuPai @出牌通知
---@field seatID seatID    @出牌玩家
---@field cards  mjCard[]  @出牌数据


---出牌通知
---@param data s2cMahjongChuPai @数据
function mahjongTable:s2cMahjongChuPai(data)
    self:ntfMsgToTable("s2cMahjongChuPai",senum.chuPai(),data);
end

---@class s2cMahjongMoPai @摸牌通知
---@field seatID seatID   @摸牌玩家
---@field cards  mjCard[] @摸牌数据

local see = {
    fields = {"cards"},
    chairs = {},
}

---摸牌通知
---@param data s2cMahjongMoPai @数据
function mahjongTable:s2cMahjongMoPai(data)
    see.chairs[1]=data.seatID
    self:ntfMsgToTable("s2cMahjongMoPai",senum.moPai(),data,see);
end

---@class s2cMahjongChiPai  @吃牌通知
---@field seatID seatID     @吃牌玩家
---@field cards  mjCard[]   @吃牌数据

---吃牌通知
---@param data s2cMahjongChiPai @数据
function mahjongTable:s2cMahjongChiPai(data)
    self:ntfMsgToTable("s2cMahjongChiPai",senum.chiPai(),data);
end

---@class s2cMahjongPengPai @碰牌通知
---@field seatID seatID     @碰牌玩家
---@field cards  mjCard[]   @碰牌数据

---碰牌通知
---@param data s2cMahjongPengPai @数据
function mahjongTable:s2cMahjongPengPai(data)
    self:ntfMsgToTable("s2cMahjongPengPai",senum.pengPai(),data);
end

---@class s2cMahjongGangPai @杠牌通知
---@field seatID seatID     @杠牌玩家
---@field senum  senum      @杠牌动作
---@field cards  mjCard[]   @杠牌数据

---杠牌通知
---@param data s2cMahjongGangPai @数据
function mahjongTable:s2cMahjongGangPai(data)
    self:ntfMsgToTable("s2cMahjongGangPai",data.senum,data);
end

---@class s2cMahjongHuPai @胡牌通知
---@field senum  string   @胡牌动作
---@field types  string[] @胡牌类型
---@field cards  mjCard[] @胡牌数据

---胡牌通知
---@param data s2cMahjongHuPai @数据
function mahjongTable:s2cMahjongHuPai(data)
    self:ntfMsgToTable("s2cMahjongHuPai",data.senum,data);
end

---@class s2cMahjongTimer @计时通知
---@field djs    sec      @倒计时

---计时通知
---@param data s2cMahjongTimer @数据
function mahjongTable:s2cMahjongTimer(data)
    self:ntfMsgToTable("s2cMahjongTimer",senum.timer(),data);
end

---@class s2cMahjongHandle      @操作通知
---@field seatID  seatID        @位置
---@field poinID  seatID        @指向
---@field handles mjHandle[]    @操作

---操作通知
---@param data s2cMahjongHandle @数据
function mahjongTable:s2cMahjongHandle(data)
    self:ntfMsgToTable("s2cMahjongHandle",senum.handle(),data);
end

---@class sc2MahjongDeduct @扣分通知
---@field senum  string     @扣分动作
---@field types  string[]   @扣分原因
---@field score  score      @变化分数
---@field balan  score      @当前余额

---扣分通知
---@param data sc2MahjongDeduct @数据
function mahjongTable:sc2MahjongDeduct(data)
    self:ntfMsgToTable("sc2MahjongDeduct",senum.deduct(),data);
end



return mahjongTable