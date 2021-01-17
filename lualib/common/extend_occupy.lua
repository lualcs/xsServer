--[[
    file:extend_occupy.lua 
    desc:占位标记
    auth:Carol Luo
]]

local next = next
local table = table
local class = require("class")

---@class occupy
local occupy = class()

---构造
---@param min number @最少数
---@param max number @最大数
function occupy:ctor(min,max)
    self._min = min --最少数
    self._max = max --最大数
    self._cur = min --当前取
    self._lis = {nil}
end

---重启
function occupy:dataReboot()
    self._cur = self._min
end

---取
---@return boolean,number
function occupy:fetch()
    if self._cur < self._max then
        self._cur = self._cur + 1
        return true
    end

    local lis = self._lis
    if next(lis) then
        self._cur = table.remove(lis)
        return true
    end

    return false
end

---还
---@param mark number
function occupy:repay(mark)
    table.insert(self._lis,mark)
end

---读
---@return number
function occupy:read()
    return self._cur
end


return  occupy