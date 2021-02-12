--[[
    file:cx_enum.lua 
    desc:扎金花
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("pokerEnum")

---@class cx_enum:pokerEnum
local cx_enum = class(pokerEnum)

---构造 
function cx_enum:ctor()
end

---跟注
---@return senum
function cx_enum.cx_gz()
    return "cx_gz"
end

---跟到底
---@return senum
function cx_enum.cx_gdd()
    return "cx_gdd"
end

---加注
---@return senum
function cx_enum.cx_jz()
    return "cx_jz"
end

---梭哈
---@return senum
function cx_enum.cx_sh()
    return "cx_sh"
end

---弃牌
---@return senum
function cx_enum.cx_qp()
    return "cx_qp"
end

---看牌
---@return senum
function cx_enum.cx_kp()
    return "cx_kp"
end


---丁皇
---@return senum
function cx_enum.cx_dh()
    return "cx_dh"
end

---对子
---@return senum
function cx_enum.cx_dz()
    return "cx_dz"
end

---奶狗
---@return senum
function cx_enum.cx_ng()
    return "cx_ng"
end

---天杠
---@return senum
function cx_enum.cx_tg()
    return "cx_tg"
end

---地杠
---@return senum
function cx_enum.cx_dg()
    return "cx_dg"
end

---天关九
---@return senum
function cx_enum.cx_tg9()
    return "cx_tg9"
end

---地关九
---@return senum
function cx_enum.cx_dg9()
    return "cx_dgj"
end

---人牌九
---@return senum
function cx_enum.cx_rp9()
    return "cx_rp9"
end

---和五九
---@return senum
function cx_enum.cx_hw9()
    return "cx_hwj"
end

---长二九
---@return senum
function cx_enum.cx_ce9()
    return "cx_ce9"
end

---虎头九
---@return senum
function cx_enum.cx_ht9()
    return "cx_ht9"
end

---普通牌
---@return senum
function cx_enum.cx_ptp()
    return "cx_ptp"
end

---三花六
---@return senum
function cx_enum.cx_sh6()
    return "cx_sh6"
end

---三花十
---@return senum
function cx_enum.cx_sh10()
    return "cx_sh10"
end

return cx_enum