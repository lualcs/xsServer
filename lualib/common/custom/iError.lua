--[[
    desc:错误码定制
    auth:Carol Luo
]]

local normalCode        = 1000000000000000000
local debugCode         = 2000000000000000000
local errorCode         = 3000000000000000000
local mobileCode        = 100000000000000
local moduleCode        = 10000000000
local documeCode        = 1000000


local class = require("class")
---@class iError @错误码辅助
local iError = class()
local this = iError

---构造函数
---@param deve integer @开发模块
---@param file integer @文件模块
---@param tail integer @手机尾号
function iError:ctor(deve,file,tail)
    ---功能模块
    self._deve = deve * moduleCode
    ---文件模块
    self._file = file * documeCode
    ---手机尾号
    self._tail = tail * mobileCode
end

---错误码
---@param code integer @错误编号
function iError:normal(code)
    return normalCode + self._tail + self._deve + self._file + code
end

---错误码
---@param code integer @错误编号
function iError:debug(code)
    return debugCode + self._tail  + self._deve + self._file + code
end

---错误码
---@param code integer @错误编号
function iError.error(code)
    return errorCode + self._tail + self._deve + self._file + code
end
return iError
