--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local pokerStatus = require("poker.tatus")
---@class dzStatus:pokerStatus
local status = class(pokerStatus)

---构造函数
function status:ctor()

end

return status