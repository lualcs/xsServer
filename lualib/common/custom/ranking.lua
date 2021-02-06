--[[
    file:ranking.lua 
    desc:排行榜
    auth:Carol Luo
]]

local tsort = require("sort")
local class = require("class")
local ranking = class()

---构造函数
---@param max   count @最大数量
function ranking:ctor(max)
    ---@type count  @最大数量
    self._max = max;
    ---@type rank[] @排行数据
    self._lis = {};
end

---更新数据
---@param iden  userID @用户ID
---@param score score  @积分
function ranking:update(iden,score)
end

return ranking