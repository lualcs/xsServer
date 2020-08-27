--[[
]]

local ipairs = ipairs

local pokerName = require("pokerName")
local table = require("extend_table")
local math = require("extend_math")
local sort = require("sort")

local helper = {}
local this = helper
function helper.getColor(v)
    return (v & 0x0f)>>4
end

function helper.getValue(v)
    return v & 0xf0
end

function helper.getName(v)
    return pokerName[v]
end

function helper.getString(arrCard)
    local t = table.fortab()
    for _,v in ipairs(arrCard) do
        table.insert(t,this.getName(v))
    end
    local s = table.concat(t)
    return s
end

--牌值比较
local function cardValCompare(a,b)
	return this.getValue(a) < this.getValue(b)
end

--扑克值排序
function helper.cardValSort(cardArr)
	table.sort(cardArr,cardValCompare)
end

--逻辑比较
local function cardLogicValCompare(a,b)
	return this.getLogicVal(a) < this.getLogicVal(b)
end

--逻辑值排序
function helper.cardLogicSort(cardArr)
	table.sort(cardArr,cardLogicValCompare)
end

--扑克乱序
function helper.shuffle(arrCard)
	sort.shuffle(arrCard)
end

--[[
    return {
        arrCard		= {拷贝扑克值},
		hasCard		= {扑克数量},
		has1		= {单牌扑克值},
		has2		= {对子扑克值},
		has3		= {三条扑克值},
		has4		= {炸弹扑克值},
		hasColor	= {花色值}
		wColor		= 花色数量
		wCnt		= 扑克数量
        wPoint      = 扑克点数-总点数
        wMajor      = 10以上扑克数量
        wLink       = 连续数量
		same1		= 单牌数量
		same2		= 对子数量
		same3		= 三条数量
		same4		= 四条数量
    }
]]

local an = {
    hasCard = table.fortab(),
	has1 = table.fortab(),
	has2 = table.fortab(),
	has3 = table.fortab(),
	has4 = table.fortab(),
	hasColor = table.fortab(),
	arrCard = table.fortab(),
}
function helper:getAnData(arrCard)
    table.clearEmpty(an)
	an.arrCard = table.copy(arrCard,an.arrCard)
	self:cardValSort(an.arrCard)
	an.wCnt = #(an.arrCard)
	
	local carVal,_count,_key,_color,_befor
	for k,v in ipairs(an.arrCard) do

		carVal = self:getValue(v)
		_color = self:getColor(v)
		_count = (an.hasCard[carVal] or 0) +1
		an.hasCard[carVal] = _count
		an.wPoint = (an.wPoint or 0) + math.min(10,carVal);
        if not an.hasColor[_color] then
		    an.wColor = (an.wColor or 0) + 1
        end

        if carVal > 10 then
            an.wMajor = (an.wMajor or 0) + 1
        end

        if 1 == k or _befor + 1 == carVal then
		    an.wLink = (an.wLink or 0) + 1
        else
            an.wLink = 1
        end
		
		an.hasColor[_color] = (an.hasColor[_color] or 0)+1
		
		if 1 <= _count then
			an.has1[carVal] = _count
		elseif 2 <= _count then
			an.has2[carVal] = _count
		elseif 3 <= _count then
			an.has3[carVal] = _count
		elseif 4 <= _count then
			an.has3[carVal] = _count
		end
		
		if 1 == _count then
			an.same1 = (an.same1 or 0)+1
		elseif 2 == _count then
			an.same2 = (an.same2 or 0)+1
			an.same1 = (an.same1 or 0)-1
		elseif 3 == _count then
			an.same3 = (an.same3 or 0)+1
			an.same2 = (an.same2 or 0)-1
		elseif 4 == _count then
			an.same4 = (an.same4 or 0)+1
			an.same3 = (an.same3 or 0)-1
		end
		
        _befor = carVal
	end

    --AK 判定
    if _befor == 13 and 1 == this.getValue(an.arrCard[1]) then
        an.wLink = (an.wLink or 0) + 1
    end

    table.default_zero(an)
	return an
end

return helper