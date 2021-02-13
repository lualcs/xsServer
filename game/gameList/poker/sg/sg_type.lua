--[[
    file:sg_type.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local math = math
local class = require("class")
local pokerType = require("pokerType")
---@class sg_type:pokerType
local sg_type = class(pokerType)
local senum = require("sg.sg_enum")

---构造 
function sg_type:ctor()
end

---大三公
---@param hands pkCard[] @牌
---@return boolean
function sg_type:isDaSanGong(hands)
    ---三公辅助
    ---@type sg_helper
    local hlp = self._hlp
    local a,b,c = hlp.getValue(hands[1]),hlp.getValue(hands[2]),hlp.getValue(hands[3])
    return a == b and b == c
end

---小三公
---@param hands pkCard[] @牌
---@return boolean
function sg_type:isXiaSanGong(hands)
    ---三公辅助
    ---@type sg_helper
    local hlp = self._hlp
    local a,b,c = hlp.getValue(hands[1]),hlp.getValue(hands[2]),hlp.getValue(hands[3])
    return a > 10 and b > 10 and c > 10
end

---点数牌
---@param hands pkCard[] @牌
---@return number
function sg_type:getDian(hands)
    ---三公辅助
    ---@type sg_helper
    local hlp = self._hlp
    local a,b,c = hlp.getValue(hands[1]),hlp.getValue(hands[2]),hlp.getValue(hands[3])
    local d = math.min(10,a) + math.min(10,b) + math.min(10,c)
    return d % 10
end

---获取类型
---@param hands pkCard[] @牌
---@return senum
function sg_type:getType(hands)
    ---大三公
    if self:isDaSanGong(hands) then
        return senum.sg_dsg()
    end
    ---小三公
    if self:isXiaoSanGong(hands) then
        return senum.sg_xsg()
    end
    ---点数牌
    local d = self:getDian(hands)
    if 9 == d then
        return senum.sg_9d()
    end
    if 8 == d then
        return senum.sg_8d()
    end
    if 7 == d then
        return senum.sg_7d()
    end
    if 6 == d then
        return senum.sg_6d()
    end
    if 5 == d then
        return senum.sg_5d()
    end
    if 4 == d then
        return senum.sg_4d()
    end
    if 3 == d then
        return senum.sg_3d()
    end
    if 2 == d then
        return senum.sg_2d()
    end
    if 1 == d then
        return senum.sg_1d()
    end
    if 0 == d then
        return senum.sg_0d()
    end
end

return sg_type