--[[
    file:mongomanager.lua 
    desc:mysql处理
    auth:Caorl Luo
]]

local ipairs = ipairs
local format = string.format
local string = require("extend_string")
local table = require("extend_table")
local debug = require("extend_debug")
local skynet = require("skynet")
local class = require("class")
local senum = require("managerEnum")
local mongo = require("api_mongo")
local timer = require("timer")
local listen = require("listener.mapServers")

---@class mongomanager @gate管理
local mongomanager = class()
local this = mongomanager

---构造
---@param service service_mongo         @gate服务
function mongomanager:ctor(service)
    ---mongo服务
    ---@type service_mongo
    self._service = service

    ---@type api_mongo
    self._mongo = mongo.new({
       rs = listen.mongo
    })

    ---启动连接
    self._mongo:connect()
    ---启动定时器
    self._timer = timer.new()
end

---重置
function mongomanager:dataReboot()
    ---构造结构
    self:dbstructure()
    self:loadingEmail(nil,1,100)
end

---服务
---@return serviceInf @服务信息
function mongomanager:getServices()
    return self._service._services
end


---构造数据库
function mongomanager:dbstructure()
    local mongo = self._mongo
    ---错误信息数据
    local db = mongo._db.databaseError
    ---错误信息集合
    self._errorDetails =  db._errorDetails
    ---错误信息数据
    local db = mongo._db.databaseLog
    ---错误信息集合
    self._logDetails =  db._logDetails
    ---玩家邮件数据
    local db = mongo._db.databaseEmail
    ---用户未读邮件
    self._emaliVisibles = db.emaliVisibles
    ---用户删除邮件
    self._emaliRubbish = db.emaliRubbish
    ---金玉满堂数据
    local db = mongo._db.databaseSlots
    ---金玉满堂日志
    self._jymtDetails = db.jymtDetails
end

---写入错误编码记录
---@param code integer @错误编码
---@param trac string  @跟踪信息
function mongomanager:writeError(code,trac)
    local coll = self._errorDetails
    coll:safe_insert({
        code = code,
        trac = trac
    })
end

---写入日志
---@param text string @跟踪信息
function mongomanager:writeLog(name,text)
    local coll = self._logDetails
    coll:safe_insert({
        name = name,
        text = text,
    })
end

---写入错误编码记录
---@param code integer @错误编码
---@param trac integer @跟踪信息
function mongomanager:writeError(code,trac)
    local coll = self._errorDetails
    coll:safe_insert({
        code = code,
        trac = trac
    })
end

---写入玩家邮件数据
---@param rid       userID @角色
---@param email     email  @邮件
function mongomanager:writeEmail(rid,email)
    local coll = self._emaliVisibles
    coll:safe_insert({
        rid = rid,
        email = email
    })
end

---写入玩家邮件数据
---@param rids       userID[] @角色
---@param emails     email[]  @邮件
function mongomanager:writeEmails(rids,emails)
    for index,rid in ipairs(rids) do
        self:writeEmail(rid,emails[index])
    end
end
---加载玩家邮件数据
---@field rid   userID  @角色
---@field page  count   @页号
---@field limit count   @数量
function mongomanager:loadingEmail(rid,page,limit)
    local coll = self._emaliVisibles
    local skip = (page - 1) * limit
    local quer = coll:find({rid = rid}):sort({_id=1}):limit(limit):skip(skip)
    local list = {nil}
    while quer:hasNext() do
        ---@type mongoEmail
        local mgEmail = quer:next()
        
        mgEmail._id = mongo:objectidToString(mgEmail._id)
        table.insert(list,mgEmail)
    end
    return list
end

local copy1 = {nil}
---加载玩家邮件数据
---@field objectId      string  @唯一标准
---@return mongoEmail   @邮件数据
function mongomanager:loadingEmailBy(objectId)
    local coll = self._emaliVisibles
    local find = table.clear(copy1)
    find._id = mongo.objectidToBlob(objectId)
    local quer = coll:find(find)
    return quer:next()
end

---读取玩家邮件数据
---@field objectId  string 唯一标志
function mongomanager:readEmail(objectId)
    local coll = self._emaliVisibles
    coll:safe_update(
        format([["_id":"%d"]],objectId),
        {
            ["$set"] = {
                read = true
            }
        })
end

---读取玩家邮件数据
---@field objectIds  string[] 唯一标志
function mongomanager:readEmails(objectIds)
    for _,objectId in ipairs(objectIds) do
        self:readEmail(objectId)
    end
end

local copy1 = {nil}
---删除玩家邮件数据
---@field objectId  string  @唯一标识
function mongomanager:earseEmail(objectId)
    ---查询邮件
    local mongoEmail = self:loadingEmailBy(objectId)
    ---删除邮件
    local coll = self._emaliVisibles
    local dele = table.clear(copy1)
    dele._id = objectId
    coll:safe_delete(dele)
    ---回收邮站
    local coll = self._emaliRubbish
    coll:safe_insert(mongoEmail)
end

---删除玩家邮件数据
---@field objectIds  string[]  @唯一标识
function mongomanager:earseEmails(objectIds)
    for _,objectId in ipairs(objectIds) do
        self:earseEmail(objectId)
    end
end

---写入金玉满堂日志
function mongomanager:slotsDetailsJYMT(details)
    local coll = self._jymtDetails
    coll:safe_insert(details)
end


return mongomanager