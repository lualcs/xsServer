--[[
    file:jjbx_struct.lua 
    desc:金鸡报喜
    auth:Carol Luo
]]


---@class jjbx_result_normal:slots_result_full 金鸡报喜结果
---@field heavyCost         slots_score[]   @重转成本
---@field widDouble         slots_double[]  @wild翻倍


---@class jjbx_game_cfg:slots_cfg 金鸡报喜配置
---@field heavyPro          double          @重转返还率
---@field heavymincost      slots_score     @最低重转成本
---@field nwdouble_weights table<postx,weight_info> @普通wild翻倍权重
---@field fwdouble_weights table<postx,weight_info> @免费wild翻倍权重
