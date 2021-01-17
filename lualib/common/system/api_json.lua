
--[[
    file:api_json.lua
    desc:cjson 的使用
    auth:Carol Luo
]]

local cjson = require("cjson")

---@class api_json json
local api_json = {}

---转json
---@param t any @任意表
---@return json
function api_json.encode(t)
    return cjson.encode(t)
end

---转table
---@param s json @json数据
---@return any @表格式
function api_json.decode(s)
    return cjson.decode(s)
end

return api_json