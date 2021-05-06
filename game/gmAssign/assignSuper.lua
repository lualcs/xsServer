--[[
    file:assignSuper.lua
    desc:调配基类
    auth:Caorl Luo
]]

local pairs = pairs
local ipairs = ipairs
local tostring = tostring
local skynet = require("skynet")
local table = require("extend_table")
local format = string.format
local class = require("class")
local debug = require("extend_debug")
local timer = require("timer")
local senum = require("gameEnum")
local gameInfos = require("games.gameInfos")
local tableDeploy = require("sundry.table")

---@class assignSuper @游戏调配基类
local assignSuper = class()
local this = assignSuper

---构造函数
---@param service service_assign
function assignSuper:ctor(service)
    ---分配服务
    ---@type service_assign @分配服务
    self._service = service
    ---桌子列表
    ---@type mapping_tables @桌子隐射
    self._tables = {nil}
    ---定时器
    ---@type timer @定时器
    self._timer = timer.new()
    self._timer:dataReboot()
    self._timer:poling()
end

---重置
function assignSuper:dataReboot()
    ---巡查桌子
    self:inspectTable()
end

---断线
---@param rid userID @套接字
function assignSuper:offline(rid)
end

---服务
---@return serviceInf @服务信息
function assignSuper:getServices()
    return self._service.services
end

---分配类型
---@return senum
function assignSuper:assignClass()
    return self._assignClass
end

---服务查询
function assignSuper:serviceTable(tableID)
    return self._tables[tableID]
end

---巡查桌子
function assignSuper:inspectTable()
    ---桌子管理
    ---@type senum
    local assign = self:assignClass()
    ---@type tableManagerUnit[]
    local cfgs = tableDeploy[assign]
    for gameID,game in pairs(gameInfos) do

        ---过滤未开启游戏
        if not game.open then
            goto continue
        end

        ---过滤分配游戏
        if assign ~= game.assignClass then
            goto continue
        end

        ---创建游戏桌子
        for _,mgr in ipairs(cfgs) do
            for i = 1,mgr.mini do
                self:createTable(gameID,{
                    custom = {
                        {---单元分数
                            field = senum.unit(),
                            value = mgr.unit
                        },
                    }
                })
            end
        end

        ::continue::
    end
end

---创建桌子
---@param gameID        gameID      @游戏ID
---@param gameCustom    gameCustom  @房间定制
function assignSuper:createTable(gameID,gameCustom)
    
    local gameInfo = gameInfos[gameID]
    debug.logAssignhSuper(gameInfo.name)
    --检查数据
    if not gameInfo then
        debug.error(format("[%s] [gameID:%s] 1",self:assignClass(),tostring(gameID)))
        return
    end
    --检查类型
    if self:assignClass() ~= gameInfo.assignClass then
        debug.error(format("[%s] [gameID:%s] 2",self:assignClass(),tostring(gameID)))
        return
    end
    --桌子ID
    local address  = skynet.queryservice("service_sole")
    local tableID  = skynet.call(address,"lua","getTableID")
    local historID = skynet.call(address,"lua","getHistorID")
    gameCustom.historID = historID
    --桌子服务
    local service = skynet.newservice("service_table")
    skynet.call(service,"lua","start",gameID,gameCustom)

    --桌子服务
    self._tables[tableID] = service
end

---删除桌子
function assignSuper:deleteTable()
end

---请求
---@param fd  socket      @套接字
---@param msg messageInfo @数据
function assignSuper:message(fd,msg)
    local cmd = table.remove(msg.cmds)
    local inf = msg.info
    ---进桌
    if cmd == senum.enter() then
    ---离卓
    elseif cmd == senum.leave() then
    end
end

return assignSuper