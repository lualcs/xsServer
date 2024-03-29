--[[
    file:extend_os.lua 
    desc:os 扩展
    auto:Carol Luo
]]

local utime = require("usertime")
local os = os

---毫秒
---@return integer @毫秒
function os.getmillisecond()
    return utime.getmillisecond()
end

---微秒
---@return float @微妙
function os.getmicrosecond()
    return utime.getmicrosecond()
end

return os

--[[
    --系统库
    {
        rename = function: 0x55e2616d0fa0,
        difftime = function: 0x55e2616d1150,
        date = function: 0x55e2616d1660,
        clock = function: 0x55e2616d11a0
        time = function: 0x55e2616d14b0,
        remove = function: 0x55e2616d0ff0,
        execute = function: 0x55e2616d10f0,
        tmpname = function: 0x55e2616d11d0,
        exit = function: 0x55e2616d1060,
        setlocale = function: 0x55e2616d0f40,
        getenv = function: 0x55e2616d1030,
    }
]]