--[[
    file:mahjongLogic.lua 
    desc:麻将扑克
    auth:Carol Luo
]]

local ipairs = ipairs
local math = require("extend_math")
local table = require("extend_table")
local class = require("class")
local gameLogic = require("gameLogic")
---@class mahjongLogic:gameLogic @麻将扑克
local mahjongLogic = class(gameLogic)
local this = mahjongLogic
local senum = require("mahjongEnum")

---构造函数
---@param table mahjongTable
function mahjongLogic:ctor(table)
    self._table = table
end


---数据获取
------@param senum senum @索引
---@return table<senum,any>
function mahjongLogic:getDriver(senum)
    return self._table:getDriver(senum)
end

---数据设置
------@param senum senum @索引
------@param data  any   @数据
function mahjongLogic:setDriver(senum,data)
    return self._table:setDriver(senum,data)
end

---最大玩家
---@return mjCount
function mahjongLogic:maxPlayer()
    return self._table:getMaxPlayer()
end

---保存数据
---@param senum senum @映射值
---@param data  any   @数据值
function mahjongLogic:setData(senum,data)
    self._table:setData(senum,data)
end

---获取数据
---@return any
function mahjongLogic:getData(senum)
    return self._table:getData(senum)
end

---玩家数组
---@return mahjongPlayer[]
function mahjongLogic:arrPlayer()
    return self._table:getArrPlayer()
end

---剩余牌库
----@return mjCard[]
function mahjongLogic:paiKu()
    return self:getDriver(senum.paiKu())
end

---包含牌库
----@return mjCard[]
function mahjongLogic:baoHan()
    return self:getDriver(senum.baoHan())
end

---庄家玩家
---@return mahjongPlayer
function mahjongLogic:zhuang()
    return self:getDriver(senum.zhuang())
end

---构建牌库
---@param builds mjFill[]
function mahjongLogic:gameSystemCards(builds)
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
function mahjongLogic:gameSystemDingZhuang()
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
function mahjongLogic:gameSystemFapai()
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

---出牌
---@param player mahjongPlayer @麻将玩家
---@return boolean
function mahjongLogic:ableChuPai(player)
end

---摸牌操作
---@param player mahjongPlayer
function mahjongLogic:gameSystemMoPai(player)
    local hands = player:getHands()
    local card = table.remove(self:paiKu())
    table.insert(hands,card)
end

return mahjongLogic