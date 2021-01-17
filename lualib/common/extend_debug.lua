--[[
    file:extend_debug.lua 
    desc:debug 扩展
    auto:Carol Luo
]]

local os = os
local debug = debug
local table = table
local pairs = pairs
local tostring = tostring
local is_table = require("is_table")
local is_boolean = require("is_boolean")
local extend_tostring = require("extend_tostring")

local skynet = require("skynet")

function debug.print(...)
    local tb_lis = {}
    table.insert(tb_lis,"[")
    table.insert(tb_lis,os.date("%Y-%m-%d %H:%M:%S"))
    table.insert(tb_lis,"]")
    local args = table.pack(...)
    local res = ""
    for n, v in pairs(args) do
        if is_table(v) then
            table.insert(tb_lis,"\n")
            table.insert(tb_lis,extend_tostring(v))
        elseif is_boolean(v) then
            table.insert(tb_lis,"\n")
            table.insert(tb_lis,tostring(v))
        else
            table.insert(tb_lis,"\n")
            table.insert(tb_lis,tostring(v))
        end
  end
  
  return skynet.error(table.concat(tb_lis))
end

function debug.error(...)
    debug.print(...)
end

function debug.warning(...)
    debug.print(...)
end

function debug.normal(...)
    debug.print(...)
end


return debug


--[[
    {   --包含系统库 请不要覆盖
        setmetatable = function: 0x55ce6efb5d20,
        getupvalue = function: 0x55ce6efb5ca0,
        setupvalue = function: 0x55ce6efb5c80,
        traceback = function: 0x55ce6efb6130,
        setlocal = function: 0x55ce6efb6220,
        getuservalue = function: 0x55ce6efb5f30,
        sethook = function: 0x55ce6efb6360,
        setuservalue = function: 0x55ce6efb5dd0,
        gethook = function: 0x55ce6efb6a80,
        upvaluejoin = function: 0x55ce6efb5e60,
        upvalueid = function: 0x55ce6efb5e20,
        getinfo = function: 0x55ce6efb66e0,
        getregistry = function: 0x55ce6efb5be0,
        getmetatable = function: 0x55ce6efb5f00,
        getlocal = function: 0x55ce6efb6580,
        debug = function: 0x55ce6efb5f70,
}
]]