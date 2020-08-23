--[[
	�����㷨
]]

local is_number,is_string,is_table

local query = {}
--[[
	�۰���Һ���
]]
local uv_half
function query.binart(arry,comp,b_idx,e_idx,val)
	if not is_number(b_idx) then
		b_idx = 1
	end
	if not is_number(e_idx) then
		e_idx = #arry
	end
	while b_idx < e_idx do
		uv_half = math.floor((b_idx + e_idx) / 2)
		if 1 == comp(arry[uv_half],val) then
			b_idx = uv_half + 1
		elseif -1 == comp(arry[uv_half],val) then
			e_idx = uv_half - 1
		else
			return uv_half
		end
	end
end

--[[
	��������
]]
function query.traverse(arry,val,key)
	--�������
	if not key then
		for _k,_v in pairs(arry) do
			if _v == val then
				return _k
			end
		end
	--����table ����
	else
		for _k,_v in pairs(arry) do
			if is_table(_v) and _v[key] == val then
				return _k
			end
		end
	end
	
end

return query