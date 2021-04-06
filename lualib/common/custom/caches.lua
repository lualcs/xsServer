--[[
    file:cache.lua 
    desc:缓存
    auth:Carol Luo
]]


local next = next
local os = require("extend_os")
local table = require("extend_table")
local class = require("class")

---@class cacheUnit 缓存单元
---@field ocutime   integer @缓存时间
---@field elatime   double  @缓存时间
---@field cache     table   @缓存时间


---@class caches
local caches = class()

---构造
function caches:ctor(min,max)
    ---@type cacheUnit[]
    self._caches = {}
end

---重启
function caches:dataReboot()
    table.clear(self._caches)
end


---缓存
---@param cache data @数据
function caches:dataPush(cache)
    local list = self._caches
    table.insert(list,{
        ocutime = os.getmillisecond(),
        cache   = cache,
    })
end

return  caches