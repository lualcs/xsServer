--[[
    desc:扎金花
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("poker.enum")

---@class ddzEnum:pokerEnum
local enum = class(pokerEnum)

---构造 
function enum:ctor()
end

---王炸
---@return senum
function enum.kingBomb()
    return "kingBomb"
end

---炸弹
---@return senum
function enum.bomb()
    return "bomb"
end

---炸弹顺子
---@return senum
function enum.bombStraight()
    return "bombStraight"
end

---4带二
---@return senum
function enum.fourTwo()
    return "fourTwo"
end

---四带二顺子
---@return senum
function enum.fourTwoStraight()
    return "fourTwoStraight"
end

---三条
---@return senum
function enum.triple()
    return "triple"
end

---飞机
---@return senum
function enum.tripleStraight()
    return "tripleStraight"
end

---三带一
---@return senum
function enum.threeOne()
    return "threeOne"
end

---三带一顺子
---@return senum
function enum.threeOneStraight()
    return "threeOneStraight"
end

---对子
---@return senum
function enum.apair()
    return "apair"
end

---连对
---@return senum
function enum.apairStraight()
    return "threeOneStraight"
end

---单牌
---@return senum
function enum.single()
    return "single"
end

---顺子
---@return senum
function enum.straight()
    return "straight"
end



return enum