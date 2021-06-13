--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local pokerStatus = require("poker.tatus")
---@class cx_status:pokerStatus
local cx_status = class(pokerStatus)

---构造函数
function cx_status:ctor()

end

return cx_status