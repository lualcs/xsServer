--[[
    file:gameTable.lua 
    desc:游戏桌子
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local format = string.format
local wsnet = require("api_websocket")
local table = require("extend_table")
local occupy = require("occupy")
local caches = require("caches")
local skynet = require("skynet")
local timer  = require("timer")
local class = require("class")
local senum = require("gameEnum")
---@class gameTable @游戏桌子
local gameTable = class()

---定制规则解码
---@param customs    custom[]       @定制规则
local function customDecode(customs)
    if customs then
        local define = {}
        for _,item in ipairs(customs) do
            define[item.field] = item.value
        end
        return define
    end
end

---构造函数
---@param service       service_table    @桌子服务
---@param gameInfo      gameInfo         @游戏信息
---@param gameCustom    gameCustom       @定制规则
function gameTable:ctor(service,gameInfo,gameCustom)

    ---@type tableCustom
    self._def = customDecode(gameCustom.customs)

    ---@type custom[]                   @定制规则
    self._csm = gameCustom.customs
    ---@type table                      @配置
    self._cfg = require(gameInfo.importDeploy)

    local import = require(gameInfo.importAlgor)
    ---@type gameAlgor                  @算法
    self._gor = import.new(self)

    local import = require(gameInfo.importHelper)
    ---@type gameHelper                 @工具
    self._hlp = import.new(self)

    local import = require(gameInfo.importSystem)
    ---@type gameSystem                 @策略
    self._sys = import.new(self)

    local import = require(gameInfo.importLogic)
    ---@type gameSystem                 @逻辑
    self._lgc = import.new(self)

    local import = require(gameInfo.importType)
    ---@type gameType                   @类型 
    self._tye = import.new(self)

    ---@type occupy                     @占位
    self._ocp = occupy.new(1,gameInfo.maxPlayer)

    ---@type caches                     @缓存
    self._cac = caches.new()

    ---@type timer                      @定时器
    self._tim = timer.new()             

    ---@type service_table              @服务
    self._service = service

    ---@type gameInfo                   @游戏
    self._gameInfo = gameInfo

    ---@type table<userID,gamePlayer>   @玩家
    self._mapPlayer = {nil}

    ---@type table<seatID,gamePlayer>   @玩家
    self._arrPlayer = {nil}
    ---@type table<senum,any>           @数据
    self._mapDriver = {nil}
    ---@type historID                   @大局ID
    self._historID  = gameCustom.historID
    ---@type combatID                   @小局战绩
    self._combatID  = 0
    ---@type senum                      @游戏状态
    self._gmstatus  = nil
end

---重启
function gameTable:dataReboot()
    self._gor:dataReboot()   --算法
    self._hlp:dataReboot()   --工具
    self._sys:dataReboot()   --策略
    self._ocp:dataReboot()   --占位
    self._cac:dataReboot()   --缓存
    self._tye:dataReboot()   --类型
    ---清空玩家
    for _,player in ipairs(self._mapPlayer) do
        player:dataReboot()
    end

    ---初始玩家
    local senum = senum.join()
    for _,player in ipairs(self._arrPlayer) do
        ---参与状态
        player:setStatusBy(senum,true)
    end

    ---@type gamePlayer       @当前玩家
    self._player    = nil
    ---@type combatID         @小局战绩
    self._combatID  = self._combatID + 1
end

---大局
function gameTable:getHistorID()
    return self._historID
end

---小局
function gameTable:getCombatID()
    return self._combatID
end

---状态 
function gameTable:getGameStatus()
    return self._gmstatus
end

---状态
---@param status number @状态
function gameTable:setGameStatus(status)
    self._gmstatus = status
end

---定制规则
---@return gameCustom
function gameTable:getGameCustom()
    return self._def
end

---定制规则
---@return custom[]
function gameTable:getListCustom()
    return self._csm
end

---游戏算法
---@return gameAlgor
function gameTable:getGameAlgor()
    return self._gor
end

---游戏辅助
---@return gameHelper
function gameTable:getGameHelper()
    return self._hlp
end

---游戏智能
---@return gameSystem
function gameTable:getGameSystem()
    return self._sys
end

---游戏信息
---@return gameInfo
function gameTable:getGameInfo()
    return self._gameInfo
end

---游戏配置 
---@return table
function gameTable:getGameConf()
    return self._cfg
end

---获取当前玩家
---@return gamePlayer
function gameTable:getCurPlayer()
    return self._player
end

---设置当前玩家
---@param player gamePlayer
function gameTable:setCurPlayer(player)
    self._player = player
end

---桌子占位
---@return occupy
function gameTable:getOccpyObj()
    return self._ocp
end

---玩家映射
---@return table<userID,gamePlayer>
function gameTable:getMapPlayer()
    return self._mapPlayer
end

---玩家数组
---@return table<seatID,gamePlayer>
function gameTable:getArrPlayer()
    return self._arrPlayer
end

---最多人数
---@return count
function gameTable:getMaxPlayer()
    local info = self:getGameInfo()
    return info.maxPlayer
end

---最少人数
---@return count
function gameTable:getMinPlayer()
    local info = self:getGameInfo()
    return info.minPlayer
end

---玩家导入
---@return path
function gameTable:getImportPlayer()
    local info = self:getGameInfo()
    return info.importPlayer 
end

---保存数据
---@param senum senum @映射值
---@param data  any   @数据值
function gameTable:setDriver(senum,data)
    self._mapDriver[senum] = data
end

---获取数据
---@return any
function gameTable:getDriver(senum)
    return self._mapDriver[senum]
end


---玩家进入
---@param playerInfo playerInfo @玩家信息
function gameTable:playerEnter(playerInfo)

    --人数检查
    local occpyobj = self:getOccpyObj()
    if occpyobj:fetch() then
        return false,"爆满了"
    end

    --玩家座位
    playerInfo.seatID = occpyobj:read()

    --玩家实例
    local import = self:getImportPlayer()
    local protot = require(import)
    local newobj = protot.new(self,playerInfo)

    --玩家保存
    local map = self:getMapPlayer()
    map[playerInfo.userID] = newobj

    local lis = self:getArrPlayer()
    lis[playerInfo.seatID] = newobj

end

---玩家退出
function gameTable:playerQuit()
end

---剔除玩家
function gameTable:playerKickout()
end

---清空玩家
function gameTable:playerClear()
end

---桌子解散
function gameTable:gameDelete()
end

---游戏开始
function gameTable:gameStart()
    ---数据重置
    self:dataReboot()
    ---初始缓存
    self:cacheStart()
    ---启动定时
    self:startTimer()
end

---缓存开始
function gameTable:cacheStart()
    local players = {nil}
    for _,player in pairs(self._arrPlayer) do
        table.insert(players,{
            usid = player:getUserID(),      --用户
            name = player:getName(),        --名字
            logo = player:getLogo(),        --头像
            coin = player:getCoin(),        --金币
            seat = player:getSeatID(),      --位置
        })
    end

    self._cac:dataPush({
        historID    = self:getHistorID(),   --唯一凭证
        combatID    = self:getCombatID(),   --战绩凭证
        players     = players,              --玩家信息
    })
end


---启动定时
function gameTable:startTimer()
    self._tim:poling()
end

---游戏结束
function gameTable:gameClose()
end

---请求
---@param player        gamePlayer      @玩家
---@param msg           messabeBody     @消息
---@return boolean,string|any
function gameTable:request(player,msg)
    self:setCurPlayer(player)
    local cmd = table.last(msg.cmds)
end

---通知客户端-服务-私有的
---@param fd      number        @服务地址
---@param name    string        @服务地址
---@param cmd     senum         @消息命令
---@param data    messabeBody   @游戏数据
local function ntfMsgToClient(fd,name,cmd,data)
    local cmds = {senum.table(),cmd}
    wsnet.sendpbc(fd,name or "msgBody",cmds,data)
end

---通知客户端-玩家
---@param player gamePlayer     @游戏玩家
---@param name    string        @服务地址
---@param cmd     senum         @消息命令
---@param data   messabeBody    @游戏数据
function gameTable:ntfMsgToPlayer(player,name,cmd,data)
    ntfMsgToClient(player:fd(),name,cmd,data)
    --缓存消息
    self._cac:dataPush(data)
end


local copy1 = {nil}
---通知客户端-广播
---@param name    string        @服务地址
---@param cmd     senum         @消息命令
---@param data   messabeBody             @游戏数据
---@param sees   message_see_info        @可见信息
function gameTable:ntfMsgToTable(name,cmd,data,sees)
    ---@type table<any,any>    @备份数据
    local back = table.clear(copy1)
    if sees then
        for _,field in ipairs(sees.fields) do
            back[field] = table.delete(data,field)
        end
    end

    --通知旁观玩家
    for _,player in ipairs(self._mapPlayer) do
        if not sees then
            ntfMsgToClient(player:fd(),name,cmd,data)
        else
            local seat = player:getSeatID()
            if not table.exist(sees.chairs,seat) then
                ntfMsgToClient(player:fd(),name,cmd,data)
            end
        end
    end

    --通知知权玩家
    if sees then
        for _,field in ipairs(sees.fields) do
            data[field] = back[field]
        end
        for seat,_ in ipairs(sees.chairs) do
            --通知数据
            local player = self._arrPlayer[seat]
            ntfMsgToClient(player:fd(),name,cmd,data)
        end
    end
    --缓存消息
    self._cac:dataPush(data)
end

return gameTable