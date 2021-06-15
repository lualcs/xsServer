--[[
    desc:mongo处理
    auth:Carol Luo
]]

local class = require("class")
local skynet = require("skynet")

---@class competitionMongo @比赛monggo处理
local mongo = class()

---构造函数
---@param mogo service @mongo服务
function mongo:ctor(mogo)
    self._mogo = mogo
end

---重置数据
function mongo:dataReboot()
end

---清除数据
function mongo:dataClear()
end


---写入日志
---@param text string @跟踪信息
function mongo:writeLog(name,text)
    skynet.sen(self._mogo,"lua","writeLog",name,text)
end

return mongo