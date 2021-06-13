--[[
    file:mahjongPlayer.lua 
    desc:游戏玩家
    auth:Caorl Luo
]]

local class = require("class")
local table = require("extend_table")
local gamePlayer = require("game.player")

---@class mahjongPlayer:gamePlayer @麻将玩家
local player = class(gamePlayer)
local this = player

---构造函数
function player:ctor()
end

---重启
function player:dataReboot()
    self:super(this,"dataReboot")
    ---操作记录-完整 摸-补花-打-吃-碰-杠-胡
    ---@type mjBehavior[] 
    self._behavior_finish = {}
    ---操作记录-普通 摸-打-吃-碰-杠-胡
    ---@type mjBehavior[] 
    self._behavior_normal = {}
    ---玩家手牌
    ---@type mjCard[]     
    self._hands = {}
    ---玩家出牌
    ---@type mjCard[]     
    self._appears = {}
    ---展示数据
    ---@type mjShow[]     
    self._shows = {}
    ---碰牌数据
    ---@type mjCard[]
    self._pengs = {}
    ---直杠数据
    ---@type mjCard[]
    self._zhigangs = {}
    ---绕杠数据
    ---@type mjCard[]
    self._raogangs = {}
    ---暗杠数据
    ---@type mjCard[]
    self._angangs = {}
    ---点炮数据
    ---@type mjCard[]
    self._dianpaos = {}
    ---自摸数据
    ---@type mjCard[]
    self._zimos = {}
end

---插入普通操作
---@param behavior mjBehavior @操作 
function player:insertBehaviorNormal(behavior)
    local list = self._behavior_normal
    table.insert(list,behavior)
    self:insertHandleFinish(behavior)
end

---插入完整操作
---@param behavior mjBehavior @操作 
function player:insertBehaviorFinish(behavior)
    local list = self._behavior_finish
    table.insert(list,behavior)
end


---完整倒数操作
---@param serial count @序号
---@return mjBehavior|nil
function player:backBehaviorFinishBy(serial)
    local list = self._behavior_finish
    local size = #list
    return list[size-serial+1]
end

---普通倒数操作
---@param serial count @序号
---@return mjBehavior|nil
function player:backBehaviorNormalBy(serial)
    local list = self._behavior_normal
    local size = #list
    return list[size-serial+1]
end

---手牌数据
---@return mjcard[]
function player:getHands()
    return self._hands
end

---出牌数据
---@return mjcard[]
function player:getAppears()
    return self._appears
end

---展示数据
---@return mjShow[]
function player:getShows()
    return self._shows
end

---碰牌数据
---@return mjcard[]
function player:getPengs()
    return self._pengs
end

---直杠数据
---@return mjCard[]
function player:getZhiGangs()
    return self._zhigangs
end

---绕杠数据
---@return mjCard[]
function player:getRaoGangs()
    return self._raogangs
end

---暗杠数据
---@return mjCard[]
function player:getAnGangs()
    return self._angangs
end

---点炮数据
---@return mjCard[]
function player:getDianPaos()
    return self._dianpaos
end

---自摸数据
---@return mjCard[]
function player:getZiMos()
    return self._zimos
end

return player