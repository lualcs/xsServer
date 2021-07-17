--[[
    desc:桌子创建
    auth:Carol Luo
]]

local senum = require("managerEnum")

---@type table<senum,competitionManagerUnit[]>
return {
    ---竞技场
    [senum.assignKilling()] = {
        [30001] = {
            unit = 1,   ---单元积分
            mini = 1,   ---最少桌子
            maxi = 1,   ---最多桌子
            idle = nil, ---保持空闲
        }, 
    },
    ---百人场
    [senum.assignHundred()] = {
        [1] = {
            unit = 1,   ---单元积分
            mini = 1,   ---最少桌子
            maxi = 1,   ---最多桌子
            idle = nil, ---保持空闲
        }, 
    },
    ---单人场
    [senum.assignSingle()] = {
    }
}

---@class competitionManagerUnit
---@field unit  score   @单元分数
---@field mini  count   @最少桌子
---@field maxi  count   @最多桌子
---@field idle  count   @保持空闲

---@class competitionManagerData
---@field count  count   @桌子数量
---@field idler  count   @保持空闲

