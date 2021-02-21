--[[
    file:extend_math.lua
    desc:扩展算术
    auth:Carol Luo
]]
local math = math

---10进制设置
---@param sum number @总值
---@param bit number @1~n
---@param val number @1~9
function math.setSecimal(sum,bit,val)
    local p = 10^bit
    local a = sum // p * p
    local b = p / 10 * val
    local c = sum % (p // 10)
    return a + b + c
end

---10进制获取
---@param sum number @总值
---@param bit number @1~n
---@param val number @1~9
function math.getSecimal(sum,bit)
    local p = 10^bit
    local a = sum // p * p
    local c = sum % (p // 10)
    local b = sum - a - c
    return b / ( p / 10)
end

return math

--[[
    floor               function: 0x55a22d0f0b70
    randomseed         function: 0x55a22d0f0400
    ult                function: 0x55a22d0f07c0
    rad                function: 0x55a22d0f02f0
    modf               function: 0x55a22d0f0a30
    tan                function: 0x55a22d0f0350
    cos                function: 0x55a22d0f0830
    min                function: 0x55a22d0f05b0
    abs                function: 0x55a22d0f0ca0
    mininteger         -9223372036854775808
    maxinteger         +9223372036854775807
    atan               function: 0x55a22d0f0860
    exp                function: 0x55a22d0f0800
    pi                 3.1415926535898
    type               function: 0x55a22d0f0920
    acos               function: 0x55a22d0f08f0
    random             function: 0x55a22d0f0430
    sqrt               function: 0x55a22d0f0380
    asin               function: 0x55a22d0f08c0
    sin                function: 0x55a22d0f03d0
    max                function: 0x55a22d0f0650
    log                function: 0x55a22d0f06f0
    fmod               function: 0x55a22d0f0d10
    tointeger          function: 0x55a22d0f0c20
    ceil               function: 0x55a22d0f0990
    huge               inf
    deg                function: 0x55a22d0f0320
]]

