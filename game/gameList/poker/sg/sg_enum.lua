--[[
    file:sg_enum.lua 
    desc:三公
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("pokerEnum")

---@class sg_enum:pokerEnum
local sg_enum = class(pokerEnum)

---构造 
function sg_enum:ctor()
end

---跟注
---@return senum
function sg_enum.sg_gz()
    return "sg_gz"
end

---跟到底
---@return senum
function sg_enum.sg_gdd()
    return "sg_gdd"
end

---加注
---@return senum
function sg_enum.sg_jz()
    return "sg_jz"
end

---梭哈
---@return senum
function sg_enum.sg_sh()
    return "sg_sh"
end

---弃牌
---@return senum
function sg_enum.sg_qp()
    return "sg_qp"
end

---拼牌
---@return senum
function sg_enum.sg_pp()
    return "sg_pp"
end


---丁皇
---@return senum
function sg_enum.sg_dh()
    return "sg_dh"
end

---对子
---@return senum
function sg_enum.sg_dz()
    return "sg_dz"
end

---奶狗
---@return senum
function sg_enum.sg_ng()
    return "sg_ng"
end

---天杠
---@return senum
function sg_enum.sg_tg()
    return "sg_tg"
end

---地杠
---@return senum
function sg_enum.sg_dg()
    return "sg_dg"
end

---天关九
---@return senum
function sg_enum.sg_tg9()
    return "sg_tg9"
end

---地关九
---@return senum
function sg_enum.sg_dg9()
    return "sg_dgj"
end

---人牌九
---@return senum
function sg_enum.sg_rp9()
    return "sg_rp9"
end

---和五九
---@return senum
function sg_enum.sg_hw9()
    return "sg_hwj"
end

---长二九
---@return senum
function sg_enum.sg_ce9()
    return "sg_ce9"
end

---虎头九
---@return senum
function sg_enum.sg_ht9()
    return "sg_ht9"
end

---普通牌
---@return senum
function sg_enum.sg_ptp()
    return "sg_ptp"
end

---三花六
---@return senum
function sg_enum.sg_sh6()
    return "sg_sh6"
end

---三花十
---@return senum
function sg_enum.sg_sh10()
    return "sg_sh10"
end

return sg_enum