--[[
    file:gameStruct.lua 
    desc:游戏结构
    auth:Caorl Luo
]]

---@alias historID number
---战绩ID

---@alias combatID number
---小局ID

---@alias office    any
---任意数据

---@alias gameInfos table<gameID,gameInfo>
---游戏信息列表
--- 

---@class gameCustom    @定制规则
---@field historID      historID    @战绩ID
---@field customs       custom[]

---@class custom
---@field field   string   @规则字段
---@field value   office   @规则数据

---@class playerInfo      @游戏玩家
---@field address   number   @服务地址
---@field userID    userID   @玩家ID
---@field seatID    seatID   @座位ID
---@field coin      score    @玩家分数
---@field name      name     @玩家名子
---@field logo      url      @玩家头像
---@field line      senum    @在线状态
---@field robot     boolean  @true:机器人 false:真人


---@class gameInfo     @游戏信息
---@field name          name        @游戏名子
---@field assignClass   senum       @分配类型
---@field importDeploy  path        @配置路径
---@field importTable   path        @桌子路径
---@field importPlayer  path        @玩家路径
---@field importAlgor   path        @游戏算法
---@field importHelper  path        @游戏辅助
---@field importSystem  path        @游戏策略
---@field importLogic   path        @游戏逻辑
---@field importType    path        @类型判断
---@field open          boolean     @游戏开关
---@field gameID        enum        @游戏ID
---@field minPlayer     count       @最少玩家
---@field maxPlayer     count       @最多玩家
---@field curPlayer     count       @当前玩家-动态数据
---@field sharedList    name[]      @共享模块


---@class gameMsg     @游戏消息
---@field channel      senum[] @类型
---@field details      any     @数据


---@class game_start_ntc            @开始通知
---@field gameCustom      custom    @定制规则


---@class message_see_info          @可见数据
---@field fields        any[]       @私有字段
---@field chairs        seatID[]    @可见位置