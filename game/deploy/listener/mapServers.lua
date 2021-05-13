---集群信息
---@type mapServers
return {
    ---调试
    debug = {
        host = "127.0.0.1",
        port = 21001,
    },

    ---登陆
    login = {
        host = "127.0.0.1",
        port = 22001,
    },

    ---网关
    gate = {
        host = "192.168.204.128",
        port = 23001,
    },

    ---mysql
    mysql = {
        host        = "127.0.0.1",  --主机
        port        = 3306,         --端口
        database    = "";           --库名
        user        = "root";       --用户
        password    = "123456";     --密码
    },

    ---mongo
    mongo = {
        {
            host = "127.0.0.1",
            port = 27017,
            username = "lcs",
            password = "123456",
            autodb = "admin",
        }
    },


}
