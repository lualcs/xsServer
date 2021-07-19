--[[
    desc:md5码使用
    auth:Carol Luo
]]

local string = string

local md5 = require ("md5.core")
local function f_bin2hex(s)
    s=string.gsub(s,"(.)",function (x) return string.format("%02x",string.byte(x)) end)
    return s
end

local h2b = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["a"] = 10,
    ["b"] = 11,
    ["c"] = 12,
    ["d"] = 13,
    ["e"] = 14,
    ["f"] = 15
}
local function f_hex2bin( hexstr )
    local s = string.gsub(hexstr, "(.)(.)", function ( h, l )
         return string.char(h2b[h]*16+h2b[l])
    end)
    return s
end

local api_md5 = {}

---md5加密
function api_md5.md5encode(s)
    return f_bin2hex(md5.crypt(s, "secretkey"))
end

---md5解密
function api_md5.md5decode(s)
    return md5.decrypt(f_hex2bin(s), "secretkey")
end

---md5编码小写
---@return string
function api_md5.md5Lowercase(src)
    return md5.md5_encode(src)
end

---md5编码大写
---@return string
function api_md5.md5Uppercase(src)
    local code = md5.md5_encode(src)
    return string.upper(code)
end

return api_md5
