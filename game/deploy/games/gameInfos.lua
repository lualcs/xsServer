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
        importStatus = "poker_zjh.zjh_status",
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
        importDeploy = "slots.games.jymtCfg",
        importTable  = "slots.jymt.jymtTable",
        importPlayer = "slots.jymt.jymtPlayer",
        importAlgor  = "slots.jymt.jymtAlgor",
        importHelper = "slots.jymt.jymtHelper",
        importSystem = "slots.jymt.jymtSystem",
        importLogic  = "slots.jymt.jymtAlgor",
        importType   = "slots.jymt.jymtType",
        importStatus = "slots.jymt.jymtStatus",
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
            "slots.games.jymtCfg",
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
        importDeploy = "slots.games.jjbxCfg",
        importTable  = "jjbx.jjbxTable",
        importPlayer = "jjbx.jjbxPlayer",
        importAlgor  = "jjbx.jjbxAlgor",
        importHelper = "jjbx.jjbxHelper",
        importSystem = "jjbx.jjbxSystem",
        importLogic  = "jjbx.jjbxAlgor",
        importType   = "jjbx.jjbxType",
        importStatus = "jjbx.jjbxStatus",
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
            "slots.games.jjbxCfg",
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
        importStatus = "dragonTiger.dragonTigerStatus",
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
        importStatus = "mahjong_scxz.scxz_status",
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