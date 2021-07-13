--[[
    desc:支付
    auth:Carol Luo
]]

---支付配置
---@type table<name,payPalt>
return {
    ---玖通银联
    ["jtyl"] = {
        reqURL="https://pay.namaye.cn/api/index",       --支付请求地址
        bakURL="https://pay.namaye.cn/api/index",       --支付完成回调
        fmtMD5 = "",                                    --支付加密匹配
        fmtTXT = "",                                    --支付参数匹配
        argAPP = "",                                    --支付商家用户                                   
        argRMB = {},                                    --支付支持面额
    },
}


---@class payPalt @支付平台
---@field reqURL url        @支付请求地址
---@field bakURL url        @支付完成回调
---@field fmtMD5 string     @支付加密匹配
---@field fmtTXT string     @支付参数匹配
---@field argAPP string     @支付商家用户
---@field argRMB number[]   @支付支持面额