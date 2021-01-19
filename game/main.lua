local skynet = require("skynet")
local gameEnum = require("gameEnum")
local sharedata = require("skynet.sharedata")
local ipairs = ipairs
local table = require("extend_table")
local debug = require("extend_debug")

---@type serviceInf @服务信息
local services = {nil}

---启动
skynet.start(function()
    --共享启动
    local service = skynet.uniqueservice("service_share")
    skynet.call(service, "lua", "start")
    services.share = service
    --监听信息
    local listens = sharedata.query("listener.mapServers")

    --启动调试
    local service = skynet.newservice("debug_console",listens.debug.port)
    services.debug = service
    
    --sole服务
    local service = skynet.uniqueservice("service_sole")
    skynet.call(service,"lua","start",{historID=1})
    services.soles = service

    --单机游戏
    local service = skynet.newservice("service_assign")
    skynet.call(service,"lua","start",gameEnum.assignSingle())
    services.single = service

    --启动gate服务
    local service = skynet.newservice("service_gate", service)
    skynet.call(service,"lua","start")
    services.gates = service

    --服务信息共享
    skynet.call(services.share,"lua","setShare","globalservice",services)

    -- local mahjongCbat = require("mahjongCbat")
    -- mahjongCbat.test()
    -- local slotsCbat = require("slotsCbat")
    -- slotsCbat.test()

end)

