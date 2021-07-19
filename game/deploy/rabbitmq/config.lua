--[[
    desc:消息队列配置
    auth:Carol Luo
]]
---@class rabbitmq_config
---@field rabb_mongo_opts rmqUser @mongodb 日志
---@field rabb_mongo_host address @mongodb 日志
return {
    rabb_mongo_opts = {
        username = "mongodb",
        password = "mongodb",
        vhost    = "mongodb",
        trailing_lf = true,
    },
    rabb_mongo_host = {
        host = "127.0.0.1",
        port = 61613,
    },
}