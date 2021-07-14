--[[
    desc:支付
    auth:Carol Luo

    ('wdezlpcovtw8r8z5', 'os6bslan2zpwhcvt', 'https://pay.namaye.cn/api/index', 'http://47.242.144.81/index.php/pay/jiutong/index', 0, 0, 0, NULL, 1, NULL);
    ('b7cc864893a1bdb9', 'd7b213562a42df89edcc16ee15676762', 'http://api.whhsdb.com/api/', 'http://47.242.144.81/index.php/pay/potato/index', 0, 0, 0, NULL, 1, NULL);
    ('2106270097', 'd483bf2bc24e3550da315fdaad80a975', 'http://10ewg.com/pay/gateway/', 'http://47.242.144.81/index.php/pay/billion/index', 0, 0, 0, NULL, 1, NULL);
    ('10040', 'fail0ds6crhd7gshrkd98sswjp6xvjpj', 'http://34.96.171.121/Pay_Index.html', 'http://47.57.246.1/index.php/pay/feiyu/index', 0, 0, 0, NULL, 1, NULL);
    ('305', '8496006288a7d05d', 'http://47.243.48.145:8810/api_addOrder', 'http://47.242.144.81/pay/Payback_xinba/index', 0, 100, 0, 1625224493, 0, 'lj.PaymentXinBa');
    ('2021700189900', 'q87P72EtFprpPE3P', 'https://wosyjfsf-notice.rwghnhg.com/proxypay/order', 'http://47.242.144.81/pay/Payback_xiaomi/index', 0, 100, 0, 1625730999, 0, 'lj.PaymentXiaoMi');

]]

---支付配置
---@type table<name,payPalt>
return {
    ---玖通银联
    ["jtyl"] = {
        payURL = "https://pay.namaye.cn/api/index",     --支付请求地址
        bakURL = "https://pay.namaye.cn/api/index",     --支付完成回调
        ntcURL = "https://pay.namaye.cn/api/index",     --支付通知回调
        fmtMD5 = "%s|%d|%s|%s|%s|%s",                   --支付加密匹配 商户编号|n32Bid|支付数量|商户订单|支付回调|商户密匙
        fmtTXT = "%s/%s/bankpay?title=%s&amount=%d&clientip=%s&timestamp=%d&signed=%s&callback=%s",                                    --支付参数匹配
        appID  = "wdezlpcovtw8r8z5",                    --支付商家用户                                   
        appKey = "os6bslan2zpwhcvt",                    --支付商家密匙                                   
        amounts = {},                                   --支付支持面额
    },

}


---@class payPalt @支付平台
---@field payURL url        @支付请求地址
---@field bakURL url        @支付完成回调
---@field fmtMD5 string     @支付加密匹配
---@field fmtTXT string     @支付参数匹配
---@field appID  string     @支付商家用户
---@field appKey number[]   @支付支持面额