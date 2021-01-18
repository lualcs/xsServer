local skynet = require("skynet")
local gameEnum = require("gameEnum")
local sharedata = require("skynet.sharedata")
local ipairs = ipairs
local table = require("extend_table")
local debug = require("extend_debug")

--启动
skynet.start(function()
    --共享启动
    local service = skynet.uniqueservice("service_share")
    skynet.call(service, "lua", "start")
    --监听信息
    local listens = sharedata.query("listener.mapServers")

    --启动调试
    local service = skynet.newservice("debug_console",listens.game.debugPort)
    
    --sole服务
    local service = skynet.uniqueservice("service_sole")
    skynet.call(service,"lua","start",{historID=1})

    --单机游戏
    local service = skynet.newservice("service_assign")
    skynet.call(service,"lua","start",gameEnum.assignSingle())

    --测试创建桌子
    skynet.call(service,"lua","createTable",10001,{})

    -- local mahjongCbat = require("mahjongCbat")
    -- mahjongCbat.test()
    -- local slotsCbat = require("slotsCbat")
    -- slotsCbat.test()

    print(_G._VERSION)

end)

