--[[
    file:assignSuper.lua
    desc:调配基类
    auth:Caorl Luo
]]

local skynet = require("skynet")

local tostring = tostring
local format = string.format
local debug = require("extend_debug")
local gameEnum = require("gameEnum")
local gameInfos = require("games.gameInfos")
local class = require("class")

---@class assignSuper @游戏调配基类
local assignSuper = class()
local this = assignSuper

---构造函数
---@param service service_assign
function assignSuper:ctor(service)
    ---@type service_assign @分配服务
    self._service = service
    ---@type mapping_tables @桌子隐射
    self._tables = {nil}
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

---创建桌子
---@param gameID        gameID      @游戏ID
---@param gameCustom    gameCustom  @房间定制
function assignSuper:createTable(gameID,gameCustom)
    local gameInfo = gameInfos[gameID]
    --检查数据
    if not gameInfo then
        debug.error(format("assign:%s gameID:%s 1 ",self:assignClass(),tostring(gameID)))
        skynet.retpack(false)
        return
    end
    --检查类型
    if self:assignClass() ~= gameInfo.assignClass then
        debug.error(format("assign:%s gameID:%s belong:%s 2 ",self:assignClass(),tostring(gameID),gameInfo.assignClass))
        skynet.retpack(false)
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
    skynet.retpack(true)
end

---删除桌子
function assignSuper:deleteTable()
end

return assignSuper