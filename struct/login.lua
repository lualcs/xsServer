
--[[
    file:login.lua 
    desc:登陆结构
    auth:Carol Luo
]]


---@class c2s_loginTourists @游客登录
---@field accredit string @登录凭证

---@class c2s_loginAccount @账号登陆
---@field accounts string @用户账号
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
---@field accounts   string   @用户账号
---@field logolink   string   @用户头像
---@field rid        integer  @用户编号
---@field coin       score    @硬币分数
---@field silver     score    @银币分数
---@field gold       score    @金币分数
---@field masonry    score    @砖石分数


---@class role:s2c_loginResult @角色数据
---@field fd         socket   @套接字
---@field online     boolean  @在线吗