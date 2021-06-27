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
local bullMessage = require("bull.message")
---@class bullRobBankerMessage:bullMessage @游戏消息
local message = class()

---构造函数
function message:ctor()
end

return message