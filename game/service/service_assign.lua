--[[
    file:service_assign.lua 
    desc:游戏桌子调配
    auth:Carol Luo
]]

local ipairs = ipairs
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

---@class service_assign @分配服务
local service_assign = {}
local this = service_assign

---启动
---@param import string @相对路径
function service_assign.start(simport) 
  --共享数据
  local adrres = skynet.queryservice("service_share")
  local shares = skynet.call(adrres, "lua", "loading")
  for _,name in ipairs(shares) do
    local deploy = sharedata.query(name)
    _G.package.loaded[name] = deploy
  end

  local import = require(simport)
  this.assign = import.new(this)
  
  skynet.retpack(false)
  skynet.register("." .. simport)
end

---退出
function service_assign.exit()
  skynet.exit()
  skynet.retpack(false)
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
            if cmd == "start" or cmd == "exit" then
              cs(this[cmd], ...)
            else
              cs(this.assign[cmd], this.assign, ...)
            end
    end)
end)
