
--设置tostring 好做打印 调试
local function set_mt_tostring(t)
    local mt_tostring = t.__tostring
    t.__tostring = nil
    setmetatable(t,{__tostring=mt_tostring})
end

--1:各种刻子
local wan111 = {[0x11]=3,__tostring = function() return "wan111" end}  set_mt_tostring(wan111)
local wan222 = {[0x12]=3,__tostring = function() return "wan222" end}  set_mt_tostring(wan222)
local wan333 = {[0x13]=3,__tostring = function() return "wan333" end}  set_mt_tostring(wan333)
local wan444 = {[0x14]=3,__tostring = function() return "wan444" end}  set_mt_tostring(wan444)
local wan555 = {[0x15]=3,__tostring = function() return "wan555" end}  set_mt_tostring(wan555)
local wan666 = {[0x16]=3,__tostring = function() return "wan666" end}  set_mt_tostring(wan666)
local wan777 = {[0x17]=3,__tostring = function() return "wan777" end}  set_mt_tostring(wan777)
local wan888 = {[0x18]=3,__tostring = function() return "wan888" end}  set_mt_tostring(wan888)
local wan999 = {[0x19]=3,__tostring = function() return "wan999" end}  set_mt_tostring(wan999)

local suo111 = {[0x21]=3,__tostring = function() return "suo111" end}   set_mt_tostring(suo111)
local suo222 = {[0x22]=3,__tostring = function() return "suo222" end}   set_mt_tostring(suo222)
local suo333 = {[0x23]=3,__tostring = function() return "suo333" end}   set_mt_tostring(suo333)
local suo444 = {[0x24]=3,__tostring = function() return "suo444" end}   set_mt_tostring(suo444)
local suo555 = {[0x25]=3,__tostring = function() return "suo555" end}   set_mt_tostring(suo555)
local suo666 = {[0x26]=3,__tostring = function() return "suo666" end}   set_mt_tostring(suo666)
local suo777 = {[0x27]=3,__tostring = function() return "suo777" end}   set_mt_tostring(suo777)
local suo888 = {[0x28]=3,__tostring = function() return "suo888" end}   set_mt_tostring(suo888)
local suo999 = {[0x29]=3,__tostring = function() return "suo999" end}   set_mt_tostring(suo999)

local ton111 = {[0x31]=3,__tostring = function() return "ton111" end}   set_mt_tostring(ton111)
local ton222 = {[0x32]=3,__tostring = function() return "ton222" end}   set_mt_tostring(ton222)
local ton333 = {[0x33]=3,__tostring = function() return "ton333" end}   set_mt_tostring(ton333)
local ton444 = {[0x34]=3,__tostring = function() return "ton444" end}   set_mt_tostring(ton444)
local ton555 = {[0x35]=3,__tostring = function() return "ton555" end}   set_mt_tostring(ton555)
local ton666 = {[0x36]=3,__tostring = function() return "ton666" end}   set_mt_tostring(ton666)
local ton777 = {[0x37]=3,__tostring = function() return "ton777" end}   set_mt_tostring(ton777)
local ton888 = {[0x38]=3,__tostring = function() return "ton888" end}   set_mt_tostring(ton888)
local ton999 = {[0x39]=3,__tostring = function() return "ton999" end}   set_mt_tostring(ton999)

local dfeng111  = {[0x41]=3,__tostring = function() return "dfeng111" end}      set_mt_tostring(dfeng111)
local nfeng222  = {[0x42]=3,__tostring = function() return "nfeng222" end}      set_mt_tostring(nfeng222)
local xfeng333  = {[0x43]=3,__tostring = function() return "xfeng333" end}      set_mt_tostring(xfeng333)
local bfeng444  = {[0x44]=3,__tostring = function() return "bfeng444" end}      set_mt_tostring(bfeng444)
local hzong111  = {[0x45]=3,__tostring = function() return "hzong111" end}      set_mt_tostring(hzong111)
local facai222  = {[0x46]=3,__tostring = function() return "facai222" end}      set_mt_tostring(facai222)
local baban222  = {[0x47]=3,__tostring = function() return "baban222" end}      set_mt_tostring(baban222)

--2:各种顺子
local wan123    = {[0x11]=1,[0x12]=1,[0x13]=1,__tostring = function() return "wan123"  end} set_mt_tostring(wan123) 
local suo123    = {[0x21]=1,[0x22]=1,[0x23]=1,__tostring = function() return "suo123"  end} set_mt_tostring(suo123)
local ton123    = {[0x31]=1,[0x32]=1,[0x33]=1,__tostring = function() return "ton123"  end} set_mt_tostring(ton123)
local dnx123    = {[0x41]=1,[0x42]=1,[0x43]=1,__tostring = function() return "dnx123"  end} set_mt_tostring(dnx123)
local zfb123    = {[0x45]=1,[0x46]=1,[0x47]=1,__tostring = function() return "zfb123"  end} set_mt_tostring(zfb123)

