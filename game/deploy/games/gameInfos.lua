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
        assignClass  = senum.assignKilling(),
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
        open = senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [3] = {
        name = "三公",
        open = senum.people(),
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [4] = {
        name = "牌九",
        open = true,
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [5] = {
        name = "扯旋",
        open = true,
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 8,
        sharedList = { --共享模块

        }
    },
    
    [6] = {
        name = "德州扑克",
        open = true,
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [7] = {
        name = "斗地主",
        open = true,
        minPlayer = 3,
        curPlayer = 0,
        maxPlayer = 3,
        sharedList = { --共享模块

        }
    },
    [8] = {
        name = "跑得快",
        open = true,
        minPlayer = 4,
        curPlayer = 0,
        maxPlayer = 4,
        sharedList = { --共享模块

        }
    },
    [9] = {
        name = "拱猪",
        open = true,
        minPlayer = 4,
        curPlayer = 0,
        maxPlayer = 4,
        sharedList = { --共享模块

        }
    },
    [10] = {
        name = "牌九",
        open = true,
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [11] = {
        name = "十三水",
        open = true,
        minPlayer = 2,
        curPlayer = 0,
        maxPlayer = 10,
        sharedList = { --共享模块

        }
    },
    [10001] = {
        name = "金玉满堂",
        assignClass  = "assignSingle",
        importDeploy = "slots.games.slots_jymt_cfg",
        importTable  = "slots.jymt.jymt_table",
        importPlayer = "slots.jymt.jymt_Player",
        importAlgor  = "slots.jymt.jymt_algor",
        importHelper = "slots.jymt.jymt_helper",
        importSystem = "slots.jymt.jymt_system",
        importLogic  = "slots.jymt.jymt_algor",
        importType   = "slots.jymt.jymt_type",
        open = true,
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
    [20001] = {
        name = "金鸡报喜",
        assignClass  = "assignSingle",
        importDeploy = "slots.games.slots_jjbx_cfg",
        importTable  = "slots_jjbx.jjbx_table",
        importPlayer = "slots_jjbx.jjbx_Player",
        importAlgor  = "slots_jjbx.jjbx_algor",
        importHelper = "slots_jjbx.jjbx_helper",
        importSystem = "slots_jjbx.jjbx_system",
        importLogic  = "slots_jjbx.jjbx_algor",
        importType   = "slots_jjbx.jjbx_type",
        open = true,
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
        minPlayer = 1,
        curPlayer = 0,
        maxPlayer = 100,
        sharedList = { --共享模块

        }
    },
    [30001] = {
        name = "血战麻将",
        open = true,
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