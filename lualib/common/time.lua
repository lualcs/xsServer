--[[
	file:time.lua
	desc:时间函数 写一些常用的通用函数
]]

local os = os
local is_number = require("is_number")

local MIN_SEC = 60
local HOUR_SEC = MIN_SEC * 60
local DAY_SEC = HOUR_SEC * 24

local time = {}


--将一个数值时间打印成为一个日期时间
function time.tosdate(time)
	return os.date("%Y-%m-%d-%H:%M:%S",time)
end

--将一个日期转换成一个数值时间
function time.totime(date)
	return os.time(date)
end
--将一个数值时间转化成一个日期表
function time.todate(time)
	return os.date('*t',time)
end 

--[[将一个日期表写成一个cd时间
	最大只支持天单位
	因为年,月 单位的时间是不固定的
]]
function time.totime(date)
	local second = 0
	if is_number(date.day) then
		second = second + DAY_SEC * date.day
	end
	if is_number(date.hour) then
		second = second + HOUR_SEC * date.hour
	end
	if is_number(date.min) then
		second = second + MIN_SEC * date.min
	end
	if is_number(date.sec) then
		second = second + date.sec
	end

	return second
end


--将一个日期表的 时 分 秒 清零
function time.clear_sfm(date)
	date.hour = 0
	date.min = 0
	date.sec = 0
    return os.time(date)
end

--获得今天0点 + {hour,min,sec}
function time.day_time(h,m,s)
    local now_date = os.date()
    now_date.hour = h
	now_date.min = m
	now_date.sec = s
    return os.time(now_date)
end
function time.day_timeEx(toDate)
    local now_date = os.date()
    now_date.hour = toDate.hour
	now_date.min = toDate.hour
	now_date.sec = toDate.hour
    return os.time(now_date)
end

--判断2段数值时间 间隔天数
function time.diffday(iTime1,iTime2)
	--取模除去干扰数值
	iTime1 = iTime1 - (iTime1 % DAY_SEC)
	iTime2 = iTime2 - (iTime2 % DAY_SEC)
	
	return (iTime1 - iTime2) / DAY_SEC
end

--判断2段数值时间 间隔 年准确 其他的 保证冲要条件才准确
function time.diff(iTime1,iTime2,key)
	local tDate1 = time.todate(iTime1)
	local tDate2 = time.todate(iTime2)
	return tDate1[key] - tDate2[key]
end

--获得本周序号
function time.get_week(iTime)
	local wday = time.todate(iTime).wday
	if 0 == wday then
		wday = 7
	end
	return wday
end

--当前是星期几
function time.now_week()
	local wday = os.date('w')
	if 0 == wday then
		wday = 7
	end
	return wday
end

--获得明天的日期
function time.tomorrow(now_date)
	local now_time = time.totime(now_date)
	now_time = now_time + DAY_SEC
	return time.toDate(now_time)
end
--获得明天的时间戳
function time.tomorrowEx(now_date)
	local now_time = time.totime(now_date)
	now_time = now_time + DAY_SEC
	return now_time
end

--判断是否是一天结束
function time.is_day_end(iTime)
    local date = time.todate(iTime)
    return 0 == date.hour and 0 == date.min and 0 == date.sec
end
--获取CD_SEC结束的时间戳
function time.get_sec_end(CD_SEC,iTime,is_day)
    if not is_day or CD_SEC ~= DAY_SEC then
        return iTime - (iTime % CD_SEC) + CD_SEC
    --对天特殊处理
    elseif is_day then
        --获取时间戳的日期
        local date = time.todate(iTime)
        --清除时分秒
        time.format_hms(date)
        return time.totime(date)
    end
end

--检查是否是CD_SEC时间最后一秒
function time.is_sec_end(CD_SEC,iTime,is_day)
    if 0 ~= iTime and CD_SEC < DAY_SEC then
        return 0 == iTime % CD_SEC
    end
    --is_day 对天结束做判断处理
    if 0 ~= iTime and CD_SEC == DAY_SEC and is_day then
        return time.is_day_end(iTime)
    end
end


return time