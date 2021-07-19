--[[
    desc:龙虎 
    auth:Caorl Luo 
]]


local class = require("class")
local senum = require("dragonTiger.enum")
local hundredAlgor = require("hundred.algor")
---@class dragonTigerAlgor:hundredAlgor
local algor = class(hundredAlgor)
local this = algor


---构造
function algor:ctor()
end


---比较
---@param   dragonCard pkCard @龙牌
---@param   tiger      pkCard @虎牌
---@return  senum 游戏结果
function algor:compare(dragonCard,tigerCard)
    ---辅助
    ---@type dragonTigerHelper
    local helper = self._hlp
    local dragonValue = helper.getValue(dragonCard)
    local tigerValue = helper.getValue(tigerCard)

    if dragonValue > tigerValue then
        return senum.dragon()
    elseif dragonValue < tigerValue then
        return senum.tiger()
    end
    return senum.peace()
end

return algor