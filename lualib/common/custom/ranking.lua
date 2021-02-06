--[[
    file:ranking.lua 
    desc:排行榜
    auth:Carol Luo
]]

local table = table
local tsort = require("sort")
local search = require("search")
local class = require("class")
local ranking = class()

---@class rank
---@field iden  any     @唯一标示
---@field score score   @排行积分

---构造函数
---@param max   count @最大数量
function ranking:ctor(max)
    ---最大数量
    ---@type count
    self._max = max;
    ---排行数据
    ---@type rank[]                 
    self._lis = {};
    ---映射数据
    ---@type table<any,rank>
    self._map = {}
end

---比较函数
---@param a rank
---@param b rank
local function bcmp(a,b)
    return a.score < b.score
end

---更新数据
---@param iden  any     @唯一表示
---@param score score   @积分
function ranking:update(iden,score)
    local lis = self._lis
    local map = self._map
    local inf = map[iden]
    if not inf then
        inf = {
            iden = iden,
            score = score,
        }
        map[iden] = inf
        tsort.insert(lis,bcmp,inf)
    else
        inf.score = score
        local index = search.traverse(lis,inf)
        table.remove(lis);
    end
    --移除多余
    local limit = self._max
    while #lis > limit do
        table.remove(lis)
    end
end


---删除数据
---@param iden  any     @唯一表示
function ranking:remove(iden)
    local lis = self._lis
    local map = self._map
    local inf = map[iden]
    if not inf then
        return
    end
    map[iden] = nil
    local index = search.traverse(lis,inf)
    table.remove(lis);
end

return ranking