local mongo = require "skynet.db.mongo"
local json = require "cjson"
local bson = require "bson"
local fastTable = require "fast.table"
local fastClass = require "fast.class"
local fastOutput = require "fast.output"
local public = fastClass.create()

---新建数据库连接
---@param ip string IP地址
---@param port number 端口
---@param db string 数据库
---@return table
function public:ctor(host, port, dbname, ...)
    self.host = host

    self.port = math.tointeger(port or 27017)

    self.dbname = dbname

    local client

    if (host ~= nil and #host > 0) then
        client =
            mongo.client(
            {
                host = host,
                port = math.tointeger(port or 27017)
            }
        )
    end

    self.client = client

    if (client ~= nil and dbname ~= nil) then
        self.db = client:getDB(dbname)
    end
end

---建立连接
---@param cfg table 配置
function public:connection(host, port, ...)
    self.host = host

    self.port = math.tointeger(port or 27017)

    self.client =
        mongo.client(
        {
            host = self.host,
            port = self.port
        }
    )
end

---获取数据库
---@param dbname string 数据库名
function public:database(dbname)
    self.dbname = dbname

    if (self.dbname ~= nil) then
        self.db = self.client:getDB(self.dbname)
    end
end

---进行一个事务
---@param call function 开启事务期间执行的函数
---@return boolean 执行结果
function public:transaction(call)
    local session = self.client

    if (call ~= nil) then
        session:runCommand(
            "startTransaction",
            {
                readConcern = {level = "snapshot"},
                writeConcern = {w = "majority"}
            }
        )

        local status, err = pcall(call)

        if (status) then
            session:runCommand("commitTransaction")
        else
            session:runCommand("abortTransaction")
        end

        return status
    end

    return false
end

---插入记录
---@param args table 参数
------@param collection string 集合
------@param doc table 插入文档
function public:insert(args)
    local db = self.db

    db[args.collection]:insert(args.doc)
end

---安全插入记录
---@param args table 参数
------@param collection string 集合
------@param doc table 插入文档
---@return boolean,string,table 结果
function public:safe_insert(args)
    local db = self.db

    return db[args.collection]:safe_insert(args.doc)
end

---批量插入记录
---@param args table 参数
------@param collection string 集合
------@param docs table 批量文档
---@return boolean,string,table 结果
function public:batch_insert(args)
    local db = self.db

    return db[args.collection]:batch_insert(args.docs)
end

---更新记录
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
------@param update table 待更新数据
------@param upsert boolean  不存在待更新的记录是否插入
------@param multi boolean 是否更新多条记录
function public:update(args)
    local db = self.db

    db[args.collection]:update(args.query, args.update, args.upsert, args.multi)
end

---安全更新记录
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
------@param update table 待更新数据
------@param upsert boolean  不存在待更新的记录是否插入
------@param multi boolean 是否更新多条记录
---@return boolean,string,table 结果
function public:safe_update(args)
    local db = self.db

    return db[args.collection]:safe_update(args.query, args.update, args.upsert, args.multi)
end

---删除记录
---@param args table 参数
------@param collection string 集合
------@param selector table 查询条件
------@param single boolean  是否只删除单条记录
function public:delete(args)
    local db = self.db

    db[args.collection]:delete(args.query, args.single)
end

---安全删除记录
---@param args table 参数
------@param collection string 集合
------@param selector table 查询条件
------@param single boolean  是否只删除单条记录
---@return boolean,string,table 结果
function public:safe_delete(args)
    local db = self.db

    return db[args.collection]:safe_delete(args.query, args.single)
end

---查找多条数据
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
------@param having table 过滤条件
------@param selector table 查询字段
------@param sort table 排序
---@return boolean,string,table 结果
function public:find(args)
    local db = self.db

    local query = args.query or {}

    local having = args.having or {}

    local selector = args.selector or {}

    if (args.aggregate ~= nil) then
        local pipeline = args.aggregate.pipeline or {}

        for i = 1, #pipeline do
            local lookup = pipeline[i]["$lookup"]

            if (lookup ~= nil) then
                if (selector[lookup.as] == nil) then
                    selector[lookup.as] = 1
                end
            end
        end

        pipeline =
            fastTable.merge(
            {
                {
                    ["$match"] = query
                }
            },
            pipeline,
            {
                {
                    ["$match"] = having
                }
            },
            {
                {
                    ["$project"] = selector
                }
            }
        )

        if (args.sort) then
            pipeline =
                fastTable.merge(
                pipeline,
                {
                    {
                        ["$sort"] = args.sort
                    }
                }
            )
        end

        local batch_size = {}

        if (args.limit and args.limit > 0) then
            batch_size = {
                batchSize = args.limit
            }
        end

        local ret = db:runCommand("aggregate", args.collection, "pipeline", pipeline, "cursor", batch_size)

        if (ret.cursor) then
            return transform(ret.cursor.firstBatch)
        end

        return {}
    else
        local ret = db[args.collection]:find(query, selector)

        if (args.sort) then
            ret = ret:sort(args.sort)
        end

        if (args.limit and args.limit > 0) then
            ret = ret:limit(args.limit)
        end

        return cursor(ret)
    end
end

---查找单条数据
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
------@param having table 过滤条件
------@param selector table 查询字段
---@return boolean,string,table 结果
function public:find_one(args)
    local db = self.db

    local query = args.query or {}

    local having = args.having or {}

    local selector = args.selector or {}

    if (args.aggregate ~= nil) then
        local pipeline = args.aggregate.pipeline or {}

        for i = 1, #pipeline do
            local lookup = pipeline[i]["$lookup"]

            if (lookup ~= nil) then
                if (selector[lookup.as] == nil) then
                    selector[lookup.as] = 1
                end
            end
        end

        pipeline =
            fastTable.merge(
            {
                {
                    ["$match"] = query
                }
            },
            pipeline,
            {
                {
                    ["$match"] = having
                }
            },
            {
                {
                    ["$project"] = selector
                }
            }
        )

        local ret = db:runCommand("aggregate", args.collection, "pipeline", pipeline, "cursor", {batchSize = 1})

        if (ret.cursor.firstBatch[1] ~= nil) then
            return transform(ret.cursor.firstBatch[1])
        else
            return nil
        end
    else
        local ret = db[args.collection]:findOne(args.query, args.selector)

        if (ret ~= nil) then
            return transform(ret)
        else
            return ret
        end
    end
end

---分块获取数据
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
------@param having table 过滤条件
------@param selector table 查询字段
------@param sort table 排序
------@param limit number 每页条数
------@param pipeline table 管道
------@param call function 回调
---@return table 结果
function public:chunk(args)
    if (args.call == nil or args.sort == nil) then
        return
    end

    local db = self.db

    local limit = args.limit or 10

    local page = 1

    local query = args.query or {}

    local having = args.having or {}

    local selector = args.selector or {}

    local total = self:count(args)

    local total_page = math.ceil(total / limit)

    local rows = {}

    page = math.max(page, 1)

    if (page > total_page) then
        return
    end

    local skip = (page - 1) * limit

    if (args.aggregate ~= nil) then
        local pipeline = args.aggregate.pipeline or {}

        for i = 1, #pipeline do
            local lookup = pipeline[i]["$lookup"]

            if (lookup ~= nil) then
                if (selector[lookup.as] == nil) then
                    selector[lookup.as] = 1
                end
            end
        end

        pipeline =
            fastTable.merge(
            {
                {
                    ["$match"] = query
                }
            },
            pipeline,
            {
                {
                    ["$match"] = having
                }
            },
            {
                {
                    ["$skip"] = skip
                }
            },
            {
                {
                    ["$project"] = selector
                }
            },
            {
                {
                    ["$sort"] = args.sort
                }
            }
        )

        for i = 1, total_page do
            local ret =
                db:runCommand(
                "aggregate",
                args.collection,
                "pipeline",
                pipeline,
                "cursor",
                {
                    batchSize = limit
                }
            )

            rows = transform(ret.cursor.firstBatch)

            if (args.call and #rows > 0) then
                args.call(rows)
            end
        end
    else
        for i = 1, total_page do
            local ret = db[args.collection]:find(args.query, args.selector):limit(limit):skip(skip):sort(args.sort)

            rows = cursor(ret)

            if (args.call and #rows > 0) then
                args.call(rows)
            end
        end
    end
end

---统计符合条件的数据量
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
---@return number 结果
function public:count(args)
    local db = self.db

    local query = args.query or {}

    local having = args.having or {}

    if (args.aggregate ~= nil) then
        local pipeline = args.aggregate.pipeline or {}

        pipeline =
            fastTable.merge(
            {
                {
                    ["$match"] = query
                }
            },
            pipeline,
            {
                {
                    ["$match"] = having
                }
            },
            {
                {
                    ["$count"] = "total"
                }
            }
        )

        local ret = db:runCommand("aggregate", args.collection, "pipeline", pipeline, "cursor", {})

        if (ret.cursor.firstBatch[1] ~= nil) then
            return ret.cursor.firstBatch[1].total
        else
            return 0
        end
    else
        return db[args.collection]:find(args.query):count(false)
    end
end

---分页
---@param args table 参数
------@param collection string 集合
------@param query table 查询条件
------@param selector table 查询字段
------@param sort table 排序
------@param page number 当前页
------@param limit number 每页条数
------@param pipeline table 管道
---@return table 结果
function public:pagination(args)
    local db = self.db

    local limit = args.limit or 10

    local page = args.page or 1

    local query = args.query or {}

    local having = args.having or {}

    local selector = args.selector or {}

    local total = self:count(args)

    local total_page = math.ceil(total / limit)

    local rows = {}

    page = math.max(page, 1)

    if (page > total_page) then
        return rows, total, total_page, page, limit
    end

    local skip = (page - 1) * limit

    if (args.aggregate ~= nil) then
        local pipeline = args.aggregate.pipeline or {}

        for i = 1, #pipeline do
            local lookup = pipeline[i]["$lookup"]

            if (lookup ~= nil) then
                if (selector[lookup.as] == nil) then
                    selector[lookup.as] = 1
                end
            end
        end

        pipeline =
            fastTable.merge(
            {
                {
                    ["$match"] = query
                }
            },
            pipeline,
            {
                {
                    ["$match"] = having
                }
            },
            {
                {
                    ["$skip"] = skip
                }
            },
            {
                {
                    ["$project"] = selector
                }
            }
        )

        if (args.sort) then
            pipeline =
                fastTable.merge(
                {
                    {
                        ["$sort"] = args.sort
                    }
                },
                pipeline
            )
        end

        local ret =
            db:runCommand(
            "aggregate",
            args.collection,
            "pipeline",
            pipeline,
            "cursor",
            {
                batchSize = limit
            }
        )

        rows = transform(ret.cursor.firstBatch)
    else
        local ret = db[args.collection]:find(args.query, args.selector):limit(limit):skip(skip)

        if (args.sort) then
            ret = ret:sort(args.sort)
        end

        rows = cursor(ret)
    end

    return rows, total, total_page, page, limit
end

---处理结果集
---@param ret table 资源
---@return table 结果集
function cursor(ret)
    local rows = {}

    local index = 1

    while (ret:hasNext()) do
        rows[index] = transform(ret:next())

        index = index + 1
    end

    return rows
end

---转换数据
---@param data table 数据
---@return table
function transform(data)
    for k, v in pairs(data) do
        local type, value = bson.type(v)

        if (type == "table") then
            data[k] = transform(v)
        elseif (type == "objectid") then
            data[k] = value
        elseif (type == "date") then
            data[k] = os.date("%Y-%m-%d %H:%M:%S", value)
        else
            data[k] = value
        end
    end

    return data
end

return public
