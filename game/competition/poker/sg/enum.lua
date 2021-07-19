--[[
    file:sg_enum.lua 
    desc:三公
    auth:Carol Luo
]]

local class = require("class")
local pokerEnum = require("poker.enum")

---@class sgEnum:pokerEnum
local enum = class(pokerEnum)

---构造 
function enum:ctor()
end

---跟注
---@return senum
function enum.sg_gz()
    return "sg_gz"
end

---跟到底
---@return senum
function enum.sg_gdd()
    return "sg_gdd"
end

---加注
---@return senum
function enum.sg_jz()
    return "sg_jz"
end

---梭哈
---@return senum
function enum.sg_sh()
    return "sg_sh"
end

---弃牌
---@return senum
function enum.sg_qp()
    return "sg_qp"
end

---大三公
---@return senum
function enum.sg_dsg()
    return "sg_dsg"
end

---小三公
---@return senum
function enum.sg_xsg()
    return "sg_xsg"
end

---九点
---@return senum
function enum.sg_9d()
    return "sg_9d"
end

---八点
---@return senum
function enum.sg_8d()
    return "sg_8d"
end

---七点
---@return senum
function enum.sg_7d()
    return "sg_7d"
end

---六点
---@return senum
function enum.sg_6d()
    return "sg_6d"
end

---五点
---@return senum
function enum.sg_5d()
    return "sg_5d"
end

---4点
---@return senum
function enum.sg_4d()
    return "sg_4d"
end

---3点
---@return senum
function enum.sg_3d()
    return "sg_3d"
end

---2点
---@return senum
function enum.sg_2d()
    return "sg_2d"
end

---1点
---@return senum
function enum.sg_1d()
    return "sg_1d"
end

---0点
---@return senum
function enum.sg_0d()
    return "sg_1d"
end

return enum