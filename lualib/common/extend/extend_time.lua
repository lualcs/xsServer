--[[
	file:time.lua
	desc:ʱ�亯�� дһЩ���õ�ͨ�ú���
]]

local os = os
local is_number = require("is_number")

local MIN_SEC = 60
local HOUR_SEC = MIN_SEC * 60
local DAY_SEC = HOUR_SEC * 24

---@class time ʱ�䴦�����
local time = {}
local this = time


---ʱ���ת�����ַ���
---@param time 	time	@ʱ���
function time.tosdate(time)
	return os.date("%Y-%m-%d-%H:%M:%S",time)
end

---����תʱ���
---@param date 	date	@���ڱ�
function time.totime(date)
	return os.time(date)
end

---ʱ���ת���ڱ�
---@param time 	time	@ʱ���
function time.todate(time)
	return os.date('*t',time)
end 

---���ڱ�ת����
---@param date 	date	@���ڱ�
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


---���ڱ�ʱ��������
---@param date 	date	@���ڱ�
function time.clear_sfm(date)
	date.hour = 0
	date.min = 0
	date.sec = 0
    return os.time(date)
end

---�������ʱ���
---@return number
function time.todayMidnight()
    local date = os.date()
	this.clear_sfm(date)
    return this.totime(date)
end

---���ؽ���ʱ���
---@param sfm date ʱ��������
function time.todayMoment(sfm)
    local date = os.date()
    date.hour = sfm.hour
	date.min = sfm.min
	date.sec = sfm.sec
    return this.totime(date)
end


---�������
---@param time1 	time	@���ڱ�
---@param time2 	time	@���ڱ�
function time.diffYear(time1,time2)
	local date1 = this.todate(time1)
	local date2 = this.todate(time2)
	return date2.year - date1.year
end

---�������
---@param time1 	time	@���ڱ�
---@param time2 	time	@���ڱ�
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

---�������
---@param time1   ʱ���1
---@param time2   ʱ���2
function time.diffDay(time1,time2)
	time1 = time1 - (time1 % DAY_SEC)
	time2 = time2 - (time2 % DAY_SEC)
	return (time2 - time1)//DAY_SEC
end

---���ڼ�
---@param time 	time	@ʱ���
function time.weekID(time)
	local date = this.todate(time)
	local wday = date.wday
	if 0 == wday then
		wday = 7
	end
	return wday
end

---���������ڼ�
---@return number
function time.todayWeekID()
	local now = os.time()
	return this.weekID(now)
end



return time