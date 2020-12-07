
--[[
    file:mapSnaps.lua 
    desc:成扑隐射
    auth:Carol Luo
]]

local kz111 = {[1]=3}
local kz222 = {[2]=3}
local kz333 = {[3]=3}
local kz444 = {[4]=3}
local kz555 = {[5]=3}
local kz666 = {[6]=3}
local kz777 = {[7]=3}
local kz888 = {[8]=3}
local kz999 = {[9]=3}

local sz123 = {[1]=1,[2]=1,[3]=1}
local sz234 = {[2]=1,[3]=1,[4]=1}
local sz345 = {[3]=1,[4]=1,[5]=1}
local sz456 = {[4]=1,[5]=1,[6]=1}
local sz567 = {[5]=1,[6]=1,[7]=1}
local sz678 = {[6]=1,[7]=1,[8]=1}
local sz789 = {[7]=1,[8]=1,[9]=1}

---@type mjSnapsMap
return {
    [1] = {sz123,kz111},
    [2] = {sz123,sz234,kz222},
    [3] = {sz123,sz234,sz345,kz333},
    [4] = {sz234,sz345,sz456,kz444},
    [5] = {sz345,sz456,sz567,kz555},
    [6] = {sz456,sz567,sz678,kz666},
    [7] = {sz567,sz678,sz789,kz777},
    [8] = {sz678,sz789,kz888},
    [9] = {sz789,kz999},
}
