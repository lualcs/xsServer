--[[
    file:gamePlayer.lua 
    desc:游戏玩家
    auth:Caorl Luo
]]

local tostring = tostring
local format = string.format
local debug = require("extend_debug")
local table = require("extend_table")
local class = require("class")
---@type gameEnum
local senum = require("gameEnum")

---@class gamePlayer
local gamePlayer = class()
local this = gamePlayer

---构造函数
---@param table      gameTable  @游戏桌子
---@param playerInfo playerInfo @玩家信息
function gamePlayer:ctor(table,playerInfo)
    ---游戏桌子
    ---@type gameTable              
    self._table = table
    ---玩家信息
    ---@type playerInfo             
    self._player = playerInfo
    ---请求列表
    ---@type senum[]                
    self._queues = {nil}
    ---请求映射
    ---@type table<senum,boolean>   
    self._mapues = {nil}
    ---标记映射
    ---@type table<senum,boolean>   
    self._mapsig = {nil}
    ---数据映射
    ---@type table<senum,any>  
    self._mapDriver = {nil}
    ---闲家身份
    self._camp = senum.player()
end

---重启
function gamePlayer:dataReboot()
    ---游戏算法
    ---@type gameAlgor
    self._gor = self._table._gor
    ---游戏策略
    ---@type gameSystem
    self._sys = self._table._sys
    ---类型判断
    ---@type gameType
    self._tye = self._table._tye
    ---游戏辅助
    ---@type gameHelper
    self._hlp = self._table._hlp
    ---游戏逻辑
    ---@type gameLogic
    self._lgc = self._table._lgc
    ---游戏请求
    ---@type msgBody
    self._request = nil
    table.clear(self._queues)
    table.clear(self._mapues)
    table.clear(self._mapsig)
end

---地址
---@return socket
function gamePlayer:fd()
    return self._player.fd
end

---名字
---@return name
function gamePlayer:getName()
    return self._player.name
end

---头像
---@return url
function gamePlayer:getLogo()
    return self._player.logo
end

---角色
---@return userID
function gamePlayer:getUserID()
    return self._player.userID
end

---获取阵营
---@return senum
function gamePlayer:getCamp()
    return self._camp
end

---设置阵营
---@param  camp senum @阵营 
---@return senum
function gamePlayer:setCamp(camp)
    self._camp = camp
end

---位置
---@return seatID
function gamePlayer:getSeatID()
    return self._player.seatID
end

---获取金币
---@return score
function gamePlayer:getCoin()
    return self._player.coin
end

---设置金币
---@param coin score
function gamePlayer:setCoin(coin)
    self._player.coin = coin
end

---改变金币
---@param change score @变动
function gamePlayer:addCoin(change)
    local coin = self:getCoin()
    self:setCoin(coin+change)
end

---使用金币
---@param change score @变动
function gamePlayer:usageCoin(change)
    local coin = self:getCoin()
    if coin + change < 0 then
        return false
    end
    self:addCoin(change)
    return true
end

---获取请求
---@return messageInfo
function gamePlayer:getRequest()
    return self._request
end

---机器
---@return boolean
function gamePlayer:isRobot()
    return self._player.robot
end

---真人
---@return boolean
function gamePlayer:isPlayer()
    return not self:isRobot()
end

---庄家
---@return boolean
function gamePlayer:isBanker()
    return self._camp == senum.banker()
end

---在线
function gamePlayer:isOnline()
    return senum.online() == self._player.line
end

---离线
function gamePlayer:isOffline()
    return senum.offline() == self._player.line
end

---命令
---@param cmd senum
---@return boolean
function gamePlayer:isExistBy(cmd)
    return self._mapues[cmd]
end

---离线
function gamePlayer:offline()
    self._player.line = senum.offline()
end

---上线
function gamePlayer:online()
    self._player.line = senum.online()
end

---获取标记
---@param senum senum @标记 
---@return boolean
function gamePlayer:getStatusBy(senum)
    return self._mapsig[senum]
end

---获取标记
---@param senum senum       @标记 
---@param sign  boolean     @标记
function gamePlayer:setStatusBy(senum,sign)
    self._mapsig[senum] = sign
end

---保存数据
---@param senum senum @映射值
---@param data  any   @数据值
function gamePlayer:setDriver(senum,data)
    self._mapDriver[senum] = data
end

---获取数据
---@return any
function gamePlayer:getDriver(senum)
    return self._mapDriver[senum]
end

---玩家
---@param msg messageInfo @数据
function gamePlayer:message(msg)
    self._request = msg
    --转到游戏
    local ok,error = self._table:message(self,msg)
    local cmd = table.last(msg.cmds)
    if ok then
        self._mapues[cmd] = true
        table.insert(self._queues,cmd)
    else
        local info = self._table:getGameInfo()
        local name = info.name
        local a,b,c = tostring(name),tostring(cmd),tostring(error)
        debug.error(format("%s:%s:%s:error",a,b,c))
        debug.error(debug.traceback())
    end
    return ok,error
end

return gamePlayer