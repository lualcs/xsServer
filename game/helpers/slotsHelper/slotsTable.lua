--[[
    file:slotsTable.lua 
    desc:啦霸桌子
    auth:Carol Luo
]]

local ipairs = ipairs
local table = require("extend_table")
local class = require("class")
local gameTable = require("gameTable")
local slotsEnum = require("slotsEnum")

---@class slotsTable:gameTable @slots 桌子
local slotsTable = class(gameTable)
local this = slotsTable

---构造
function slotsTable:ctor()
    ---@type slots_cfg          @slots配置
    self._cfg       = self._cfg
    ---@type slotsLogic         @slots逻辑
    self._lgc     = self._lgc
end

---重启
function slotsTable:dataReboot()
    self:super(this,"dataReboot")
    ---@type slots_wight[]      @slots权重
    self._wgts      = nil
end

---获取游戏配置
---@return slots_inf
function slotsTable:getGameInfo()
    return self:super(this,"getGameInfo")
end

---获取唯一配置
---@return slots_icon[]
function slotsTable:getSoleIcon()
    local info = self:getGameInfo()
    return info.soleiconX
end

---获取游戏布局
---@return slots_layout_info
function slotsTable:getLayoutInfo()
    local info = self:getGameInfo()
    return info.layout
end

---获取所有图标权重配置
---@return slots_wight[][]
function slotsTable:getDoneIconWeights()
    local cfg = self._cfg
    local idx = cfg.free_weight_index
    local wgt = cfg.icons_weights
    return wgt
end

---获取免费图标权重配置
---@return slots_wight_info[]
function slotsTable:getFreeIconWeights()
    local cfg = self._cfg
    local idx = cfg.free_weight_index
    local wgt = cfg.icons_weights[idx]
    return wgt
end

---获取必杀图标权重配置
---@return slots_wight_info[]
function slotsTable:getKillIconWeights()
    local cfg = self._cfg
    local idx = cfg.kill_weight_index
    local wgt = cfg.icons_weights[idx]
    return wgt
end

---获取使用权重
---@return slots_wight_info[]
function slotsTable:getRunIconWeithts()
    return self._wgts
end

---设置使用权重
---@param wgts slots_wight_info[]
function slotsTable:setRunIconWeithts(wgts)
    self._wgts = wgts
end


---获取当前图标权重配置
function slotsTable:getCurrIconWeights()
    --返还率 = (产出+杀分)/总下注
    local ratio = 90
    local cfg = self._cfg
    local expects = cfg.expect_weights
    local index = 6
    for idx,_ratio in ipairs(expects) do
        if ratio <= _ratio then
            index = idx
            break
        end
    end
    return cfg.icons_weights[index]
end

---请求
---@param player    slotsPlayer     @玩家
---@param msg       messabeBody     @消息
function slotsTable:request(player,msg)
    local ok,result = self:super(this,"request",player,msg)
    if ok then
        return ok,result
    end
    local cmd = table.last(msg.cmds)
    if cmd == slotsEnum.spin() then
        --摇奖
        ok,result = self:onRotateNormal(player,msg)
    elseif cmd == slotsEnum.fpin() then
        --摇奖
        ok,result = self:onRotateFree(player,msg)
    elseif cmd == slotsEnum.xpin() then
        --重转
        ok,result = self:onRotateRoller(player,msg)
    end
    return ok,result
end

---正常摇将
---@param player    slotsPlayer              @玩家
---@param msg       slots_rotateNormal_msg   @摇奖
function slotsTable:onRotateNormal(player,msg)
    --正常摇奖
    local cfg = self._cfg
    local index = msg.details
    local jetton = cfg.jetton_pair[index]

    --检查下注
    if not jetton then
        return false,"非法下注"
    end

    --检查金币
    if player:getCoin() < jetton.total then
        return false,"您金币不足"
    end

    --检查免费
    if player:getFreeCount() > 0 then
        return false,"还有免费次数"
    end

    --扣除成本
    player:addCoin(-jetton.total)

    --设置权重
    local wgts = self:getCurrIconWeights()
    self:setRunIconWeithts(wgts)

    ---获取结果
    local result = self._lgc:rotateNormal()
    player:setLastNormal(result)
    ---保存免费
    return true,result
end

---免费摇将
---@param player    slotsPlayer              @玩家
---@param msg       slots_rotateNormal_msg   @摇奖
function slotsTable:onRotateFree(player,msg)
    if player:getFreeCount() <= 0 then
        return false,"没有免费次数"
    end

    --扣除成本
    player:addFreeCount(-1)

    --设置权重
    local wgts = self:getFreeIconWeights()
    self:setRunIconWeithts(wgts)

    local result = self._logic:rotateFree()

    player:setLastFree(result)
    return true,result
end


---重转摇将
---@param player        slotsPlayer              @玩家
---@param msg           messabeBody              @消息
function slotsTable:onRotateRoller(player,msg)
    --设置权重
    local wgts = self:getCurrIconWeights()
    self:setRunIconWeithts(wgts)
    --扣除成本
    local alxe = self._lgc:getCurAxle()
    local last = player:getLastResult()
    local cost = last.heavyCost[alxe]
    --检查金币
    if player:getCoin() < cost then
        return false,"您金币不足"
    end

    --扣除成本
    player:addCoin(-cost)

    local result = self._lgc:rotateRoller()
    player:setLastRoller(result)
    return true,result
end

return slotsTable