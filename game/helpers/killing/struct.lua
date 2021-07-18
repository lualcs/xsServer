--[[
    desc:结构
    auth:Carol Luo
]]

---@class hundredBetInf     @下注分数
---@field rid   userID      @下注用户
---@field area  senum       @下注区域
---@field coin  score       @下注分数

---@class hundredBankerInf     @庄家配置
---@field doorsill  base       @上庄门槛
---@field continue  count      @连庄次数
---@field minimum   count      @最少庄家
---@field maximum   count      @最多庄家

---@class hundredDeploy
---@field areas     table<senum,hundredAreaInf> @下注区域
---@field jettons   double[]                    @下注筹码
---@field bankers   hundredBankerInf            @庄家配置



---@class hundredRobotBetting
---@field area  senum       @下注区域
---@field chip  score       @下注分数

---@class hundredRobotstrategy @龙虎下注策略
---@field bets hundredRobotBetting[] @下注信息