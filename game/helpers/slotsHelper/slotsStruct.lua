--[[
    file:slotsStruct.lua 
    desc:注释
    auth:Carol Luo
]]

---@alias postx         number
---x
---@alias posty         number
---y

---@alias slots_score   number
---分数

---@alias slots_base    number
---倍数

---@alias slots_double  number
---倍数

---@alias slots_count   number
---次数

---@alias slots_post    number
---3*5=0~14 4*5=0~19 位置

---@alias slots_icon    number
---图标

---@alias slots_weight  number
---权重

---@alias slots_axlepro number
---概率

---@alias slots_expect  number
---期望

---@alias slots_loss    number
---赔率

---@alias slots_axlels  table<xpost,table<slots_icon,count>>
---轴图标数量

---@alias slots_icons   table<slots_icon,count>
---图标统计

---@class slots_jetton @下注
---@field single    score   @单线下注
---@field total     score   @总线下注


---@class slots_scope @范围
---@field min     number  @最小
---@field max     number  @最大

---@class slots_inf:gameInfo
---@field layout        slots_layout_info @布局
---@field soleiconX     slots_icon[]      @唯一
---@field bothway       boolean           @双向
---@field fulllin       boolean           @满线

---@class slots_cfg @slots配置
---@field wild_icon             slots_icon                  @wild图标
---@field scatter_icon          slots_icon                  @scatter图标
---@field free_double           base                        @免费翻倍
---@field stageLevels           base[]                      @中奖展示
---@field icon_names            table<slots_icon,name>      @图标名字
---@field line_bases            table<leng,base>            @连线倍数
---@field scatter_free          table<count,count>          @触发免费
---@field jetton_pair           slots_jetton[]              @下注配置
---@field expect_weights        number[]                    @期望权重
---@field icons_weights         slots_wight[][]             @轴权重
---@field free_weight_index     index                       @免费权重
---@field kill_weight_index     index                       @强杀权重
---@field line_paths            slots_post[][]              @连线路径

---@class slots_wight_info
---@field sum   slots_weight        @总权重
---@field wgt   slots_weight[]      @权重表

---@class slots_rotateNormal_msg:messabeBody    @摇奖
---@field details slots_jetton          @下注

---@class slots_icon_post   @图标位置
---@field icon  slots_icon  @图标
---@field post  slots_post  @位置

---@class slots_line_path        @连线结果
---@field left_right        boolean             @true:从左到右边 false:从右到左边
---@field path_index        index               @路线下标
---@field line_again        slots_base          @连线倍数
---@field line_score        slots_score         @连线分数
---@field path_place        slots_icon_post[]   @连线位置       

---@class slots_full_path                   @连线结果-满线
---@field line_icon   slots_icon            @连线图标
---@field line_again  slots_base            @连线倍数
---@field line_score  slots_score           @连线分数
---@field path_place  slots_icon_post[]     @连线位置

---@class slots_result_normal               @slots摇奖结果
---@field game_jetton   slots_jetton            @下注信息
---@field game_cost     score                   @游戏成本
---@field gain_coin     score                   @获取奖金
---@field free_left     count                   @剩余免费
---@field free_push     count                   @增加免费
---@field game_type     senum                   @游戏类型
---@field icon_list     slots_icon[]            @图标结果
---@field line_list     slots_line_path[]       @连线结果


---@class slots_result_full:slots_result_normal @slots满线结果
---@field line_list     slots_full_path[]       @连线结果


---@class slots_layout_info                 @slots分布
---@field maximumX         number           @几个转轴
---@field maximumY         number           @多少行


---@class slots_ernie_normat    @正常摇奖 
---@field ernie_indx       index                @摇将下标


---@class slots_ernie_free      @免费摇奖 


---@class slots_ernie_alxe      @重转摇奖
---@field alxe              xpost              @重转轴