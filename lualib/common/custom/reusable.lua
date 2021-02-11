--[[
    file:reusable.lua 
    desc:复用仓库
    auth:Caorl Luo
]]

local next = next
local table = table
local class = require("class")

---@class reusable
local reusable = class()
local this = reusable



---构造
---@param def
function reusable:ctor()
    self.list = {nil}
end


---申请
---@return table
function reusable:get()
    local list = self.list
    local defa = self.defa
    if next(list) then
        return table.remove(list)
    else
        return {nil}
    end
end


---回收
---@param t table @表
function reusable:set(t)
    table.insert(self.list,t)
end

return reusable