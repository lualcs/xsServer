local cjson = require("cjson")

---@class cjson json
local json = {}

---转json
---@param t any @任意表
---@return json
function json.encode(t)
    return cjson.encode(t)
end

---转table
---@param s json @json数据
---@return any @表格式
function json.decode(s)
    return cjson.decode(s)
end

return json