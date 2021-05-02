--[[
    file:mongomanager.lua 
    desc:mysql处理
    auth:Caorl Luo
]]

local ipairs = ipairs
local format = string.format
local string = require("extend_string")
local table = require("extend_table")
local debug = require("extend_debug")
local skynet = require("skynet")
local class = require("class")
local senum = require("managerEnum")
local api_mongo = require("api_mongo")
local timer = require("timer")

---@class mongomanager @gate管理
local mongomanager = class()
local this = mongomanager

---构造
---@param service service_mongo         @gate服务
function mongomanager:ctor(service)
    ---mongo服务
    ---@type service_mongo
    self._service = service

    ---@type api_mongo
    self._mongo = api_mongo.new({
       rs = {
                {
                    host = "127.0.0.1",
                    port = 27017,
                    username = "lcs",
                    password = "123456",
                    autodb = "admin",
                }
        },
    })

    ---启动连接
    self._mongo:connect()
    ---启动定时器
    self._timer = timer.new()
    self._timer:poling()

    self._timer:appendBy("dbstructure",0,1,function(_)
        ---构造结构
        self:dbstructure()
    end)

end

---重置
function mongomanager:dataReboot()
  
end

---服务
---@return serviceInf @服务信息
function mongomanager:getServices()
    return self._service.services
end


---构造数据库
function mongomanager:dbstructure()
    local mongo = self._mongo
    ---金玉满堂数据
    local db = mongo._db.slotsJYMT
    ---游戏日志
    self.jymtDetails = db.slots_jymt_details
end

---写入金玉满堂日志
function mongomanager:slotsDetailsJYMT(details)
    local coll = self.jymtDetails
    coll:soft_insert(details)
end


return mongomanager