local wan234    = {[0x12]=1,[0x13]=1,[0x14]=1,__tostring = function() return "wan234" end} set_mt_tostring(wan234)
local suo234    = {[0x22]=1,[0x23]=1,[0x24]=1,__tostring = function() return "suo234" end} set_mt_tostring(suo234)
local ton234    = {[0x32]=1,[0x33]=1,[0x34]=1,__tostring = function() return "ton234" end} set_mt_tostring(ton234)
local xnb234    = {[0x42]=1,[0x43]=1,[0x44]=1,__tostring = function() return "feng234" end} set_mt_tostring(xnb234)

local wan345 = {[0x13]=1,[0x14]=1,[0x15]=1,__tostring = function() return "wan345" end} set_mt_tostring(wan345)
local suo345 = {[0x23]=1,[0x24]=1,[0x25]=1,__tostring = function() return "suo345" end} set_mt_tostring(suo345)
local ton345 = {[0x33]=1,[0x34]=1,[0x35]=1,__tostring = function() return "ton345" end} set_mt_tostring(ton345)

local wan456 = {[0x14]=1,[0x15]=1,[0x16]=1,__tostring = function() return "wan456" end} set_mt_tostring(wan456)
local suo456 = {[0x24]=1,[0x25]=1,[0x26]=1,__tostring = function() return "suo456" end} set_mt_tostring(suo456)
local ton456 = {[0x34]=1,[0x35]=1,[0x36]=1,__tostring = function() return "ton456" end} set_mt_tostring(ton456)

local wan567 = {[0x15]=1,[0x16]=1,[0x17]=1,__tostring = function() return "wan567" end} set_mt_tostring(wan567)
local suo567 = {[0x25]=1,[0x26]=1,[0x27]=1,__tostring = function() return "suo567" end} set_mt_tostring(suo567)
local ton567 = {[0x35]=1,[0x36]=1,[0x37]=1,__tostring = function() return "ton567" end} set_mt_tostring(ton567)

local wan678 = {[0x16]=1,[0x17]=1,[0x18]=1,__tostring = function() return "wan678" end} set_mt_tostring(wan678)
local suo678 = {[0x26]=1,[0x27]=1,[0x28]=1,__tostring = function() return "suo678" end} set_mt_tostring(suo678)
local ton678 = {[0x36]=1,[0x37]=1,[0x38]=1,__tostring = function() return "ton678" end} set_mt_tostring(ton678)

local wan789 = {[0x17]=1,[0x18]=1,[0x19]=1,__tostring = function() return "wan789" end} set_mt_tostring(wan789)
local suo789 = {[0x27]=1,[0x28]=1,[0x29]=1,__tostring = function() return "suo789" end} set_mt_tostring(suo789)
local ton789 = {[0x37]=1,[0x38]=1,[0x39]=1,__tostring = function() return "ton789" end} set_mt_tostring(ton789)

--2:扑克隐射
local groupMap = {
    --万
    [0x11] = {wan123,wan111},
    [0x12] = {wan123,wan234,wan222},
    [0x13] = {wan123,wan234,wan345,wan333},
    [0x14] = {wan234,wan345,wan456,wan444},
    [0x15] = {wan345,wan456,wan567,wan555},
    [0x16] = {wan456,wan567,wan678,wan666},
    [0x17] = {wan567,wan678,wan789,wan777},
    [0x18] = {wan678,wan789,wan888},
    [0x19] = {wan789,wan999},

    --条
    [0x21] = {suo123,suo111},
    [0x22] = {suo123,suo234,suo222},
    [0x23] = {suo123,suo234,suo345,suo333},
    [0x24] = {suo234,suo345,suo456,suo444},
    [0x25] = {suo345,suo456,suo567,suo555},
    [0x26] = {suo456,suo567,suo678,suo666},
    [0x27] = {suo567,suo678,suo789,suo777},
    [0x28] = {suo678,suo789,suo888},
    [0x29] = {suo789,suo999},
	
	--筒
    [0x31] = {ton123,ton111},
    [0x32] = {ton123,ton234,ton222},
    [0x33] = {ton123,ton234,ton345,ton333},
    [0x34] = {ton234,ton345,ton456,ton444},
    [0x35] = {ton345,ton456,ton567,ton555},
    [0x36] = {ton456,ton567,ton678,ton666},
    [0x37] = {ton567,ton678,ton789,ton777},
    [0x38] = {ton678,ton789,ton888},
    [0x39] = {ton789,ton999},

    --字 乱三风
    [0x41] = {dnx123,dfeng111},
    [0x42] = {dnx123,xnb234,nfeng222},
    [0x43] = {dnx123,xnb234,xfeng333},
    [0x44] = {xnb234,bfeng444},
    [0x45] = {zfb123,hzong111},
    [0x46] = {zfb123,facai222},
    [0x47] = {zfb123,baban222},
}


return groupMap