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
local service = {}
local this = service

---启动
---@param simport string @相对路径
function service.start(simport) 
  --共享数据
  local adrres = skynet.queryservice("service_share")
  local shares = skynet.call(adrres, "lua", "loading")
  for _,name in ipairs(shares) do
    local deploy = sharedata.query(name)
    _G.package.loaded[name] = deploy
  end

  local import = require(simport)
  this.assign = import.new(this)
  
  skynet.register("." .. simport)
end

---服务表
function service.gservices(name)
  local services = sharedata.query(name)
  ---@type serviceInf @服务地址信息
  this.services = services
end

---退出
function service.exit()
  skynet.exit()
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
            local f = this[cmd]
            if f then
              cs(f, ...)
            else
              cs(this.assign[cmd], this.assign, ...)
            end
            skynet.retpack(false)
    end)
end)
