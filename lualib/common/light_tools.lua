--[[
    fiel:light_tools.lua
    auth:lcs
    desc:Light logic tool
]]


local EARTH_RADIUS = 6378.137;

--Interface
light_tools = class('light_tools',sort,bit)

function light_tools:ctor()
end


-- is type
light_tools.is_datak = is_datak
light_tools.is_datav = is_datav
light_tools.is_nil = is_nil
light_tools.is_bool = is_bool
light_tools.is_number = is_number
light_tools.is_string = is_string
light_tools.is_function = is_function
light_tools.is_table = is_table
light_tools.is_userdata = is_userdata
light_tools.is_thread = is_thread
light_tools.is_int = is_int
light_tools.is_uint = is_uint
light_tools.is_positiveNumber = is_positiveNumber
light_tools.is_positiveInteger = is_positiveInteger
light_tools.is_negativeNumber = is_negativeNumber
light_tools.is_negativeInteger = is_negativeInteger
light_tools.is_float = is_float
light_tools.is_lowercase = is_lowercase
light_tools.is_uppercase = is_uppercase
light_tools.is_letter = is_letter
light_tools.is_ASCII = is_ASCII
light_tools.is_week = is_week
light_tools.is_types = is_types


--Detection index is out of bounds
function light_tools.is_bounds(typeTable,index)
    return is_uint(index) and typeTable.b_idx <= index and typeTable.e_idx >= index
end

--Whether sid
function light_tools.is_sid(v)
    return is_positiveInterger(v)
end


--table b
light_tools.table_get = table.get
light_tools.table_set = table.set
light_tools.table_removeEx = table.table_removeEx
light_tools.table_clear = table.clear
light_tools.table_clearEx = table.clearEx
light_tools.table_copy = table.copy
light_tools.copy_arr = table.copy_arr
light_tools.table_copy_sole = table.copy_sole
light_tools.table_sort = table.sort
light_tools.table_default = table.default
light_tools.table_fortab = table.fortab
light_tools.table_recycle = table.recycle
light_tools.table_recyckes = table.recyckes
light_tools.table_remove_card = table.remove_card
light_tools.table_copy_card = table.copy_card
light_tools.table_empty = table.empty
light_tools.table_random_hash = table.random_hash
light_tools.table_element_count = table.element_count
light_tools.table_zeroRead = table.zeroRead


--table e

--math b

light_tools.math_random = math.random
light_tools.math_min = math.min
light_tools.math_max = math.max
light_tools.math_floor = math.floor
light_tools.math_ceil = math.ceil

--math e

--bit b
--bit e

-- msg b

--天瑞云-发送短信验证码
function light_tools.sendNoteCodeTRY(strNumber,strNote)
    
   local szHost         = "api.1cloudsp.com"
   local accesskey      = "YRBmHfjjwcL8MURR"
   local secret         = "6JntFzAy6BVqaqyTfuvAGp68C5THU6sz"
   local sign           =  CIS.AN_T_URL("【蜂鸟联盟】")
   local templateId     = 152409
   local strCon         =  CIS.AN_T_URL(strNote);
   local strFmt         = "http://%s/api/v2/single_send?accesskey=%s&secret=%s&sign=%s&templateId=%d&mobile=%s&content=%s";

   local szGet = string.format(strFmt,szHost, accesskey,secret,sign, templateId,strNumber, strCon);
   CIS.toHttpGet(1,szGet);
end

--math begin
function light_tools.round(num)
    return math.floor( num + 0.5 )
end

function light_tools.GetRadian(d)
    return d * math.pi / 180.0;
end
-- Get the GPS distance in meters
function light_tools.GetDistanceRice(lng1, lat1, lng2, lat2)
	radLat1 = light_tools.GetRadian(lat1);
    radLat2 = light_tools.GetRadian(lat2);
    
    a = radLat1 - radLat2;
    
    b = light_tools.GetRadian(lng1) - light_tools.GetRadian(lng2);
    
	s = 2 * math.asin(math.sqrt(math.pow(math.sin(a / 2), 2) +
        math.cos(radLat1)*math.cos(radLat2)*math.pow(math.sin(b / 2), 2)));
        
	s = s * EARTH_RADIUS;
	s = light_tools.round(s * 10000) / 10000;
	return math.abs(s*1000)
end

--math end


