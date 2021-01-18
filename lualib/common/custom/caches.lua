--[[
    file:cache.lua 
    desc:缓存
    auth:Carol Luo
]]

local os = os
local next = next
local table = require("extend_table")
local class = require("class")

---@class cacheUnit 缓存单元
---@field ocutime   integer @缓存时间
---@field elatime   double  @缓存时间
---@field cache     table   @缓存时间


---@class caches
local caches = class()

---构造
---@param min number @最少数
---@param max number @最大数
function caches:ctor(min,max)
    ---@type cacheUnit[]
    self._caches = {}
end

---重启
function caches:dataReboot()
    self._elatime = self:clock()
    table.clear(self._caches)
end

---毫秒
---@return integer
function caches:clock()
    return os.clock() * 1000 // 1
end

---间隔
function caches:elapse()
    return self:clock() - self._elatime
end

---缓存
---@param cache data @数据
function caches:dataPush(cache)
    local list = self._caches
    table.insert(list,{
        ocutime = os.time(),
        elatime = self:elapse(),
        cache = cache,
    })
    self._elatime = self:clock()
end

return  caches