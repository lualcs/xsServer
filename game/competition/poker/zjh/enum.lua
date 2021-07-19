--[[
    file:zjh_enum.lua 
    desc:扎金花
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("poker.enum")

---@class zjhEnum:pokerEnum
local enum = class(pokerEnum)

---构造 
function enum:ctor()
end

---豹子
---@return senum
function enum.zjh_bz()
    return "zjh_bz"
end

---同花
---@return senum
function enum.zjh_th()
    return "zjh_th"
end

---同花顺
---@return senum
function enum.zjh_ths()
    return "zjh_ths"
end

---顺子
---@return senum
function enum.zjh_sz()
    return "zjh_sz"
end

---对子
---@return senum
function enum.zjh_dz()
    return "zjh_dz"
end

---高牌
---@return senum
function enum.zjh_dz()
    return "zjh_gp"
end

---跟注
---@return senum
function enum.zjh_gz()
    return "zjh_gz"
end

---跟到底
---@return senum
function enum.zjh_gdd()
    return "zjh_gdd"
end

---加注
---@return senum
function enum.zjh_jz()
    return "zjh_jz"
end

---梭哈
---@return senum
function enum.zjh_sh()
    return "zjh_sh"
end

---弃牌
---@return senum
function enum.zjh_qp()
    return "zjh_qp"
end

---看牌
---@return senum
function enum.zjh_kp()
    return "zjh_kp"
end

---比牌
---@return senum
function enum.zjh_bp()
    return "zjh_bp"
end

return enum