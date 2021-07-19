--[[
    desc:mysql处理
    auth:Carol Luo
]]

local class = require("class")
local skynet = require("skynet")

---@class competitionMysql @比赛monggo处理
local mysql = class()

---构造函数
---@param msql service @mysql服务
function mysql:ctor(msql)
    self._msql = msql
end

---重置数据
function mysql:dataReboot()
end

---清除数据
function mysql:dataClear()
end

return mysql