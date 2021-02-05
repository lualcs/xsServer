--[[
    file:mahjongPlayer.lua 
    desc:游戏玩家
    auth:Caorl Luo
]]

local class = require("class")
local table = require("extend_table")
local gamePlayer = require("gamePlayer")

---@class mahjongPlayer:gamePlayer @麻将玩家
local mahjongPlayer = class(gamePlayer)
local this = mahjongPlayer

---构造函数
function mahjongPlayer:ctor()
end

---重启
function mahjongPlayer:dataReboot()
    self:super(this,"dataReboot")
    ---@type mjBehavior[] @操作记录-完整 摸-补花-打-吃-碰-杠-胡
    self._behavior_finish = {}
    ---@type mjBehavior[] @操作记录-普通 摸-打-吃-碰-杠-胡
    self._behavior_normal = {}
    ---@type mjCard[]     @玩家手牌
    self._hands = {}
    ---@type mjCard[]     @玩家出牌
    self._appears = {}
    ---@type mjShow[]     @展示数据
    self._shows = {}
end

---插入普通操作
---@param behavior mjBehavior @操作 
function mahjongPlayer:insertBehaviorNormal(behavior)
    local list = self._behavior_normal
    table.insert(list,behavior)
    self:insertHandleFinish(behavior)
end

---插入完整操作
---@param behavior mjBehavior @操作 
function mahjongPlayer:insertBehaviorFinish(behavior)
    local list = self._behavior_finish
    table.insert(list,behavior)
end


---完整倒数操作
---@param serial count @序号
function mahjongPlayer:backBehaviorFinishBy(serial)
    local list = self._behavior_finish
    local size = #list
    return list[size-serial+1]
end

---普通倒数操作
---@param serial count @序号
function mahjongPlayer:backBehaviorNormalBy(serial)
    local list = self._behavior_normal
    local size = #list
    return list[size-serial+1]
end

---手牌数据
function mahjongPlayer:getHands()
    return self._hands
end

---出牌数据
function mahjongPlayer:getAppears()
    return self._appears
end

---展示数据
function mahjongPlayer:getShows()
    return self._shows
end

return mahjongPlayer