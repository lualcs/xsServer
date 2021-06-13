
--[[
    file:login.lua 
    desc:登陆结构
    auth:Carol Luo
]]


---@class c2s_loginTourists @游客登录
---@field accredit string @登录凭证

---@class c2s_loginAccount @账号登陆
---@field users string @用户账号
---@field password string @账号密码

---@class c2s_loginPhone @手机登录
---@field phonenum string @手机号码
---@field password string @账号密码

---@class c2s_loginWeChat @微信登陆
---@field accredit string @微信授权

---@class  c2s_changeNickname @更改昵称
---@field nickname string @新的昵称

---@class  c2s_changeLogolink @更改昵称
---@field logolink string @新的昵称

---@class s2c_loginResult   @登录结果
---@field loginMod   string   @登录方式
---@field loginBid   string   @绑定账号
---@field nickname   string   @用户昵称
---@field users   string   @用户账号
---@field logolink   string   @用户头像
---@field rid        integer  @用户编号
---@field coin       score    @硬币分数
---@field silver     score    @银币分数
---@field gold       score    @金币分数
---@field masonry    score    @砖石分数
---@field loginCount count    @登录次数


---@class role:s2c_loginResult @角色数据

---@class gateClient @连接信息
---@field address ip  @地址

---@class client @前端信息
---@field fd            socket           @套接字
---@field role          role             @角色数据
---@field online        boolean          @是否在线


---@class loginClient:client @网关用户信息
---@field assign        service         @所在分配
---@field table         service         @所在桌子