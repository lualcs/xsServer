--[[
	file:time.lua
	desc:ʱ�亯�� дһЩ���õ�ͨ�ú���
]]

local os = os
local is_number = is_number

local MIN_SEC = 60
local HOUR_SEC = MIN_SEC * 60
local DAY_SEC = HOUR_SEC * 24

local time = {}

--��ü������ǰʱ��
function time.now()
    return os.time()
end

--��һ����ֵʱ���ӡ��Ϊһ������ʱ��
function time.tosdate(iTime)
	return os.date("%Y-%m-%d-%H:%M:%S",iTime)
end

--��һ������ת����һ����ֵʱ��
function time.totime(tData)
	return os.time(tData)
end
--��һ����ֵʱ��ת����һ�����ڱ�
function time.todate(iTime)
	return os.date('*t',iTime)
end 

--[[��һ�����ڱ�д��һ��cdʱ��
	���ֻ֧���쵥λ
	��Ϊ��,�� ��λ��ʱ���ǲ��̶���
]]
function time.tocd(tDate)
	local iCD = 0
	if is_number(tDate.day) then
		iCD = iCD + DAY_SEC * tDate.day
	end
	if is_number(tDate.hour) then
		iCD = iCD + HOUR_SEC * tDate.hour
	end
	if is_number(tDate.min) then
		iCD = iCD + MIN_SEC * tDate.min
	end
	if is_number(tDate.yaer) then
		iCD = iCD + tDate.sec
	end
end

--ͬ�����ֻ֧��Сʱ
function time.tocdEx(tDate)
    local iCD = 0
	if is_number(tDate.hour) then
		iCD = iCD + HOUR_SEC * tDate.hour
	end
	if is_number(tDate.min) then
		iCD = iCD + MIN_SEC * tDate.min
	end
	if is_number(tDate.yaer) then
		iCD = iCD + tDate.sec
	end
end

--��һ�����ڱ�� ʱ �� �� ����
function time.format_hms(tDate)
	tDate.hour = 0
	tDate.min = 0
	tDate.sec = 0
    return os.time(tDate)
end

--��ý���0�� + {hour,min,sec}
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

--�ж�2����ֵʱ�� �������
function time.diffday(iTime1,iTime2)
	--ȡģ��ȥ������ֵ
	iTime1 = iTime1 - (iTime1 % DAY_SEC)
	iTime2 = iTime2 - (iTime2 % DAY_SEC)
	
	return (iTime1 - iTime2) / DAY_SEC
end

--�ж�2����ֵʱ�� ��� ��׼ȷ ������ ��֤��Ҫ������׼ȷ
function time.diff(iTime1,iTime2,key)
	local tDate1 = time.todate(iTime1)
	local tDate2 = time.todate(iTime2)
	return tDate1[key] - tDate2[key]
end

--��ñ������
function time.get_week(iTime)
	local wday = time.todate(iTime).wday
	if 0 == wday then
		wday = 7
	end
	return wday
end

--��ǰ�����ڼ�
function time.now_week()
	local wday = os.date('w')
	if 0 == wday then
		wday = 7
	end
	return wday
end

--������������
function time.tomorrow(now_date)
	local now_time = time.totime(now_date)
	now_time = now_time + DAY_SEC
	return time.toDate(now_time)
end
--��������ʱ���
function time.tomorrowEx(now_date)
	local now_time = time.totime(now_date)
	now_time = now_time + DAY_SEC
	return now_time
end

--�ж��Ƿ���һ�����
function time.is_day_end(iTime)
    local date = time.todate(iTime)
    return 0 == date.hour and 0 == date.min and 0 == date.sec
end
--��ȡCD_SEC������ʱ���
function time.get_sec_end(CD_SEC,iTime,is_day)
    if not is_day or CD_SEC ~= DAY_SEC then
        return iTime - (iTime % CD_SEC) + CD_SEC
    --�������⴦��
    elseif is_day then
        --��ȡʱ���������
        local date = time.todate(iTime)
        --���ʱ����
        time.format_hms(date)
        return time.totime(date)
    end
end

--����Ƿ���CD_SECʱ�����һ��
function time.is_sec_end(CD_SEC,iTime,is_day)
    if 0 ~= iTime and CD_SEC < DAY_SEC then
        return 0 == iTime % CD_SEC
    end
    --is_day ����������жϴ���
    if 0 ~= iTime and CD_SEC == DAY_SEC and is_day then
        return time.is_day_end(iTime)
    end
end


return time