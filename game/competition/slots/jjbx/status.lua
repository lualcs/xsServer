--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local slotsStatus = require("slots.status")
---@class jjbxStatus:slotsStatus
local status = class(slotsStatus)

---构造函数
function status:ctor()

end

return status