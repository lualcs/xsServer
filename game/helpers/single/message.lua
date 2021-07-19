--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local ipairs = ipairs
local class = require("class")
local senum = require("game.enum")
local table = require("extend_table")
local proto = require("api_websocket")
local gameMessage = require("game.message")
---@class killingMessage:gameMessage @游戏消息
local message = class(gameMessage)

return message