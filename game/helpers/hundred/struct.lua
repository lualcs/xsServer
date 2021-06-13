--[[
    desc:结构
    auth:Carol Luo
]]

---@class hundredBetInf     @下注配置
---@field area  senum       @下注区域
---@field maxi  base        @最大下注
---@field odds  base        @区域赔率

---@class hundredBankerInf     @庄家配置
---@field doorsill  base       @上庄门槛
---@field continue  count      @连庄次数
---@field minimum   count      @最少庄家
---@field maximum   count      @最多庄家

---@class hundredDeploy
---@field areas     table<senum,hundredAreaInf> @下注区域
---@field jettons   double[]                    @下注筹码
---@field bankers   hundredBankerInf            @庄家配置