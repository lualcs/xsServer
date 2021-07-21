--[[
    desc:redis 的使用
    auth:Caorl Luo
    data:string（字符串），hash（哈希），list（列表），set（集合）及zset(sorted set：有序集合)。
]]

local class = require("class")
local redis = require("skynet.db.redis")

---@class api_redis @redis 使用
local api_redis = class()
local this = api_redis

---构造函数
---@param cfg redis_connect_info
function api_redis:ctor(cfg)
    ---连接信息
    self._connect = cfg
end

---连接redis数据库
function api_redis:connect()
    self._db = redis.connect(self._connect)
end


---监听redis数据库
function api_redis:watch()
    self._wh = redis.watch(self._connect)
end

---订阅一个或多个频道的信息
---@param channel string @频道
function api_redis:subscribe(channel)
    self._wh:subscribe(channel)
end

---订阅一个或者多个模式消息
---@param pattern string @模式
function api_redis:psubscribe(pattern)
    self._wh:psubscribe(pattern)
end

---退订所有给定模式的频道
---@param pattern string @模式
function api_redis:punsubscribe(pattern)
    self._wh:punsubscribe(pattern)
end

---查看订阅与发布系统状态
---@param command string @命令
---@vararg any[]
function api_redis:publish(command,...)
    self._wh:publish(command,...)
end

---指退订给定的频道
---@param channel string @频道
function api_redis:unsubscribe(channel)
    self._wh:unsubscribe(channel)
end



---KEY 该命令用于在 key 存在时删除 key
---@param key any @键
---@return count @被删除 key 的数量
function api_redis:del(key)
    return self._db:del(key)
end

---KEY 序列化给定 key ，并返回被序列化的值
---@param key any @键
---@return any @如果 key 不存在，那么返回 nil 。 否则，返回序列化之后的值
function api_redis:dump(key)
    return self._db:dump(key)
end

---KEY 用于检查给定 key 是否存在
---@param key any @键
---@return integer @若 key 存在返回 1 ，否则返回 0
function api_redis:exists(key)
    return self._db:exists(key)
end

---KEY 命令用于设置 key 的过期时间，key 过期后将不再可用。单位以秒计
---@param sec integer @过期时间
---@return integer 设置成功返回 1 否则返回0
function api_redis:expire(sec)
    return self._db:expire(sec)
end

---KEY 命令用于设置 key 的过期时间，key 过期后将不再可用。unix 时间戳
---@param sec integer @过期时间戳
---@return integer 设置成功返回 1 否则返回0
function api_redis:expireat(sec)
    return self._db:expireat(sec)
end

---KEY 命令用于设置 key 的过期时间，key 过期后将不再可用。unix 毫秒时间戳
---@param milliseconds integer @过期时间戳
---@return integer 设置成功返回 1 否则返回0
function api_redis:pexpireat(milliseconds)
    return self._db:pexpireat(milliseconds)
end

---KEY 命令用于查找所有符合给定模式 pattern 的 key
---@param pattern string @匹配key模式
---@return KEY[] @符合给定模式的 key 列表 (Array)
function api_redis:keys(pattern)
    return self._db:keys(pattern)
end

---KEY 命令用于将当前数据库的 key 移动到给定的数据库 db 当中
---@param key string @keyname
---@param dbn string @dbname
---@return integer @移动成功返回 1 ，失败则返回 0 
function api_redis:move(key,dbn)
    return self._db:move(key,dbn)
end

---KEY 移除 key 的过期时间，key 将持久保持
---@param key string @keyname
---@return integer @移动成功返回 1 ，失败则返回 0 
function api_redis:pereist(key)
    return self._db:pereist(key)
end

---KEY 命令以毫秒为单位返回 key 的剩余过期时间
---@param key string @keyname
---@return integer @当 key 不存在时，返回 -2 。 当 key 存在但没有设置剩余生存时间时，返回 -1 。 否则，以毫秒为单位，返回 key 的剩余生存时间。
function api_redis:pttl(key)
    return self._db:pttl(key)
end

---KEY 以秒为单位，返回给定 key 的剩余生存时间(TTL, time to live)
---@param key string @keyname
---@return integer @当 key 不存在时，返回 -2 。 当 key 存在但没有设置剩余生存时间时，返回 -1 。 否则，以毫秒为单位，返回 key 的剩余生存时间。
function api_redis:ttl(key)
    return self._db:ttl(key)
end

---KEY  命令从当前数据库中随机返回一个 key 
---@param key string @keyname
---@return key|nil @当数据库不为空时，返回一个 key 。 当数据库为空时，返回 nil
function api_redis:randomkey(key)
    return self._db:randomkey(key)
end

---KEY  命令用于迭代数据库中的数据库键 
---@param cursor integer @游标 0开始
---@param pattern string @匹配模式
---@param count count @指定从数据集里返回多少元素，默认值10
---@return string,key[] @数组列表
function api_redis:scan(cursor,pattern,count)
    return self._db:scan(cursor,pattern,count)
end

---KEY  命令用于修改 key 的名称
---@param keyname string @keyname
---@param newname string @newname
---@return string @改名成功时提示 OK ，失败时候返回一个错误
function api_redis:rename(keyname,newname)
    return self._db:rename(keyname,newname)
end

---KEY  命令用于在新的 key 不存在时修改 key 的名称
---@param keyname string @keyname
---@param newname string @newname
---@return integer @修改成功时，返回 1 。 如果 NEW_KEY_NAME 已经存在，返回 0 
function api_redis:renamex(keyname,newname)
    return self._db:renamex(keyname,newname)
end

---KEY  命令用于返回 key 所储存的值的类型
---@param key string @keyname
---@return string @返回 key 的数据类型，数据类型有 none (key不存在) string (字符串) list (列表) set (集合) zset (有序集) hash (哈希表)
function api_redis:type(key)
    return self._db:type(key)
end

---string  设置指定 key 的值
---@param key string @键
---@param val any @值
---@return string @ SET 在设置操作成功完成时，才返回 OK
function api_redis:set(key,val)
    return self._db:set(key,val)
end

---string  命令用于获取指定 key 的值。
---@param key string @键
---@return string @ 如果 key 不存在，返回 nil 。如果key 储存的值不是字符串类型，返回一个错误。
function api_redis:get(key)
    return self._db:get(key)
end

---string  命令用于获取存储在指定 key 中字符串的子字符串。字符串的截取范围由 start 和 end 两个偏移量决定(包括 start 和 end 在内
---@param key string @键
---@param start integer @开始
---@param close integer @结束
---@return string @ 截取得到的子字符串。
function api_redis:getrange(key)
    return self._db:getrange(key)
end

---@class redis_connect_info
---@field host  host    @地址
---@field port  port    @端口
---@field db    number  @xxx
---@field auth  string  @账号


return api_redis
