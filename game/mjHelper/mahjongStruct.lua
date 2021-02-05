--[[
    file:mahjongStruct.lua 
    desc:通用结构
    auth:Carol Luo
]]

---@alias   mjCard  number
---麻将
---@alias   mjColor number
---花色
---@alias   mjValue number
---牌值
---@alias   mjCount number
---数量
---@alias   mjHands mjCard[]
---手牌
---@alias   mjMapkc table<mjCard,count>
---牌表
---@alias   mjTings table<mjCard,mjPeg>
---胡映射
---@alias   mjXuaks table<mjCard,mjTings>
---选映射
---@alias   mjClass table<index,table<mjValue,mjCount>>
---分类隐射
---@alias   mjGapls table<index,mjGap>

---@class   mjUnit                          @分类       
---@field   color   mjColor                 @花色
---@field   start   mjValue                 @开始
---@field   close   mjValue                 @结束
---@field   joint   boolean                 @顺子-true:可以成顺子 false:不能成顺
---@field   class   index                   @分类


---@class   mjFill:mjUnit                   @牌库
---@field   again   mjColor                 @几张

---@class   mjUsag                          @调用
---@field   player  mahjongPlayer           @玩家
---@field   mjFull  mjMapkc                 @牌库

---@class   mjPeg                           @胡牌
---@field   tlist   senum[]                 @牌型+加倍|加番
---@field   coeff   number                  @系数
---@field   count   number                  @张数

---@class   mjGap 
---@field   min     mjValue                 @最小
---@field   max     mjValue                 @最大
---@field   num     mjCount                 @数量

---@class   mjUnify                         @统一
---@field   lzcount mjCount                 @癞子
---@field   spcount mjCount                 @手牌
---@field   mjhands mjCard[]                @手牌-排序
---@field   mjMpasw mjMapkc                 @牌表
---@field   mjMpacw mjMapkc                 @花表
---@field   casCard mjCard                  @出牌
---@field   getCard mjCard                  @拿牌
---@field   mjClass mjClass                 @分类
---@field   mjGapls mjGapls                 @分类


---@class   mjCards                         @麻将
---@field   cards   mjCard[]                @数据

---@class   mjShow                          @展示
---@field   type    senum                   @动作
---@field   from    seatID                  @来源
---@field   cards   mjCard[]                @数据


---@class   mjCardInfo                      @牌数据
---@field   shows   mjShow[]                @展示
---@field   hands   mjCard[]                @手牌
---@field   expor   mjCard[]                @出牌
---@field   count   count                   @数量

---@class   mjBillDetail                    @流水详情
---@field   from    seatID                  @来源
---@field   score   score                   @分数
---@field   times   count                   @倍数
---@field   types   senum[]                 @类型

---@class   mjBillDetail                    @积分流水
---@field   score   score                   @分数
---@field   froms   seatID[]                @来源
---@field   types   senum[]                 @类型


---@class   mjhandle                        @麻将操作
---@field   type        senum               @操作类型
---@field   card        mjCard              @操作数据-可选
---@field   cards       mjCard[]            @操作数据-可选
---@field   cardList    mjCards[]           @操作数据-可选
---@field   value       number              @操作数据-可选

---@class   mjBehavior:mjhandle             @麻将行为
---@field   seatID      seatID              @操作玩家
---@field   fromID      seatID              @来源玩家