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

---发牌
---@return senum
function dz_enum.dz_fp()
    return "dz_fp"
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

---同花顺
---@return senum
function dz_enum.dz_ths()
    return "dz_ths"
end

---炸弹
---@return senum
function dz_enum.dt_zd()
    return "dt_zd"
end

---葫芦
---@return senum
function dz_enum.dt_hl()
    return "dt_hl"
end 

---同花
---@return senum
function dz_enum.dt_th()
    return "dz_th"
end

---顺子
---@return senum
function dz_enum.dt_sz()
    return "dt_sz"
end

---三条
---@return senum
function dz_enum.dt_st()
    return "dt_st"
end

---两对
---@return senum
function dz_enum.dt_ld()
    return "dt_ld"
end

---对子
---@return senum
function dz_enum.dt_dz()
    return "dt_dz"
end

---高牌
---@return senum
function dz_enum.dt_gp()
    return "dt_gp"
end

return dz_enum