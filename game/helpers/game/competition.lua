--[[
    file:game.competition.lua 
    desc:游戏桌子
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local format = string.format
local table = require("extend_table")
local time = require("extend_time")
local math = require("extend_math")
local debug = require("extend_debug")
local occupy = require("occupy")
local caches = require("caches")
local skynet = require("skynet")
local timer  = require("timer")
local class = require("class")
local ICode = require("ICode")
local senum = require("game.enum")
local mongo = require("game.mongo")
local mysql = require("game.mysql")
---@class gameCompetition @游戏桌子
local competition = class()

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
function competition:ctor(service,gameInfo,gameCustom)
    local services = service._services
    ---代码编号
    self._code = ICode.new(gameInfo.gameID + 10000,services.mongo)
    ---游戏规则
    ---@type table<string,any>
    self._def = customDecode(gameCustom.customs)
    ---定制规则
    ---@type custom[]                   
    self._csm = gameCustom.customs
     ---消息处理
    ---@type gameMessage
    self._msg = require(gameInfo.importMessage)    
    ---错误编号
    ---@type gameError
    self._err = require(gameInfo.importError)      
    ---游戏配置
    ---@type table                     
    self._cfg = require(gameInfo.importDeploy)
    local import = require(gameInfo.importAlgor)
    ---游戏算法
    ---@type gameAlgor                  
    self._gor = import.new(self)
    local import = require(gameInfo.importHelper)
    ---游戏辅助
    ---@type gameHelper                 
    self._hlp = import.new(self)
    local import = require(gameInfo.importSystem)
    ---游戏策略
    ---@type gameSystem                 
    self._sys = import.new(self)
    local import = require(gameInfo.importLogic)
    ---游戏逻辑
    ---@type gameLogic                 
    self._lgc = import.new(self)
    local import = require(gameInfo.importType)
    ---类型判断
    ---@type gameType                    
    self._tye = import.new(self)
    local import = require(gameInfo.importStatus)
    ---游戏状态
    ---@type gameStatus                 
    self._stu = import.new(self)
    ---游戏占位
    ---@type occupy                    
    self._ocp = occupy.new(1,gameInfo.maxPlayer)
    ---游戏缓存
    ---@type caches                     
    self._cac = caches.new()
    --游戏定时
    ---@type timer                      
    self._tim = timer.new()  
    ---mongo 
    ---@type competitionMongo
    self._mgo = mongo.new(services.mongo)   
    ---mysql 
    ---@type competitionMongo
    self._sql = mongo.new(services.mysql)      
    --桌子服务
    ---@type service_table              
    self._service = service
    ---游戏信息
    ---@type gameInfo                   
    self._gameInfo = gameInfo
    ---玩家映射
    ---@type table<userID,gamePlayer>
    self._mapPlayer = {nil}
    ---玩家数组
    ---@type table<seatID,gamePlayer>
    self._arrPlayer = {nil}
    ---保持数据
    ---@type table<senum,any>
    self._mapData   = {nil}
    ---战局标识
    ---@type historID 
    self._historID  = gameCustom.historID
    ---小局标识
    ---@type combatID                  
    self._combatID  = 0
    ---游戏状态
    ---@type senum                     
    self._gmstatus  = nil
    ---机器配置
    ---@type robotEnter
    local cfg = require("sundry.robot")
    local rbt = cfg[gameInfo.gameID]
    self._gmrobots  = rbt

    if rbt then
        ---首次执行
        self.lcsTimerID = self._tim:appendCall(5*1000,function()
            self:refershRobotHotspot()
        end)
        ---重置热度
        self._tim:appendEver(rbt.hotspot.opportunity,function()
            self:refershRobotHotspot()
        end)
        ---机器入场
        self._tim:appendEver(rbt.enter.opportunity,function()
            self:refershRobotEnter()
        end)
    end

    ---真人玩家数据
    ---@type count
    self._realCount = 0
    ---机器玩家数据
    ---@type count
    self._robotCount = 0

end


---重置数据
function competition:dataReboot()
    self._gor:dataReboot()   --算法
    self._hlp:dataReboot()   --工具
    self._sys:dataReboot()   --策略
    self._ocp:dataReboot()   --占位
    self._cac:dataReboot()   --缓存
    self._tye:dataReboot()   --类型
    self._stu:dataReboot()   --状态
end

---清除数据
function competition:dateClear()

    self._gor:dateClear()   --算法
    self._hlp:dateClear()   --工具
    self._sys:dateClear()   --策略
    self._ocp:dateClear()   --占位
    self._cac:dateClear()   --缓存
    self._tye:dateClear()   --类型
    self._stu:dateClear()   --状态

     ---清空玩家
     for _,player in ipairs(self._mapPlayer) do
        player:dateClear()
    end

    ---初始玩家
    local senum = senum.join()
    for _,player in ipairs(self._arrPlayer) do
        ---参与状态
        player:setStatusBy(senum,true)
    end

    ---数据映射
    ---@type table<senum,any>  
    self._mapDriver = {nil}

    ---@type gamePlayer       @当前玩家
    self._player    = nil
    ---@type combatID         @小局战绩
    self._combatID  = self._combatID + 1
end

---服务
---@return serviceInf @服务信息
function competition:getServices()
    return self._service._services
end

---分配
---@return service
function competition:getAssignID()
    return self._service._assign
end

---刷新热度
function competition:refershRobotHotspot()
    local hotspot =  self._gmrobots.hotspot
    local week    =  time.todayWeekID()
    local hour    =  time.hour()
    local hotLeve =  hotspot.seasonDate[week][hour]
    local hotWgts =  hotspot.seasonLists[hotLeve]
    local hotRand =  math.random(1,10000)
    for _,wgts in ipairs(hotWgts.lis) do
        hotRand = hotRand - wgts.weight
        if hotRand <= 0 then
            self._robotTarget = math.random(wgts.min,wgts.max)
        end
    end
end

---机器入场
function competition:refershRobotEnter()

    ---邀请机器人目标
    local target = self._robotTarget
    if not target then
        return
    end

    for _,player in ipairs(self._arrPlayer) do
        if player:ifRobot() then
            target = target - 1
        end
    end

    local services = self:getServices()

    ---邀请机器人
    if target > 0 then
        local assign = self._service._assign
        skynet.send(services.robot,"lua","inviteEnter",assign,skynet.self())
    end

end

---大局
function competition:getHistorID()
    return self._historID
end

---小局
function competition:getCombatID()
    return self._combatID
end

---状态 
function competition:getGameStatus()
    return self._gmstatus
end

---状态
---@param status number @状态
function competition:setGameStatus(status)
    self._gmstatus = status
end

---定制规则
---@return gameCustom
function competition:getGameCustom()
    return self._def
end

---定制规则
---@return custom[]
function competition:getListCustom()
    return self._csm
end

---游戏算法
---@return gameAlgor
function competition:getGameAlgor()
    return self._gor
end

---游戏辅助
---@return gameHelper
function competition:getGameHelper()
    return self._hlp
end

---游戏智能
---@return gameSystem
function competition:getGameSystem()
    return self._sys
end

---游戏信息
---@return gameInfo
function competition:getGameInfo()
    return self._gameInfo
end

---游戏配置 
---@return table
function competition:getGameConf()
    return self._cfg
end

---机器配置
---@return robotEnter
function competition:gaetRobotCfg()
    return self._gmrobots
end

---获取当前玩家
---@return gamePlayer
function competition:getCurPlayer()
    return self._player
end

---设置当前玩家
---@param player gamePlayer
function competition:setCurPlayer(player)
    self._player = player
end

---桌子占位
---@return occupy
function competition:getOccpyObj()
    return self._ocp
end

---玩家映射
---@return table<userID,gamePlayer>
function competition:getMapPlayer()
    return self._mapPlayer
end

---玩家数组
---@return table<seatID,gamePlayer>
function competition:getArrPlayer()
    return self._arrPlayer
end

---最多人数
---@return count
function competition:getMaxPlayer()
    local info = self:getGameInfo()
    return info.maxPlayer
end

---最少人数
---@return count
function competition:getMinPlayer()
    local info = self:getGameInfo()
    return info.minPlayer
end

---玩家人数
---@return count
function competition:getNumPlayer()
    return self._ocp.count()
end

---玩家导入
---@return path
function competition:getImportPlayer()
    local info = self:getGameInfo()
    return info.importPlayer 
end

---保存数据
---@param senum senum @映射值
---@param data  any   @数据值
function competition:setDriver(senum,data)
    self._mapDriver[senum] = data
end

---获取数据
---@return any
function competition:getDriver(senum)
    return self._mapDriver[senum]
end

---保存数据
---@param senum senum @映射值
---@param data  any   @数据值
function competition:setData(senum,data)
    self._mapData[senum] = data
end

---获取数据
---@return any
function competition:getData(senum)
    return self._mapData[senum]
end

---游戏单元
---@return score
function competition:getUnit()
    return self._def[senum.unit()]
end

---断线
---@param rid userID @套接字
function competition:offline(rid)
    local player = self._mapPlayer[rid]
    player:online()
end

---玩家进入
---@param playerInfo playerInfo @玩家信息
function competition:playerEnter(playerInfo)

    --人数检查
    local occpyobj = self:getOccpyObj()
    if not occpyobj:fetch() then
        return false,"爆满了"
    end

    --玩家座位
    playerInfo.seatID = occpyobj:read()
    --玩家实例
    local import = self:getImportPlayer()
    local object = require(import)
    local player = object.new(self,playerInfo)
    player:dataReboot()

    --玩家保存
    local map = self:getMapPlayer()
    map[playerInfo.userID] = player

    local lis = self:getArrPlayer()
    lis[playerInfo.seatID] = player

    ---数量统计
    if player:ifRobot() then
        self._robotCount = self._robotCount + 1
    else
        self._realCount = self._realCount + 1
    end

    ---通知分配
    local handle = self:getAssignID()
    local origin = skynet.self()
    skynet.send(handle,"lua","liveTable",playerInfo.userID,origin)
end

---玩家退出
---@param player gamePlayer @游戏玩家
function competition:playerLeave(player)
    ---数量统计
    if player:ifRobot() then
        self._robotCount = self._robotCount - 1
    else
        self._realCount = self._realCount - 1
    end
end

---剔除玩家
function competition:playerKickout()
end

---清空玩家
function competition:playerClear()
end

---桌子解散
function competition:gameDelete()
end

---检查开始
---@return boolean
function competition:checkStart()

    --检查状态
    if not self._stu:IfIdle() then
        return false
    end

    ---玩家人数
    local playerNum = self:getNumPlayer()
    if playerNum <= 0 then
        return false
    end

    local inf = self:getGameInfo()
    local opt = inf.open

    ---人数
    if opt == senum.people() then
        ---检查人数
        local mcnt = inf.minPlayer
        if mcnt <= playerNum then
            return false
        end

        return true
    ---准备
    elseif opt == senum.ready() then

        ---检查状态
        local lis = self._arrPlayer
        local sts = senum.ready()

        ---准备人数
        local cnt = 0
        for _,player in pairs(lis) do
            if not player:getStatusBy(sts) then
                return false
            end
        end

        return true
    end

    return false
end

---游戏开始
function competition:gameStart()
    ---初始缓存
    self:cacheStart()
end

---缓存开始
function competition:cacheStart()
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
        historID    = self:getHistorID(),   --战局凭证
        combatID    = self:getCombatID(),   --小局序号
        players     = players,              --玩家信息
    })
end

return competition