--[[
    file:baseService.lua 
    desc:桌子服务
    auto:Carol Luo
]]


local skynet = require("skynet")
local queue = require("skynet.queue")
local class = require("class")

local service = class("baseService")


function service.start(...)
  
end

function service.exit()
    skynet.exit()
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
        if cmd == "start" or cmd == "exit" then
            queue(service[cmd], ...)
        end
      end)
end)



return service