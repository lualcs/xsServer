--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local pokerStatus = require("poker.tatus")
---@class ddzStatus:pokerStatus
local ddz_status = class(pokerStatus)

---构造函数
function ddz_status:ctor()

end

return ddz_status