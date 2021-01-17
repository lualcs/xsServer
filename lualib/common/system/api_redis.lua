--[[
    file:api_redis.lua
    desc:redis 的使用
    auth:Caorl Luo
]]

local class = require("class")
local redis = require("skynet.db.redis")

---@class api_redis @redis 使用
local api_redis = class()
local this = api_redis

---构造函数
function api_redis:ctor()
end

---连接redis数据库
---@param info  redis_connect_info @连接信息
function api_redis:connect(info)
    return redis.connect(info)
end


---@class redis_connect_info
---@field host  host    @地址
---@field port  port    @端口
---@field db    number  @xxx
---@field auth  string  @账号


return api_redis
