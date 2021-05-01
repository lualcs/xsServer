--[[
    desc:mongo
    auth:Carol Luo
]]

local pairs = pairs
local ipairs = ipairs
local skynet = require("skynet.manager")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()

local mongomanager = require("mongomanager")

---@class service_mysql @mysql服务
local service = {}
local this = service

---启动
---@param simport string @相对路径
function service.start() 
  --共享数据
  local adrres = skynet.queryservice("service_share")
  local shares = skynet.call(adrres, "lua", "loading")
  for _,name in ipairs(shares) do
    local deploy = sharedata.query(name)
    _G.package.loaded[name] = deploy
  end

  this._manger = mongomanager.new(this)
  
  ---构造数据库
  --this._manger:dbstructure()

  skynet.retpack(false)
  skynet.register(".mongo")
end

---服务表
function service.gservices(name)
  local services = sharedata.query(name)
  ---@type serviceInf @服务地址信息
  this.services = services
  skynet.retpack(false)
end

---退出
function service.exit()
  skynet.exit()
  skynet.retpack(false)
end

skynet.start(function()
    skynet.dispatch("lua",function(_, _, cmd, ...)
            local f = this[cmd]
            if f then
              cs(f, ...)
            else
              local mgr = this._manger
              local f = mgr[cmd]
              cs(f,mgr,...)
            end
    end)
end)
