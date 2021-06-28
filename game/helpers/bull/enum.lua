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
function enum.bullFightTriplet()
    return "bullFightTriplet"
end

---顺斗
---@return senum
function enum.bullFightStraight()
    return "bullFightStraight"
end

---没牛
---@return senum
function enum.zeroCattle()
    return "zeroCattle"
end

---牛一
---@return senum
function enum.oneCattle()
    return "oneCattle"
end

---牛二
---@return senum
function enum.towCattle()
    return "towCattle"
end

---牛三
---@return senum
function enum.threeCattle()
    return "threeCattle"
end

---牛四
---@return senum
function enum.fourCattle()
    return "fourCattle"
end

---牛五
---@return senum
function enum.fiveCattle()
    return "fiveCattle"
end

---牛六
---@return senum
function enum.sixCattle()
    return "sixCattle"
end

---牛七
---@return senum
function enum.sevenCattle()
    return "sevenCattle"
end

---牛八
---@return senum
function enum.eightCattle()
    return "eightCattle"
end

---牛九
---@return senum
function enum.nineCattle()
    return "nineCattle"
end

---牛牛
---@return senum
function enum.bullCattle()
    return "bullCattle"
end

---顺子牛
---@return senum
function enum.straight()
    return "straight"
end

---一条龙
---@return senum
function enum.aDragon()
    return "aDragon"
end

---葫芦牛
---@return senum
function enum.calabash()
    return "calabash"
end

---同花牛
---@return senum
function enum.flush()
    return "flush"
end

---五花牛
---@return senum
function enum.fiveFlower()
    return "fiveFlower"
end

---五小牛
---@return senum
function enum.fiveLittle()
    return "fiveLittle"
end

---炸弹牛
---@return senum
function enum.bombCattle()
    return "bombCattle"
end

---同花顺
---@return senum
function enum.straightFlush()
    return "bullStraightFlush"
end

---五炸牛
---@return senum
function enum.fiveBomb()
    return "bullFiveBomb"
end

---小王牛
---@return senum
function enum.leastKing ()
    return "leastKing"
end

---大王牛
---@return senum
function enum.largeKing ()
    return "largeKing"
end

---对王牛
---@return senum
function enum.pairKing()
    return "pairKing"
end

---天牌牛
---@return senum
function enum.heavenCard()
    return "heavenCard"
end

---地王牛
---@return senum
function enum.landKing()
    return "landKing"
end

---天王牛
---@return senum
function enum.skyKing()
    return "skyKing"
end

---神话牛
---@return senum
function enum.mythCattle()
    return "mythCattle"
end

---神赖牛
---@return senum
function enum.godRuffian()
    return "godRuffian"
end


return enum