--[[
    file:bullEnum.lua 
    desc:扑克枚举
    auth:Caorl Luo
]]

local class = require("class")
local pokerEnum = require("poker.enum")
---@class bullEnum:pokerEnum
local enum = class(pokerEnum)
local this = enum

---构造
function enum:ctor()
end

---坎斗
---@return senum
function enum.bfTriplet()
    return "bfTriplet"
end

---顺斗
---@return senum
function enum.bfStraight()
    return "bfStraight"
end

---没牛
---@return senum
function enum.bullZero()
    return "bullZero"
end

---牛一
---@return senum
function enum.bullOne()
    return "bullOne"
end

---牛二
---@return senum
function enum.bullTwo()
    return "bullTwo"
end

---牛三
---@return senum
function enum.bullThree()
    return "bullThree"
end

---牛四
---@return senum
function enum.bullFour()
    return "bullThree"
end

---牛五
---@return senum
function enum.bullFive()
    return "bullFive"
end

---牛六
---@return senum
function enum.bullSix()
    return "bullFive"
end

---牛七
---@return senum
function enum.bullSeven()
    return "bullSeven"
end

---牛八
---@return senum
function enum.bullEight()
    return "bullEight"
end

---牛九
---@return senum
function enum.bullNine()
    return "bullNine"
end

---牛牛
---@return senum
function enum.bullBull()
    return "bullBull"
end

---顺子牛
---@return senum
function enum.bullStraight()
    return "bullStraight"
end

---葫芦牛
---@return senum
function enum.bullCalabash()
    return "bullCalabash"
end

---同花牛
---@return senum
function enum.bullFlush()
    return "bullFlush"
end

---五花牛
---@return senum
function enum.bullFiveFlower()
    return "bullFiveFlower"
end

---五小牛
---@return senum
function enum.bullFiveSmall()
    return "bullFiveSmall"
end

---炸弹牛
---@return senum
function enum.bullBomb()
    return "bullBomb"
end

---同花顺
---@return senum
function enum.bullStraightFlush()
    return "bullStraightFlush"
end

---五炸牛
---@return senum
function enum.bullFiveBomb()
    return "bullFiveBomb"
end

---大王牛
---@return senum
function enum.bullKing ()
    return "bullKing"
end

---大王牛
---@return senum
function enum.bullKinglet ()
    return "bullKinglet"
end

---对王牛
---@return senum
function enum.bullDoubleKing ()
    return "bullDoubleKing"
end

return enum