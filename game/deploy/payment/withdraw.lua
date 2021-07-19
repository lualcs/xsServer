--[[
    desc:体现
    auth:Carol Luo
]]

---支付配置
---@type table<name,withdrawPlat>
return {
    ---玖通银联
    ["jtyl"] = {
        reqURL="https://pay.namaye.cn/api/index",       --提现请求地址
        bakURL="https://pay.namaye.cn/api/index",       --提现完成回调
        fmtMD5 = "",                                    --提现加密匹配
        fmtTXT = "",                                    --提现参数匹配
        argAPP = "",                                    --提现商家用户                                   
        argRMB = {},                                    --提现支持面额
        argCNT = {},                                    --提现货币数量
    },
}


---@class withdrawPlat @提现平台
---@field reqURL url        @支付请求地址
---@field bakURL url        @支付完成回调
---@field fmtMD5 string     @支付加密匹配
---@field fmtTXT string     @支付参数匹配
---@field argAPP string     @支付商家用户
---@field argRMB number[]   @支付支持面额
---@field argCNT number[]   @提现货币数量