--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local pokerStatus = require("pokerStatus")
---@class sg_status:pokerStatus
local sg_status = class(pokerStatus)

---构造函数
function sg_status:ctor()

end

return sg_status