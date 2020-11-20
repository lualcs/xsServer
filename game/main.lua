local skynet = require "skynet"
local sharedata = require("skynet.sharedata")
--启动
skynet.start(function()
    --启动调试
    skynet.newservice("debug_console",20001)
    --共享启动
    local serviceShare = skynet.uniqueservice("service/serviceShare")
end)

