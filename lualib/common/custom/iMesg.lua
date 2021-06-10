--[[
    desc:错误码定制
    auth:Carol Luo
]]

local c2sCODE           = 1000000000000000000
local s2cCODE           = 2000000000000000000
local s2sCODE           = 3000000000000000000
local s2wCODE           = 4000000000000000000
local w2sCODE           = 5000000000000000000
local mbeCODE           = 100000000000000
local dveCODE           = 10000000000
local docCODE           = 1000000


local class = require("class")
---@class iMesg @错误码辅助
local iMesg = class()
local this = iMesg

---构造函数
---@param deve integer @开发模块
---@param file integer @文件模块
---@param tail integer @手机尾号
function iMesg:ctor(deve,file,tail)
    ---功能模块
    self._deve = deve * dveCODE
    ---文件模块
    self._file = file * docCODE
    ---手机尾号
    self._tail = tail * mbeCODE
end

---消息号
---@param code integer @消息号
function iMesg:c2s(code)
    return c2sCODE + self._tail + self._deve + self._file + code
end

---消息号
---@param code integer @消息号
function iMesg:s2c(code)
    return s2cCODE + self._tail  + self._deve + self._file + code
end

---消息号
---@param code integer @消息号
function iMesg.s2s(code)
    return s2sCODE + self._tail + self._deve + self._file + code
end

---消息号
---@param code integer @消息号
function iMesg.s2w(code)
    return s2wCODE + self._tail + self._deve + self._file + code
end

---消息号
---@param code integer @消息号
function iMesg.w2s(code)
    return w2sCODE + self._tail + self._deve + self._file + code
end

return iMesg
