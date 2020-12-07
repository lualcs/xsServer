--[[
    file:system.lua 
    desc:各种通用接口
    auth:Carol Luo
]]

---@class address @网址
---@field host ip|dns @ip地址|dns
---@field port port   @端口

---@class rmqUser @rmq登陆凭证
---@field username name @用户名字
---@field password password @用户密码
---@field vhost name @虚拟主机
---@field trailing_lf boolean @true启动跟踪功能
