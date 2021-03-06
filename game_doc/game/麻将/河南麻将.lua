--[[
    file:hntdh.lua 
    desc:河南推倒胡
    auth:Carol Luo
]]

--[[玩法
    [推倒胡]
]]

--[[流程
    [开局]
    [定庄]-[首轮随机]-[慌庄连庄]-[上局胡家当庄]
    [发牌]
    [打牌]
    [结束]
    [亮牌]
    [结算]
]]

--[[牌库
    [万1~9]*4
    [条1~9]*4
    [筒1~9]*4
]]

--[[牌型
    [平胡]*1
    [七对]*2
]]

--[[加倍
    [杠上花]*2
]]

--[[动作
    [下跑]-[不跑]-[跑一]-[跑二]-[跑三]
    [开局]-[动画]
    [发牌]-[闲家13张]-[庄家14张]
    [出牌]
    [摸牌]
    [碰牌]-[出牌]
    [暗杠]-[摸牌]
    [补杠]-[碰牌]-[摸牌]
    [点杠]-[出牌]
    [自摸]-[摸牌]
    [点炮]-[出牌]
    [抢杠]-[补杠]
]]

--[[结算
    [点炮]-[一家]
    [自摸]-[三家]
    [明杠]-[一家]-[点杠]-[补杠]
    [暗杠]-[三家]
    [胡牌]-[(底分)+(底分*跑分))*max(1,(加倍)*(牌型))}
    [杠牌]-[(底分)+(底分*跑分))*1}
    [得分]-[胡分+杠分]
]]

--[[税收
    [底分]-[轮抽]-[局抽]
    [赢分]-[轮抽]-[局抽]
]]

--[[功能
    [对局流程]
    [对局回顾]
    [对局回放]
]]




