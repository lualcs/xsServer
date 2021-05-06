--[[
    file:gameInfos.lua 
    desc:游戏类型
    auth:Carol Luo
]]

local senum = require("gameEnum")

---@type table<gameID,gameInfo>
local gameInfos = {
    [1] = {
        name = "炸金花",
        assignClass  = false,--senum.assignKilling(),
        importDeploy = "poker.poker_zjh_cfg",
        importTable  = "poker_zjh.zjh_table",
        importPlayer = "poker_zjh.zjh_Player",
        importAlgor  = "poker_zjh.zjh_algor",
        importHelper = "poker_zjh.zjh_helper",
        importSystem = "poker_zjh.zjh_system",
        importLogic  = "poker_zjh.zjh_algor",
        importType   = "poker_zjh.zjh_type",
        open = senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块
            
        }
    },
    [2] = {
        name = "牛牛",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [3] = {
        name = "三公",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [4] = {
        name = "牌九",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [5] = {
        name = "扯旋",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 8,
        sharedList = { --共享模块

        }
    },
    
    [6] = {
        name = "德州扑克",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [7] = {
        name = "斗地主",
        open = false,--senum.people(),
        minPlayer = 3,
        curPlayer = 0,
        maxPlayer = 3,
        sharedList = { --共享模块

        }
    },
    [8] = {
        name = "跑得快",
        open = false,--senum.people(),
        minPlayer = 4,
        curPlayer = 0,
        maxPlayer = 4,
        sharedList = { --共享模块

        }
    },
    [9] = {
        name = "拱猪",
        open = false,--senum.people(),
        minPlayer = 4,
        curPlayer = 0,
        maxPlayer = 4,
        sharedList = { --共享模块

        }
    },
    [10] = {
        name = "牌九",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [11] = {
        name = "十三水",
        open = false,--senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [10001] = {
        name = "金玉满堂",
        open = true,
        assignClass  = senum.assignSingle(),
        importDeploy = "slots.games.slots_jymt_cfg",
        importTable  = "slots.jymt.jymt_table",
        importPlayer = "slots.jymt.jymt_Player",
        importAlgor  = "slots.jymt.jymt_algor",
        importHelper = "slots.jymt.jymt_helper",
        importSystem = "slots.jymt.jymt_system",
        importLogic  = "slots.jymt.jymt_algor",
        importType   = "slots.jymt.jymt_type",
        minPlayer = 1,
        curPlayer = 0,
        maxPlayer = 1000,
        ---@type slots_layout_info
        layout = {
            maximumX = 5,
            maximumY = 3,
        },

        ---@type slots_icon[] @转轴只能出现一次
        soleiconX = {
            10,--Scatter
        },

        ---@type path[]
        sharedList = { --共享模块
            "slots.games.slots_jymt_cfg",
        },

        ---@type boolean @是否双向
        bothway = false,
        ---@type boolean @是否满线
        fulllin = true,
    },
    [10002] = {
        name = "金鸡报喜",
        open = true,
        assignClass  = senum.assignSingle(),
        importDeploy = "slots.games.slots_jjbx_cfg",
        importTable  = "jjbx.jjbx_table",
        importPlayer = "jjbx.jjbx_Player",
        importAlgor  = "jjbx.jjbx_algor",
        importHelper = "jjbx.jjbx_helper",
        importSystem = "jjbx.jjbx_system",
        importLogic  = "jjbx.jjbx_algor",
        importType   = "jjbx.jjbx_type",
        minPlayer = 1,
        curPlayer = 0,
        maxPlayer = 1000,
        ---@type slots_layout_info
        layout = {
            maximumX = 5,
            maximumY = 3,
        },

        ---@type slots_icon[] @转轴只能出现一次
        soleiconX = {
            10,--Scatter
        },

        ---@type path[]
        sharedList = { --共享模块
            "slots.games.slots_jjbx_cfg",
        },

        ---@type boolean @是否双向
        bothway = false,
        ---@type boolean @是否满线
        fulllin = true,
    },
    [20001] = {
        name = "龙虎斗",
        open = senum.timer(),
        assignClass  = senum.assignSingle(),
        importDeploy = "hundred.games.dragonTiger",
        importTable  = "dragonTiger.dragonTigerTable",
        importPlayer = "dragonTiger.dragonTigerPlayer",
        importAlgor  = "dragonTiger.dragonTigerAlgor",
        importHelper = "dragonTiger.dragonTigerHelper",
        importSystem = "dragonTiger.dragonTigerSystem",
        importLogic  = "dragonTiger.dragonTigerAlgor",
        importType   = "dragonTiger.dragonTigerType",
        minPlayer = 1,
        curPlayer = 0,
        maxPlayer = 100,
        minBanker = 1,
        curBanker = 0,
        maxBanker = 1,
        sharedList = { --共享模块
            "hundred.games.dragonTiger"
        }
    },
    [30001] = {
        name = "血战麻将",
        open = false,--senum.people(),
        minPlayer = 4,
        curPlayer = 0,
        maxPlayer = 4,
        assignClass  = "assignKilling",
        importDeploy = "mahjong.deploy.scxzConfig",
        importTable  = "mahjong_scxz.scxz_table",
        importPlayer = "mahjong_scxz.scxz_Player",
        importAlgor  = "mahjong_scxz.scxz_algor",
        importHelper = "mahjong_scxz.scxz_helper",
        importSystem = "mahjong_scxz.scxz_system",
        importLogic  = "mahjong_scxz.scxz_algor",
        importType   = "mahjong_scxz.scxz_type",
        sharedList = { --共享模块
            "mahjong.mapHuCards",
            "mahjong.mapNames",
            "mahjong.mapSnaps",
            "mahjong.mapViews",
            "mahjong.deploy.scxzConfig",
        }
    },
}

---自动填充
for gameID,gameInfo in pairs(gameInfos) do
    gameInfo.gameID = gameID
end


return gameInfos