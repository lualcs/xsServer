--[[
    desc:错误码定制
    auth:Carol Luo
]]

local c2sCODE           = 1000000000000000000
local s2cCODE           = 2000000000000000000
local s2sCODE           = 3000000000000000000
local mbeCODE           = 100000000000000
local dveCODE           = 10000000000
local docCODE           = 1000000


local class = require("class")
---@class IMesg @错误码辅助
local IMesg = class()
local this = IMesg

---构造函数
---@param deve integer @开发模块
---@param file integer @文件模块
---@param tail integer @手机尾号
function IMesg:ctor(deve,file,tail)
    ---功能模块
    self._deve = deve * dveCODE
    ---文件模块
    self._file = file * docCODE
    ---手机尾号
    self._tail = tail * mbeCODE
end

---消息号
---@param code integer @消息号
function IMesg:c2s(code)
    return c2sCODE + self._tail + self._deve + self._file + code
end

---消息号
---@param code integer @消息号
function IMesg:s2c(code)
    return s2cCODE + self._tail  + self._deve + self._file + code
end

---消息号
---@param code integer @消息号
function IMesg.s2s(code)
    return s2sCODE + self._tail + self._deve + self._file + code
end
return IMesg
