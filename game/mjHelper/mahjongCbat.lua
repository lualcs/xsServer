--[[
    file:mahjongCbat.lua 
    desc:打表
    auth:Carol Luo
]]

local os = os
local format = string.format
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local debug = require("extend_debug")
local table = require("extend_table")
local class = require("class")

---@class mahjongCbat
local mahjongCbat = class()
local this = mahjongCbat

local copy1 = {nil}
local copy2 = {nil}
---生成麻将映射值
---@param maps table<mjValue,count>
---@return number 映射值
local function cbatID(maps)
    local c5 = 0
    local arrs = table.clear(copy1)
    for v,c in pairs(maps) do
        if c > 5 then
            return 0
        elseif 5 == c then
            c5 = c5 + 1
        end
        if c5 > 1 then
            return 0
        end
        table.push_repeat(arrs,v,c)
    end
    table.sort(arrs)
    local star = arrs[1] or 0
    local clos = arrs[#arrs] or 0
    local code = table.clear(copy2)
    for i=star,clos do
        table.insert(code,maps[i] or 0)
    end
    return tonumber(table.concat(code))
end

local function cbatID1(a)
    return cbatID(a)
end

local function cbatID2(a,b)
    local s = {nil}
    table.absorb(s,a)
    table.absorb(s,b)
    return cbatID(s)
end

local function cbatID3(a,b,c)
    local s = {nil}
    table.absorb(s,a)
    table.absorb(s,b)
    table.absorb(s,c)
    return cbatID(s)
end

local function cbatID4(a,b,c,d)
    local s = {nil}
    table.absorb(s,a)
    table.absorb(s,b)
    table.absorb(s,c)
    table.absorb(s,d)
    return cbatID(s)
end

local function cbatID5(a,b,c,d,e)
    local s = {nil}
    table.absorb(s,a)
    table.absorb(s,b)
    table.absorb(s,c)
    table.absorb(s,d)
    table.absorb(s,e)
    return cbatID(s)
end

local function cbatID6(a,b,c,d,e,f)
    local s = {nil}
    table.absorb(s,a)
    table.absorb(s,b)
    table.absorb(s,c)
    table.absorb(s,d)
    table.absorb(s,e)
    table.absorb(s,f)
    return cbatID(s)
end

---构造 
function mahjongCbat:ctor()
end

local mahjongSnaps = {
    {[1]=3},
    {[2]=3},
    {[3]=3},
    {[4]=3},
    {[5]=3},
    {[6]=3},
    {[7]=3},
    {[8]=3},
    {[9]=3},
    {[1]=1,[2]=1,[3]=1},
    {[2]=1,[3]=1,[4]=1},
    {[3]=1,[4]=1,[5]=1},
    {[4]=1,[5]=1,[6]=1},
    {[5]=1,[6]=1,[7]=1},
    {[6]=1,[7]=1,[8]=1},
    {[7]=1,[8]=1,[9]=1},
}

---构建+无癞子+无将对
function mahjongCbat:normat()
    local maps = {nil}
    local nums = 0
    for i1,snap1 in ipairs(mahjongSnaps) do
    for i2,snap2 in ipairs(mahjongSnaps) do
    for i3,snap3 in ipairs(mahjongSnaps) do
    for i4,snap4 in ipairs(mahjongSnaps) do
    for i5,snap5 in ipairs(mahjongSnaps) do
        maps[cbatID1(snap1)] = 0
        maps[cbatID2(snap1,snap2)] = 0
        maps[cbatID3(snap1,snap2,snap3)] = 0
        maps[cbatID4(snap1,snap2,snap3,snap4)] = 0
        maps[cbatID5(snap1,snap2,snap3,snap4,snap5)] = 0
        nums = nums + 1
        if 0 == nums % 5000 then
            print(nums/1000)
        end
    end
    end
    end
    end
    end
    debug.error("普通-不包含将对:",maps)
    print(format("总次数:%s",nums))
end


---构建+无癞子
function mahjongCbat:normatJiang()
    local maps = require("mahjong.mapHuCards")
    local os = os
    local nums = 0
    local slen = #mahjongSnaps
    local jiangs = {{[1]=2},{[2]=2},{[3]=2},{[4]=2},{[5]=2},{[6]=2},{[7]=2},{[8]=2},{[9]=2}}
    local pro = 0
    local ms1 = os.clock()
    for i1,snap1 in ipairs(mahjongSnaps) do
    for i2,snap2 in ipairs(mahjongSnaps) do
    for i3,snap3 in ipairs(mahjongSnaps) do
    for i4,snap4 in ipairs(mahjongSnaps) do
    for i5,snap5 in ipairs(mahjongSnaps) do
    for j1,jiang in ipairs(jiangs) do
        maps[cbatID2(snap1,jiang)] = 0
        maps[cbatID3(snap1,snap2,jiang)] = 0
        maps[cbatID4(snap1,snap2,snap3,jiang)] = 0
        maps[cbatID5(snap1,snap2,snap3,snap4,jiang)] = 0
        maps[cbatID6(snap1,snap2,snap3,snap4,snap5,jiang)] = 0
        nums = nums + 1
        local cpo = nums//((slen^5)*9)*100
        if cpo > pro then
            pro = cpo
            local ms2 = os.clock()
            local msx = ms2 - ms1
            print("%:%d 预计:%d 秒",pro,msx*(100-cpo)*1000//1000)
            ms1 = ms2
        end
    end
    end
    end
    end
    end
    end
    debug.error("普通-包含将对:",maps)
    print(format("总次数:%d",nums))
end

function mahjongCbat:normatJiangSort()
    print("lcs------------------------------------------------------------")
    local function hasToArr(map)
        local arr = {nil}
        for k,_ in pairs(map) do
            table.insert(arr,k)
        end
        return arr
    end

    local skynet = require("skynet")
    local map = require("mahjong.mapMeets")
    print("1",os.clock())
    local arr = hasToArr(map)
    print("2",os.clock())
    table.sort(arr)
    print("3",os.clock())
    debug.error("lcs--------------------------------------------------")
    local sls = {}
    table.insert(sls,"{\r\n")
    for _,v in ipairs(arr) do
        table.insert(sls,format("   [%d]=0,\r\n",v))
    end
    table.insert(sls,"}\r\n")
    debug.error("排序表：",table.concat(sls))
    debug.error("lcs--------------------------------------------------")
    print("4",os.clock())
end

---检查普通胡牌
function mahjongCbat:test_nolaizi()
    local gtable = {
        _hlp = mjHlp,
        _sys = {},
        _tye = mtype,
        _lgc = {},
    }
    local import = require("mahjongType")
    local mtype = import.new(gtable)
    local mapName = require("mahjong.mapNames")
    local import = require("mahjongHelper")
    local mjHlp = import.new(gtable)
    local import = require("mahjongAlgor")
    local oalgor = import.new(gtable)
    gtable._hlp = mjHlp
    gtable._tye = mtype
    oalgor:dataReboot()
    oalgor:setSupportClasss({
        {color=0,start=1,close=9,joint=true,},--万
        {color=1,start=1,close=9,joint=true,},--条
        {color=2,start=1,close=9,joint=true,},--筒
        {color=3,start=1,close=7,joint=false,},--字
    })
    local full = mjHlp.getCards({
        {color=0,start=1,close=9,again=4,},--万
        {color=1,start=1,close=9,again=4,},--条
        {color=2,start=1,close=9,again=4,},--筒
        {color=3,start=1,close=7,again=4,},--字
    })
    oalgor:setUsages(nil,table.arrToHas(full))
    local tcount = 100000
    local xcount = 0
    oalgor.setHuCardCount(tcount)
    local star = os.clock()
    local hand = {0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x17,0x18,0x19,0x27,0x28,0x29,0x33,0x33}
    local uty = oalgor:getUnifyHands(hand)
    local xuans
    
    while true do
        if oalgor.getHuCardCount() <= 0 then
            break
        end
        xuans = oalgor:getWhoXuans(hand)
        xcount = xcount + 1
    end
    local clos = os.clock()
    local pass = (clos - star)
    --debug.error(xuans)
    debug.error(format("耗时:%s 胡牌次数:%d 选次数:%d",tostring(pass),tcount,xcount))
    if oalgor:isHuCards(uty) then
        debug.error("胡牌:")
    else
        debug.error("不胡:")
    end
end


function mahjongCbat.test()
    this.test_nolaizi()
end

return mahjongCbat