local private = {}
local public = {}

---合并表
function public.merge(...)
    local tabs = {...}

    if not tabs then
        return {}
    end

    local origin = {}

    for i = 1, #tabs do
        if origin then
            if tabs[i] then
                for k, v in pairs(tabs[i]) do
                    if (type(k) == "string") then
                        origin[k] = v
                    else
                        table.insert(origin, v)
                    end
                end
            end
        else
            origin = tabs[i]
        end
    end

    return origin
end

---获取table所有键
---@param tab table 表
---@return table 键表
function public.keys(tab)
    local keys = {}

    for k, _ in pairs(tab) do
        table.insert(keys, k)
    end

    return keys
end

---获取table所有值
---@param tab table 表
---@return table 值表
function public.values(tab)
    local values = {}

    for _, v in pairs(tab) do
        table.insert(values, v)
    end

    return values
end

---克隆表
---@param tab table 表
---@param deep boolean 是否深度克隆
---@return table 克隆表
function public.clone(tab, deep)
    local copy = {}

    for k, v in pairs(tab) do
        if deep and type(v) == "table" then
            v = public.clone(v, deep)
        end

        copy[k] = v
    end

    return setmetatable(copy, getmetatable(tab))
end

---检测table是否是数组
---@param tab table 表
---@return boolean 是否是数组
function public.is_array(tab)
    if type(tab) ~= "table" then
        return false
    end

    local n = #tab

    for i, v in pairs(tab) do
        if type(i) ~= "number" then
            return false
        end

        if i > n then
            return false
        end
    end

    return true
end

---将数组拼接成字符串
---@param arr table 数组
---@param delimiter string 分隔符
---@return string 字符串
function public.join(arr, delimiter)
    local str = ""

    for i, v in pairs(arr) do
        if (i == 1) then
            str = str .. v
        else
            str = str .. delimiter .. v
        end
    end

    return str
end

return public
