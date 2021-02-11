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
