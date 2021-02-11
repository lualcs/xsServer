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

---比牌
---@return senum
function cx_enum.cx_bp()
    return "cx_bp"
end

return cx_enum