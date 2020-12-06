--[[
    file:gameType.lua 
    desc:游戏类型
    auth:Carol Luo
]]

---@class gameInfo                          @游戏信息
---@field name          string              @游戏名字
---@field open          boolean             @游戏开关
---@field minPlayer     count               @最少人数
---@field maxPlayer     count               @最多人数

---@type table<gameID,gameInfo>
return {
    [1] = {
        name = "炸金花",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [2] = {
        name = "牛牛",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [3] = {
        name = "三公",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [4] = {
        name = "三公",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [5] = {
        name = "扯旋",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [6] = {
        name = "龙虎斗",
        open = true,
        minPlayer = 1,
        maxPlayer = 100,
    },
    [7] = {
        name = "德州扑克",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [8] = {
        name = "斗地主",
        open = true,
        minPlayer = 3,
        maxPlayer = 3,
    },
    [9] = {
        name = "跑得快",
        open = true,
        minPlayer = 4,
        maxPlayer = 4,
    },
    [10] = {
        name = "拱猪",
        open = true,
        minPlayer = 4,
        maxPlayer = 4,
    },
    [11] = {
        name = "牌九",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
    [12] = {
        name = "十三水",
        open = true,
        minPlayer = 2,
        maxPlayer = 10,
    },
}