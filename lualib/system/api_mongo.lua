--[[
    file:api_mongo.lua 
    desc:mongo 使用
    auth:Carol Luo
]]

local table = table
local class = require("class")
local mongo = require("skynet.db.mongo")
local bson = require("bson")

---@class api_mongo
local api_mongo = class()
local this = api_mongo

---构造函数
---@param info mongo_connect_info @连接信息
function api_mongo:ctor(info)
    ---@type mongo_connect_info
    self._info = info
end

---连接请求
function api_mongo:connect()
    self._db = mongo.client(self._info)
end

---断开连接
function api_mongo:disconnect()
    self._db:disconnect()
end


---插入数据
---@param dbname        name @库名
---@param collection    name @集合
---@param doc           any  @数据
function api_mongo:insert(dbname,collection,doc)
    local db = self._db:getDB(dbname)
    local cl = db:getCollection(collection)
    cl:insert(doc)
end

---插入数据-批量
---@param dbname        name    @库名
---@param collection    name    @集合
---@param docs          any[]   @数据
function api_mongo:bach_insert(dbname,collection,docs)
    local db = self._db:getDB(dbname)
    local cl = db:getCollection(collection)
    cl:bach_insert(docs)
end

---删除数据
---@param dbname        name    @库名
---@param collection    name    @集合
---@param selector      xxxx    @筛选
---@param single        xxxx    @单一
function api_mongo:delete(dbname,collection,selector, single)
    local db = self._db:getDB(dbname)
    local cl = db:getCollection(collection)
    cl:delete(selector, single)
end

---删除集合
---@param dbname        name    @库名
---@param collection    name    @集合
---@param selector      xxxx
---@param single        xxxx
function api_mongo:drop(dbname,collection)
    local db = self._db:getDB(dbname)
    return db:runCommand("drop",collection)
end

---查询单个
---@param dbname        name    @库名
---@param collection    name    @集合
---@param query         table   @查询
---@param selector      table   @筛选
function api_mongo:findOne(dbname,collection,query,selector)
    local db = self._db:getDB(dbname)
    local cl = db:getCollection(collection)
    return cl:findOne(query,selector)
end

---查询多个
---@param dbname        name    @库名
---@param collection    name    @集合
---@param query         table   @查询
---@param selector      table   @筛选
---@param skip          number  @跳过
---@param limit         number  @限制
function api_mongo:findAll(dbname,collection,query,selector,skip,limit)
    local db = self._db:getDB(dbname)
    local cl = db:getCollection(collection)
    local result = {}

    --游标
    local cursor = cl:find(query,selector)

    --跳过
    if skip then
        cursor:skip(skip)
    end

    --限制
    if limit then
        cursor:limit(limit)
    end

    --循环
    while cursor:hasNext() do
        local document = cursor:next()
        table.insert(result,document)
    end

    --关闭
    cursor:close()

    return result
end


---数据更新
---@param dbname        name        @库名
---@param collection    name        @集合
---@param selector      name        @筛选
---@param update        name        @数据-需要更新的字段和内容
---@param upsert        boolean     @true-不存在则新增加
---@param multi         boolean     @true_表示多行更新 false-表示只会更新符合条件的一条记录
function api_mongo:update(dbname,collection,selector,update,upsert,multi)
    local db = self._db:getDB(dbname)
    local cl = db:getCollection(collection)
    cl:update(selector,update,upsert,multi)
end

---扩展接口
function api_mongo:runCommand(args)
    local db = self._db:getDB(args.dbname)
    return db:runCommand(args)
end

---bson解码
function api_mongo:bson_decode(arg)
    return bson.decode(arg)
end

---bson编码
function api_mongo:bson_encode_order(arg)
    return bson.encode_order(arg)
end

---bson编码
function api_mongo:bson_encode(arg)
    return bson.encode(arg)
end

---objectid to string
---@param objectId blob @二进制
---@return string
function api_mongo:objectidToString(objectId)
    local _,objectId = bson.type(objectId)
    return objectId
end

---objectid to string
---@param objectId string @二进制
---@return blob
function api_mongo:objectidToBlob(objectId)
    return bson.objectid(objectId)
end

return api_mongo

---@class mongo_connect_item @mongo 连接信息
---@field host              host       @目标地址
---@field port              port       @目标端口
---@field username          name       @用户名字
---@field password          password   @用户密码
---@field authmod           string     @
---@field authdb            string     @

---@class mongo_connect_info @mongo 连接信息
---@field rs                mongo_connect_item[]   @连接信息
---@field overload          xxx
---@field dbname            name                    @db名字