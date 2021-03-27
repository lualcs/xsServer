--[[
    file:bullEnum.lua 
    desc:扑克枚举
    auth:Caorl Luo
]]

local class = require("class")
local pokerEnum = require("pokerEnum")
---@class bullEnum:pokerEnum
local bullEnum = class(pokerEnum)
local this = bullEnum

---构造
function bullEnum:ctor()
end

---坎斗
---@return senum
function bullEnum.bfTriplet()
    return "bfTriplet"
end

---顺斗
---@return senum
function bullEnum.bfStraight()
    return "bfStraight"
end

---没牛
---@return senum
function bullEnum.bullZero()
    return "bullZero"
end

---牛一
---@return senum
function bullEnum.bullOne()
    return "bullOne"
end

---牛二
---@return senum
function bullEnum.bullTwo()
    return "bullTwo"
end

---牛三
---@return senum
function bullEnum.bullThree()
    return "bullThree"
end

---牛四
---@return senum
function bullEnum.bullFour()
    return "bullThree"
end

---牛五
---@return senum
function bullEnum.bullFive()
    return "bullFive"
end

---牛六
---@return senum
function bullEnum.bullSix()
    return "bullFive"
end

---牛七
---@return senum
function bullEnum.bullSeven()
    return "bullSeven"
end

---牛八
---@return senum
function bullEnum.bullEight()
    return "bullEight"
end

---牛九
---@return senum
function bullEnum.bullNine()
    return "bullNine"
end

---牛牛
---@return senum
function bullEnum.bullBull()
    return "bullBull"
end

---顺子牛
---@return senum
function bullEnum.bullStraight()
    return "bullStraight"
end

---葫芦牛
---@return senum
function bullEnum.bullCalabash()
    return "bullCalabash"
end

---同花牛
---@return senum
function bullEnum.bullFlush()
    return "bullFlush"
end

---五花牛
---@return senum
function bullEnum.bullFiveFlower()
    return "bullFiveFlower"
end

---五小牛
---@return senum
function bullEnum.bullFiveSmall()
    return "bullFiveSmall"
end

---炸弹牛
---@return senum
function bullEnum.bullBomb()
    return "bullBomb"
end

---同花顺
---@return senum
function bullEnum.bullStraightFlush()
    return "bullStraightFlush"
end

---五炸牛
---@return senum
function bullEnum.bullFiveBomb()
    return "bullFiveBomb"
end

---大王牛
---@return senum
function bullEnum.bullKing ()
    return "bullKing"
end

---大王牛
---@return senum
function bullEnum.bullKinglet ()
    return "bullKinglet"
end

---对王牛
---@return senum
function bullEnum.bullDoubleKing ()
    return "bullDoubleKing"
end

return bullEnum