local skynet = require "skynet"
local sharedata = require("skynet.sharedata")
--启动
skynet.start(function()
    --共享启动
    local serviceShare = skynet.uniqueservice("serviceShare")
    --监听信息
    local listens = sharedata.query("listener.mapServers")
    --启动调试
    skynet.newservice("debug_console",listens.game.debugPort)
    --垃圾回收
    skynet.call(".launcher", "lua", "GC")
end)

