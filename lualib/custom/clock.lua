--[[
    file:timer.lua 
    desc:时钟器
    auth:Carol Luo
]]

local os = os
local string = string
local format = string.format
local skynet = require("skynet")
local timer = require("timer")
local class = require("class")
---@class clock:timer
local clock = class(timer)
local this = clock
---构造
---@param fmt string @格式字符
function clock:ctor(fmt)
    self._fmt = fmt
end

---获取时间
function clock:time()
    return os.time()
end

---轮询器
function clock:timeout()
    ---定时回调
    skynet.timeout(100,self._poling)
end

---检测器
---@param inow number @当前时间
---@param iend number @结束时间
function clock:ifExpire(inow,iend)
    ---剩余时间
    skynet.error(format(self._fmt,iend - inow))
    return self:super(this,"ifExpire",inow,iend)
end

return clock

---@class tagTimer              @定时数据
---@field elapse    MS          @间隔时间
---@field count     count       @回调次数
---@field call      function    @回调函数
---@field args      any[]       @回调参数