local private = {}
local public = {}

local string = string
local tostring = tostring
local tonumber = tonumber
local math = math
local table = table

--数字字母
private.alnum = {
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
}

--字母
private.alpha = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
}

--数字
private.numeric = {
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
}

--无0数字
private.nozero = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
}

---生成唯一GUID
---@return string GUID
function public.guid()
    local sid = public.alnum(32)

    return string.format(
        "%s-%s-%s-%s-%s",
        string.sub(sid, 1, 8),
        string.sub(sid, 9, 12),
        string.sub(sid, 13, 16),
        string.sub(sid, 17, 20),
        string.sub(sid, 21, 32)
    )
end

-- 生成账号为主体的全局唯一GUID
---@return string GUID
function public.guid_with_rid(rid)
    local sid = public.alnum(24)
    local str_rid = tostring(rid)

    local guid = ""

    for i = 1, 7 do
        local pos = 4*(i-1)+1
        guid = guid .. string.sub(str_rid, i, i) .. string.sub(sid, pos, pos+3)
    end
    
    guid = guid .. public.alnum(1)
    
    return string.format(
        "%s-%s-%s-%s-%s",
        string.sub(guid, 1, 8),
        string.sub(guid, 9, 12),
        string.sub(guid, 13, 16),
        string.sub(guid, 17, 20),
        string.sub(guid, 21, 32)
    ) 
end

-- token逆向解析
---@param token string @token
---@return number
function public.get_rid_in_token(token)

    if not token or type(token) ~= "string" then
        return nil
    end

    token = string.gsub(token, "-", "")

    local rid = ""

    for i = 1, 7 do
        local pos = 4*(i-1)+1+#rid
        rid = rid .. string.sub(token, pos, pos)
    end
    
    return math.tointeger(tonumber(rid))
end

---生成数字和字母混合的字符串
---@param length number 字符串长度(默认长度6)
---@return string 字符串
function public.alnum(length)
    length = length or 6

    local str = ""

    for i = 1, length do
        str = str .. private.alnum[math.random(1, #private.alnum)]
    end

    return str
end

---生成全是字母的字符串
---@param length number 字符串长度(默认长度6)
---@return string 字符串
function public.alpha(length)
    length = length or 6

    local str = ""

    for i = 1, length do
        str = str .. private.alpha[math.random(1, #private.alpha)]
    end

    return str
end

---生成全是数字的字符串
---@param length number 字符串长度(默认长度6)
---@return string 字符串
function public.numeric(length)
    length = length or 6

    local str = ""

    for i = 1, length do
        str = str .. private.numeric[math.random(1, #private.numeric)]
    end

    return str
end

---生成全是数字(没有0)的字符串
---@param length number 字符串长度(默认长度6)
---@return string 字符串
function public.nozero(length)
    length = length or 6

    local str = ""

    for i = 1, length do
        str = str .. private.nozero[math.random(1, #private.nozero)]
    end

    return str
end

---切割字符串
---@param str string 字符串
---@param delimiter string 分隔符
---@return table 数组
function public.split(str, delimiter)
    local arr = {}

    string.gsub(
        str,
        "[^" .. delimiter .. "]+",
        function(w)
            table.insert(arr, w)
        end
    )

    return arr
end

return public
