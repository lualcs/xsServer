--[[
	file:time.lua
	desc:时间函数 写一些常用的通用函数
]]

local os = os
local is_number = require("is_number")

local MIN_SEC = 60
local HOUR_SEC = MIN_SEC * 60
local DAY_SEC = HOUR_SEC * 24

---@class time 时间处理对象
local time = {}
local this = time


---@field tosdate 	时间戳转日期字符串
---@param time 		时间戳
function time.tosdate(time)
	return os.date("%Y-%m-%d-%H:%M:%S",time)
end

---@field totime 	日期转时间戳
---@param date 		日期表
function time.totime(date)
	return os.time(date)
end

---@field todate 	时间戳转日期表
---@param time 		时间戳
function time.todate(time)
	return os.date('*t',time)
end 

---@field toSecond 	日期表转秒间隔
---@param date 		日期表
function time.toSecond(date)
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


---@field clear_sfm 日期表时分秒置零
function time.clear_sfm(date)
	date.hour = 0
	date.min = 0
	date.sec = 0
    return os.time(date)
end

---@field todayMidnight 今日零点时间戳
---@return number
function time.todayMidnight()
    local date = os.date()
	this.clear_sfm(date)
    return this.totime(date)
end

---@field todayMoment 返回今日时间戳
---@param sfm		  时分秒日期
function time.todayMoment(sfm)
    local date = os.date()
    date.hour = sfm.hour
	date.min = sfm.min
	date.sec = sfm.sec
    return this.totime(date)
end


---@field diffYear    间隔年数
function time.diffYear(time1,time2)
	local date1 = this.todate(time1)
	local date2 = this.todate(time2)
	return date2.year - date1.year
end

---@field diffMonth    间隔月数
function time.diffMonth(time1,time2)
	local date1 = this.todate(time1)
	local date2 = this.todate(time2)
	local diff = date2.month - date1.month 
	if date1.year < date2.year then
		for i=date1.year,date2.year do
		end
		diff = diff - (12-date2.month)
	elseif date1.year > date2.year then
		for i=date2.year,date1.year do
			diff=diff-12
		end
	end
	return diff
end

---@field diffDay 间隔天数
---@param time1   时间戳1
---@param time2   时间戳2
function time.diffDay(time1,time2)
	time1 = time1 - (time1 % DAY_SEC)
	time2 = time2 - (time2 % DAY_SEC)
	return (time2 - time1)//DAY_SEC
end

---@field weekID    星期几
function time.weekID(time)
	local date = this.todate(time)
	local wday = date.wday
	if 0 == wday then
		wday = 7
	end
	return wday
end

---@field todayWeekID 今天是星期几
function time.todayWeekID()
	local now = os.time()
	return this.weekID(now)
end



return time