--[[
    file:cx_type.lua 
    desc:类型判断 
    auth:Carol Luo
]]

local class = require("class")
local pokerType = require("poker.type")
---@class cx_type:pokerType
local cx_type = class(pokerType)

---构造 
function cx_type:ctor()
end

---丁皇
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isDingHuang(a,b)
    if 0x23 == a and 0x4f == b then
        return true
    end
    if 0x23 == b and 0x4f == a then
        return true
    end
    return false
end

---对子
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isDuiZi(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if hlp:cxColor(a) == hlp:cxColor(b) then
        if hlp:getValue(a) == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---奶狗
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isNaiGou(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x0c == a or 0x2c == b then
        if 0x09 == hlp:getValue(a) or 0x09 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---天杠
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isTianGang(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x0c == a or 0x2c == b then
        if 0x08 == hlp:getValue(a) or 0x08 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---地杠
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isDiGang(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x02 == a or 0x22 == b then
        if 0x08 == hlp:getValue(a) or 0x08 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---天关九
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isTianGuan9(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x0c == a or 0x2c == b then
        if 0x07 == hlp:getValue(a) or 0x07 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---地关九
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isDiGuan9(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x02 == a or 0x22 == b then
        if 0x07 == hlp:getValue(a) or 0x07 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---人牌九
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isRenPai9(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x08 == a or 0x28 == b then
        if 0x0b == hlp:getValue(a) or 0x0b == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---和五九
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isHeWu9(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x04 == a or 0x24 == b then
        if 0x05 == hlp:getValue(a) or 0x05 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---长二九
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isChangEr9(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x14 == a or 0x34 == b then
        if 0x05 == hlp:getValue(a) or 0x05 == hlp:getValue(b) then
            return true
        end
    end
    return false
end

---虎头九
---@param a pkCard @牌
---@param b pkCard @牌
---@return boolean
function cx_type:isHuTou9(a,b)
    ---帮助
    ---@type cx_helper
    local hlp = self._hlp
    if 0x18 == a or 0x38 == b then
        if 0x0b == hlp:getValue(a) or 0x0b == hlp:getValue(b) then
            return true
        end
    end
    return false
end

return cx_type