--[[
    file:mahjongType.lua 
    desc:类型 
    auth:Carol Luo
]]

local class = require("class")
local gameType = require("gameType")
---@class mahjongType:gameType 
local mahjongType = class(gameType)


---构造
function mahjongType:ctor()
end

---类型
---@param mjUnify mjUnify @数据
---@return mjPeg
function mahjongType:getPegItem(mjUnify)
    return true
end

return mahjongType