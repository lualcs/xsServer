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


---@class enumCompare  @大小枚举
---@field equality   number  @0相等
---@field greater    number  @1大于
---@field lessthan   number @-1小于


---@class wbListenInf @监听信息
---@field host          ip       @地址
---@field port          port     @端口
---@field protocol      string   @类型 "ws"


---@class serviceInf @服务信息
---@field share         service  @共享服务
---@field debug         service  @调试服务
---@field soles         service  @唯一服务
---@field single        service  @单人游戏
---@field gates         service  @入口服务
---@field login         service  @登陆服务


---@class mapServers @监听信息
---@field debug address     @调试
---@field login address     @登陆
---@field gate  address     @入口


---@class playerInfo @玩家信息
---@field userID    userID   @玩家ID
---@field coin      score    @玩家分数
---@field name      name     @玩家名子
---@field logo      url      @玩家头像


---@class client @前端信息
---@field address       host        @地址
---@field tablesvc      service     @所在桌子
---@field baseinf       playerInfo  @玩家信息    