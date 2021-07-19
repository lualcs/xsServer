--[[
    file:mahjongLogic.lua 
    desc:麻将扑克
    auth:Carol Luo
]]

local ipairs = ipairs
local math = require("extend_math")
local table = require("extend_table")
local class = require("class")
local gameLogic = require("game.logic")
---@class mahjongLogic:gameLogic @麻将扑克
local logic = class(gameLogic)
local this = logic
local senum = require("mahjong.enum")

---构造函数
---@param table mahjongCompetition
function logic:ctor(table)
    self._competition = table
end


---数据获取
------@param senum senum @索引
---@return table<senum,any>
function logic:getDriver(senum)
    return self._competition:getDriver(senum)
end

---数据设置
------@param senum senum @索引
------@param data  any   @数据
function logic:setDriver(senum,data)
    return self._competition:setDriver(senum,data)
end

---最大玩家
---@return mjCount
function logic:maxPlayer()
    return self._competition:getMaxPlayer()
end

---保存数据
---@param senum senum @映射值
---@param data  any   @数据值
function logic:setData(senum,data)
    self._competition:setData(senum,data)
end

---获取数据
---@return any
function logic:getData(senum)
    return self._competition:getData(senum)
end

---玩家数组
---@return mahjongPlayer[]
function logic:arrPlayer()
    return self._competition:getArrPlayer()
end

---剩余牌库
----@return mjCard[]
function logic:paiKu()
    return self:getDriver(senum.paiKu())
end

---包含牌库
----@return mjCard[]
function logic:baoHan()
    return self:getDriver(senum.baoHan())
end

---庄家玩家
---@return mahjongPlayer
function logic:zhuang()
    return self:getDriver(senum.zhuang())
end

---构建牌库
---@param builds mjFill[]
function logic:gameSystemCards(builds)
    local lis = {}
    local map = {}
    self:setDriver(senum.paiKu(),lis)
    self:setDriver(senum.baoHan(),map)
    ---游戏辅助
    ---@type mahjongHelper
    local help = self._hlp
    for _,item in ipairs(builds) do
        for value=item.start,item.close do
            local card = help.getCard(item.color,value)
            map[card] = true
            for again=1,item.again do
                table.insert(lis,card)
            end
        end
    end
end

---系统定庄
function logic:gameSystemDingZhuang()
    local zhuangs = self:getData(senum.zhuangs())
    local maxseat = self:maxPlayer()
    if table.empty(zhuangs) then
        ---随机庄家
        local banker = math.random(1,maxseat)
        self:setDriver(senum.zhuang(),banker)
        table.insert(zhuangs,banker)
        return
    end

    local huangs = self:getData(senum.huangs())
    if table.last(huangs) then
        ---慌庄连庄
        local banker = table.last(zhuangs)
        self:setDriver(senum.zhuang(),banker)
        table.insert(zhuangs,banker)
        return
    end

    ---首胡坐庄|点炮多响
    local banker = self:getData(senum.dingZhuang())
    self:setDriver(senum.zhuang(),banker)
    table.insert(zhuangs,banker)
    
end

---系统发牌
function logic:gameSystemFapai()
    local users = self:arrPlayer()
    local cards = self:paiKu()
    for _,player in ipairs(users) do
        local hands = player:getHands()
        for again=1,13 do
            local card = table.remove(cards)
            table.insert(hands,card)
        end
    end
    local player = self:banker()
    --庄家摸牌
    self:gameSystemMoPai(player)
end

---摸牌操作
---@param player mahjongPlayer
function logic:gameSystemMoPai(player)
    local hands = player:getHands()
    local card = table.remove(self:paiKu())
    table.insert(hands,card)
end

---出牌
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableChuPai(player)
    local hands = player:getHands()
    --检查数量
    local count = #hands
    if 2 ~= count % 3 then
        return false
    end
    return true
end

---碰牌
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ablePengPai(player)
    local hands = player:getHands()
    --检查玩家
    if player == self._last_chupai_play then
        return false
    end

    --检查数量
    local count = #hands
    if 1 ~= count % 3 then
        return false
    end

    --检查出牌
    local card = self._last_chupai_card
    if not table.existCount(hands,card,2) then
        return false
    end

    return true
end

---直杠
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableZhiGang(player)
    local hands = player:getHands()
    --检查玩家
    if player == self._last_chupai_play then
        return false
    end

    --检查数量
    local count = #hands
    if 1 ~= count % 3 then
        return false
    end

    --检查出牌
    local card = self._last_chupai_card
    if not table.existCount(hands,card,3) then
        return false
    end

    return true
end

local copy1 = {nil}
---绕杠
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableRaoGang(player)
    local hands = player:getHands()
    --检查数量
    local count = #hands
    if 2 ~= count % 3 then
        return false
    end

    --检查绕杠
    local list = table.clear(copy1)
    local pengs = player:getPengs()
    for _,card in ipairs(pengs) do
        if table.exist(hands,card) then
            table.insert(list,card)
        end
    end

    local ok = not table.empty(list)
    return ok,list
end


local copy1 = {nil}
local copy2 = {nil}
---暗杠
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableAnGang(player)
    local hands = player:getHands()
    --检查数量
    local count = #hands
    if 2 ~= count % 3 then
        return false
    end

    --检查暗杠
    local list = table.clear(copy1)
    local maps = table.arrToHas(hands,copy2)
    for card,count in ipairs(maps) do
        if count >= 4 then
            table.insert(list,card)
        end
    end

    local ok = not table.empty(list)
    return ok,list
end

---点炮
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableDianPao(player)
   
end

---抢杠
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableQiangGang(player)
   
end

---自摸
---@param player mahjongPlayer @麻将玩家
---@return boolean
function logic:ableZiMo(player)
   
end

---出牌操作
---@param player mahjongPlayer @玩家
---@param card mjCard @出牌
function logic:gamePlayingChuPai(player,card)
    ---最后出牌
    ---@type mjCard
    self._last_chupai_card = card
    ---出牌玩家
    ---@type mahjongPlayer
    self._last_chupai_play = player
end

return logic