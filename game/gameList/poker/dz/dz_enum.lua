--[[
    file:dz_enum.lua 
    desc:扎金花
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("pokerEnum")

---@class dz_enum:pokerEnum
local dz_enum = class(pokerEnum)

---构造 
function dz_enum:ctor()
end

---跟注
---@return senum
function dz_enum.dz_gz()
    return "dz_gz"
end

---跟到底
---@return senum
function dz_enum.dz_gdd()
    return "dz_gdd"
end

---加注
---@return senum
function dz_enum.dz_jz()
    return "dz_jz"
end

---梭哈
---@return senum
function dz_enum.dz_sh()
    return "dz_sh"
end

---弃牌
---@return senum
function dz_enum.dz_qp()
    return "dz_qp"
end

---拼牌
---@return senum
function dz_enum.dz_pp()
    return "dz_pp"
end


---丁皇
---@return senum
function dz_enum.dz_dh()
    return "dz_dh"
end

---对子
---@return senum
function dz_enum.dz_dz()
    return "dz_dz"
end

---奶狗
---@return senum
function dz_enum.dz_ng()
    return "dz_ng"
end

---天杠
---@return senum
function dz_enum.dz_tg()
    return "dz_tg"
end

---地杠
---@return senum
function dz_enum.dz_dg()
    return "dz_dg"
end

---天关九
---@return senum
function dz_enum.dz_tg9()
    return "dz_tg9"
end

---地关九
---@return senum
function dz_enum.dz_dg9()
    return "dz_dgj"
end

---人牌九
---@return senum
function dz_enum.dz_rp9()
    return "dz_rp9"
end

---和五九
---@return senum
function dz_enum.dz_hw9()
    return "dz_hwj"
end

---长二九
---@return senum
function dz_enum.dz_ce9()
    return "dz_ce9"
end

---虎头九
---@return senum
function dz_enum.dz_ht9()
    return "dz_ht9"
end

---普通牌
---@return senum
function dz_enum.dz_ptp()
    return "dz_ptp"
end

---三花六
---@return senum
function dz_enum.dz_sh6()
    return "dz_sh6"
end

---三花十
---@return senum
function dz_enum.dz_sh10()
    return "dz_sh10"
end

return dz_enum