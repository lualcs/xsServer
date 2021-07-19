--[[
    file:dz_enum.lua 
    desc:扎金花
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("poker.enum")

---@class dzEnum:pokerEnum
local enum = class(pokerEnum)

---构造 
function enum:ctor()
end

---发牌
---@return senum
function enum.dz_fp()
    return "dz_fp"
end

---跟注
---@return senum
function enum.dz_gz()
    return "dz_gz"
end

---跟到底
---@return senum
function enum.dz_gdd()
    return "dz_gdd"
end

---加注
---@return senum
function enum.dz_jz()
    return "dz_jz"
end

---梭哈
---@return senum
function enum.dz_sh()
    return "dz_sh"
end

---弃牌
---@return senum
function enum.dz_qp()
    return "dz_qp"
end

---同花顺
---@return senum
function enum.dz_ths()
    return "dz_ths"
end

---炸弹
---@return senum
function enum.dt_zd()
    return "dt_zd"
end

---葫芦
---@return senum
function enum.dt_hl()
    return "dt_hl"
end 

---同花
---@return senum
function enum.dt_th()
    return "dz_th"
end

---顺子
---@return senum
function enum.dt_sz()
    return "dt_sz"
end

---三条
---@return senum
function enum.dt_st()
    return "dt_st"
end

---两对
---@return senum
function enum.dt_ld()
    return "dt_ld"
end

---对子
---@return senum
function enum.dt_dz()
    return "dt_dz"
end

---高牌
---@return senum
function enum.dt_gp()
    return "dt_gp"
end

return enum