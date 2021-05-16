local skynet = require("skynet")
local senum = require("managerEnum")
local sharedata = require("skynet.sharedata")
local ipairs = ipairs
local table = require("extend_table")
local debug = require("extend_debug")
local multicast = require("api_multicast")

---@type serviceInf @服务信息
local services = {nil}

---启动
skynet.start(function()

    ---共享启动
    local service = skynet.uniqueservice("service_share")
    skynet.call(service, "lua", "start")
    services.share = service
    ---监听信息
    local listens = sharedata.query("listener.mapServers")

    ---调试服务
    local service = skynet.newservice("debug_console",listens.debug.port)
    services.debug = service
    
    ---sole服务
    local service = skynet.uniqueservice("service_sole")
    skynet.call(service,"lua","start",{historID=1})
    services.soles = service

    ---mysql服务
    local service = skynet.newservice("service_mysql")
    skynet.call(service,"lua","start")
    services.mysql = service

    ---mongo服务
    local service = skynet.newservice("service_mongo")
    skynet.call(service,"lua","start")
    services.mongo = service

    ---http_client服务
    local service = skynet.newservice("service_chttp")
    skynet.call(service,"lua","start")
    services.http_client = service

     ---http_client服务
     local service = skynet.newservice("service_shttp")
     skynet.call(service,"lua","start")
     services.http_server = service

    ---alliance服务
    local service = skynet.newservice("service_alliance")
    skynet.call(service,"lua","start")
    services.alliance = service

    ---login服务
    local service = skynet.newservice("service_login")
    skynet.call(service,"lua","start")
    services.login = service

    ---gate服务
    local service = skynet.newservice("service_gate")
    skynet.call(service,"lua","start")
    services.gates = service

    ---robot服务
    local service = skynet.newservice("service_robot")
    skynet.call(service,"lua","start")
    services.robot = service

    ---组播服务
    ---@type api_multicast
    local channel = multicast.new()
    channel:create()
    services.mainChannel = channel:channel()

    ---服务信息共享
    skynet.call(services.share,"lua","setShare",senum.mapServices(),services)
    ---服务信息广播
    skynet.call(services.share,"lua","broadcast",senum.mapServices())
    ---服务组播处理
    skynet.call(services.share,"lua","distributed","multicast")
    ---服务全部完成
    skynet.call(services.share,"lua","distributed","dataReboot")


end)

