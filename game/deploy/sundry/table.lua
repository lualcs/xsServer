--[[
    desc:桌子创建
    auth:Carol Luo
]]

local senum = require("managerEnum")

---@type table<senum,tableManagerUnit[]>
return {
    ---竞技场
    [senum.assignKilling()] = {
        [1] = {
            unit = 1,   ---单元积分
            mini = 2,   ---最少桌子
            maxi = 100, ---最多桌子
            idle = 2,   ---保持空闲
        },
        [2] = {
            unit = 5,   ---单元积分
            mini = 2,   ---最少桌子
            maxi = 100, ---最多桌子
            idle = 2,   ---保持空闲
        },
        
    },
    ---百人场
    [senum.assignHundred()] = {
        [1] = {
            unit = 1,   ---单元积分
            mini = 3,   ---最少桌子
            maxi = 3,   ---最多桌子
            idle = nil, ---保持空闲
        }, 
        [2] = {
            unit = 10,  ---单元积分
            mini = 3,   ---最少桌子
            maxi = 3,   ---最多桌子
            idle = nil, ---保持空闲
        },   
        [3] = {
            unit = 20,  ---单元积分
            mini = 3,   ---最少桌子
            maxi = 3,   ---最多桌子
            idle = nil, ---保持空闲
        },                
    },
     ---单人场
     [senum.assignSingle()] = {
        [1] = {
            unit = 1,   ---单元积分
            mini = 1,   ---最少桌子
            maxi = 1,   ---最多桌子
            idle = nil, ---保持空闲
        },   
        [2] = {
            unit = 10,  ---单元积分
            mini = 1,   ---最少桌子
            maxi = 1,   ---最多桌子
            idle = nil, ---保持空闲
        },       
        [3] = {
            unit = 20,  ---单元积分
            mini = 1,   ---最少桌子
            maxi = 1,   ---最多桌子
            idle = nil, ---保持空闲
        },            
    }
}

---@class tableManagerUnit
---@field unit  score   @单元分数
---@field mini  count   @最少桌子
---@field maxi  count   @最多桌子
---@field idle  count   @保持空闲