--[[
    file:tostring.lua
    desc:table 转字符串 只打印最外层
    auto:Carol Luo
]]

local table = require("extend_table")
local is_number = require("is_number")
local tostring = tostring

local print = print
local pairs = pairs

return function(t)
    local lis = table.fortab()
    table.insert(lis,"{\r\n")
    for k,v in pairs(t) do
        table.insert(lis,"\t")
        if is_number(k) then
            table.insert(lis,"[")
            table.insert(lis,tostring(k))
            table.insert(lis,"]")
        else
            table.insert(lis,tostring(k))
        end
        
        table.insert(lis," = ")
        table.insert(lis,tostring(v))
        table.insert(lis,",\r\n")
    end
    table.insert(lis,"}")
    return table.concat(lis)
end

