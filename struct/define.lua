--[[
    file:define.lua 
    desc:类型别名
    auth:Carol Luo
]]
--字符串类型别名
---@alias json string
---json数据
---
---@alias url string
---超链接
---
---@alias host url|ip
---目标地址

---@alias ip string
---ip
---
---@alias port string
---port
---
---@alias dns string
---域名
---
---@alias logo string
---头像
---
---@alias picture string
---图片
---
---@alias name string
---名字
---
---@alias path string
---路径
---
---@alias password string
---密码
---
---@alias senum string
---枚举
---
---@alias mysql_cmd string
---mysql 语句
---
---@alias double number
---浮点数
---
---@alias integer number
---整数
---
---@alias sec  number
---秒
---
---@alias MS number 
---豪秒
---
---@alias timeID  number
---定时ID
---
---@alias level  number
---表示有优先级
---
---@alias index number
---索引 
---
---@alias score number
---积分类型
---
---@alias base number
---倍数
---
---@alias leng number
---长度
---
---@alias gold number
---金币类型
---
---@alias diamond number
---砖石类型
---
---@alias userID number
---用户ID
---
---@alias seatID number
---座位ID
---
---@alias gameID number
---游戏ID
---
---@alias cardColor number
---0:方块 1:红桃 2:梅花 4:黑桃
---
---@alias cardValue number
---1~13:A~K
---
---@alias cardPoker number
---0x01~0x4f:方块A~大王
---
---数值数组别名
---@alias cards card[]
---数组牌
---
---@alias chairID number
---位置
---
---@alias mjCard number
---麻将0x01 ~ 0x48:1万~9万+1条~9条+1筒~9筒+东南西北中发白+春夏秋东梅兰菊竹
--- 
---@alias mjColor number
---1:万 2:条 3:筒 4:字 5:花
---
---@alias mjValue number
---麻将牌值1~9
---
---@alias sex boolean
---true:男 false:女
---
---@alias age number
---年龄
---
---@alias count number
---个数 
---
---复合类型
---
---@alias mjSnap table<mjValue,count>
---麻将1~9成扑(顺子 刻子)
---
---@alias mjSnaps mjSnap[]
---麻将成扑数组
---
---@alias mjSnapsMap table<mjValue,mjSnaps>