--[[
    desc:状态机
    auth:Carol Luo
]]

local class = require("class")
local mahjongStatus = require("mahjong.status")
---@class hutdhStatus:pokerStatus
local hutdhStatus = class(mahjongStatus)

---构造函数
function hutdhStatus:ctor()

end

return hutdhStatus