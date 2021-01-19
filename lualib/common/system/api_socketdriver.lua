--[[
    file:api_socketdriver.lua
    desc: 
    auth:Carol Luo
]]

local socketdriver = require("skynet.socketdriver")

---@class api_socketdriver
local api_socketdriver = {nil}
local this = api_socketdriver

---无延时
---@param fd socket
function api_socketdriver.nodelay(fd)
    socketdriver.nodelay(fd)
end


return api_socketdriver