--[[
    desc:结构
    auth:Carol Luo
]]

---@class hundredBetInf     @下注信息
---@field area  senum       @下注区域
---@field bets  score       @下注分数

---@class hundredDeploy
---@field areas     table<senum,hundredAreaInf> @下注区域
---@field jettons   double[]                    @下注筹码