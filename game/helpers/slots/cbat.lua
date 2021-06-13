--[[
    file:slotsCbat.lua
    desc:测试
    auth:Carol Luo
]]
local string = string
local ipairs = ipairs
local skynet = require("skynet")
local debug = require("extend_debug")
local table = require("extend_table")
local class = require("class")

---@class slotsCbat
local cbat = class()
local this = cbat

---构造 
function cbat:ctor()
end

--local paths = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14}--243
    --local paths = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19}--1024
---满线路线
function cbat.pathPrint(raxl,px)
    px = px or 0
    local xxxxs = {1,2,3,4,5}
    local linem = {}
    local lines = {}

    local total = 0
    for _,a in ipairs(raxl.a) do
    for _,b in ipairs(raxl.b) do
    for _,c in ipairs(raxl.c) do
    for _,d in ipairs(raxl.d) do
    for _,e in ipairs(raxl.e) do
        table.insert(lines,{a,b,c,d,e})
        total = total + 1
    end
    end
    end
    end
    end

    local format = string.format
    local list = {}
    table.insert(list,"{\r\n")
    for index,v in ipairs(lines) do
        table.insert(list,"  [")
        table.insert(list,index)
        table.insert(list,"]  =  {")
        table.insert(list,format("%d,%d,%d,%d,%d",v[1]+px,v[2]+px,v[3]+px,v[4]+px,v[5]+px))
        table.insert(list,"},\r\n")
    end
    table.insert(list,"}\r\n")

    skynet.error(table.concat(list))
    print("ok:",total)
end

function cbat.test()
    this.pathPrint({
        a = {0,5,10},
        b = {1,6,11},
        c = {2,7,12},
        d = {3,8,13},
        e = {4,9,14},
    })
end

return cbat