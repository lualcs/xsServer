--[[
    file:game\lualib\mahjongHelper.lua
    desc:麻将辅助 + 胡牌 + 听牌 算法
    auto:Carol Luo
]]

local ipairs = ipairs
local pairs = pairs
local setmetatable = setmetatable
local skynet = require("skynet")
local mahjongName = require("mahjongName")
local table = require("extend_table")
local math = require("extend_math")
local sort = require("extend_sort")
local tostring = require("extend_tostring")


---@class 麻将辅助对象
local helper = {}
local this = helper

---@field getColor 麻将花色
function helper.getColor(mj)
    return math.floor(mj/16)
end

---@field getValue 麻将值
function helper.getValue(mj)
    return mj % 16
end

---@field getCard 合成麻将
function helper.getCard(color,card)
    return color * 16 + card
end

---@field is_wan 万
function helper.is_wan(mj)
    return 0 == this.getColor(mj)
end

---@field is_tiao 条
function helper.is_tiao(mj)
    return 1 == this.getColor(mj)
end

---@field is_tong 筒
function helper.is_tong(mj)
    return 2 == this.getColor(mj)
end

---@field is_wtt 万条筒
function helper.is_wtt(mj)
    return mj >= 0x01 and mj <= 0x29
end

---@field is_zi 东南西北中发白
function helper.is_zi(mj)
    return 3 == this.getColor(mj)
end

---@field is_hua 春夏秋冬菊梅兰竹
function helper.is_hua(mj)
    return 4 == this.getColor(mj)
end

---@field is_feng 东南西北
function helper.is_feng(mj)
    return mj >= 0x31 and mj <= 0x34
end

---@field is_zfb 中发白
function helper.is_zfb(mj)
    return mj >= 0x35 and mj <= 0x37
end

---@field getName 单张麻将名字
function helper.getName(mj)
    return mahjongName[mj]
end

---@field getString 多张扑克名字
function helper.getString(mjCard)
    local t = table.fortab()
    for _,mj in ipairs(mjCard) do
        table.insert(t,this.getName(mj))
    end
    return table.concat(t)
end

return helper

