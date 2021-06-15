--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local hundredStatus = require("hundred.status")
local senum = require("dragonTiger.enum")
---@class dragonTigerStatus:hundredStatus @龙虎状态机
local status = class(hundredStatus)

---构造函数
function status:ctor()

end

return status