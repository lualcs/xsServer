--[[
    desc:桌子创建
    auth:Carol Luo
]]

local senum = require("managerEnum")

---@type table<gameID,tableManagerInfo>
return {
    ---炸金花
    [1] = {
        assignClass = senum.assignKilling(),
        list = {
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
        }
        
    },
    ---龙虎斗
    [20001] = {
        assignClass = senum.assignKilling(),
        list = {
            [1] = {
                unit = 1,   ---单元积分
                mini = 3,   ---最少桌子
                maxi = 3,   ---最多桌子
                idle = nil, ---保持空闲
            },        
        },
    }
}

---@class tableManagerUnit
---@field unit  score   @单元分数
---@field mini  count   @最少桌子
---@field maxi  count   @最多桌子
---@field idle  count   @保持空闲


---@class tableManagerInfo
---@field assignClass   senum               @分配类型
---@field list          tableManagerUnit[]  @桌子管理