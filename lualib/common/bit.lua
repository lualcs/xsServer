--[[
	desc:lua λ����
]]
local maxbits = 64
local is_types = is_types
local is_int = is_int
local math = math
local table = table

bit = {}

--λ�������
local function _And(left,right)	--��  
    return (left == 1 and right == 1) and 1 or 0  
end  
  
local function _Or(left, right)	--��  
    return (left == 1 or right == 1) and 1 or 0  
end  
  
local function _Xor(left, right)	--���  
    return (left + right) == 1 and 1 or 0  
end 

local function base(left, right, op) --��ÿһλ����op���㣬Ȼ��ֵ����  
    if left < right then  
        left, right = right, left  
    end  
    local res = 0  
    local _shift = 1  
    while left ~= 0 do  
        local ra = left % 2    --ȡ��ÿһλ(���ұ�)  
        local rb = right % 2     
        res = _shift * op(ra,rb) + res  
        _shift = _shift * 2  
        left = math.modf( left / 2)  --����  
        right = math.modf( right / 2)  
    end  
    return res  
end

function bit.And(left, right)	--��λ��
    return base(left, right, _And)  
end  

function bit.Or(left, right)	--��λ��
    return base(left, right, _Or)  
end 

function bit.Not(left)	--��λȡ��
    return left > 0 and -(left + 1) or -left - 1  
end 

function bit.Xor(left, right)	--��λ���
    return base(left, right, _Xor)  
end  

function bit.Lsh(left, num)  --left����numλ  
    return left * (2 ^ num)  
end  
  
function bit.Rsh(left,num)  --right����numλ  
    return math.floor(left / (2 ^ num))  
end  
  
  
--λ��������
function bit.bit_set(s_int,b_i,e_i,n_int)
	
	if not is_types(is_int,s_int,b_i,e_i,n_int) then
		return nil,-1
	end
	
	if b_i <= 0 or e_i > maxbits then
		return nil,-2
	end
	
	if b_i > e_i then 
		return nil,-3
	end
	
	if n_int > 2 ^(e_i - b_i +1) - 1 then
		return nil,-4
	end
	
	local b_v = math.floor(s_int / (2 ^ e_i)) * (2 ^ e_i)
	
	local c_v = n_int * (2 ^ (b_i - 1))
	
	local e_v = s_int % (2 ^ (b_i - 1))
	
	return b_v + c_v + e_v
end

function bit.bit_get(src,begs,ends)
	if begs <= 0 or ends > maxbits then
        return
    end

	if begs > ends then
        return
    end

	src = math.floor(src / (2 ^ (begs - 1)))

	
	return src % (2 ^(ends - begs + 1))
end
