--[[
    desc:消息队列配置
    auth:Carol Luo
]]
---@class rabbitmq_config
---@field rabb_mongo rmqUser @mongodb 日志
return {
    rabb_mongo = {
        username = "mongodb",
        password = "mongodb",
        vhost    = "mongodb",
        trailing_lf = true,
    },
}