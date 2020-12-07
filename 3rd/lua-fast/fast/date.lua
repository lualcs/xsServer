local private = {}
local public = {}

---日期转时间戳
---@param datetime string 日期时间
---@return number 时间戳
function public.strtotime(datetime)
    local _, _, year, _, month, _, day, hour, _, min, _, sec =
        string.find(datetime, "(%d+)(.-)(%d+)(.-)(%d+)%s*(%d+)(.-)(%d+)(.-)(%d+)")

    return math.tointeger(os.time({year = year, month = month, day = day, hour = hour, min = min, sec = sec}))
end

---日期截断函数
---@param datetime string 日期时间
---@return string 只有年月日
function public.strtodate(datetime)
    local _, _, year, _, month, _, day, hour, _, min, _, sec =
        string.find(datetime, "(%d+)(.-)(%d+)(.-)(%d+)%s*(%d+)(.-)(%d+)(.-)(%d+)")
    local spacem, spacd = "", ""
    -- print(month,day,string.len(month),string.len(day),datetime)
    if string.len(month) < 2 then
        spacem = "0"
    end
    if string.len(day) < 2 then
        spacd = "0"
    end
    return year .. "-" .. spacem .. month .. "-" .. spacd .. day
end

---本周第一天
---@return string 第一天
function public.firstweekday()
    local time = os.time()

    local weekday = os.date("%w", time)

    if (weekday == 0) then
        weekday = 7
    end

    return os.date("%Y-%m-%d", time - (weekday - 1) * 24 * 3600)
end

---本周最后一天
---@return string 最后一天
function public.lastweekday()
    local time = os.time()

    local weekday = os.date("%w", time)

    if (weekday == 0) then
        weekday = 7
    end

    return os.date("%Y-%m-%d", time + (7 - weekday) * 24 * 3600)
end

---本月最后一天
---@return string 最后一天
function public.firstmonthday()
    return os.date("%Y-%m-01", os.time())
end

---本月第一天
---@return string 第一天
function public.lastmonthday()
    local time = os.time()

    local year = math.tointeger(os.date("%Y", time))

    local month = math.tointeger(os.date("%m", time))

    local day

    if (month == 1 or month == 3 or month == 5 or month == 7 or month == 8 or month == 10 or month == 12) then
        day = 31
    elseif (month == 2) then
        if (year % 4 == 0) then
            day = 29
        else
            day = 28
        end
    else
        day = 30
    end

    return os.date("%Y-%m-", time) .. day
end

return public
