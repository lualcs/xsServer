--[[
    file:gameInfos.lua 
    desc:游戏类型
    auth:Carol Luo
]]

local senum = require("game.enum")

---@type table<gameID,gameInfo>
local gameInfos = {
    [1] = {
        name = "炸金花",
        assignClass         = false,
        importDeploy        = "poker.zjh.Cfg",
        importCompetition   = "poker.zjh.competition",
        importPlayer        = "poker.zjh.player",
        importAlgor         = "poker.zjh.algor",
        importHelper        = "poker.zjh.helper",
        importSystem        = "poker.zjh.system",
        importLogic         = "poker.zjh.logic",
        importType          = "poker.zjh.type",
        importStatus        = "poker.zjh.status",
        importError         = "poker.zjh.error",
        importMessage       = "poker.zjh.message",
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
        assignClass         = senum.assignSingle(),
        importDeploy        = "jymt.Cfg",
        importCompetition   = "jymt.competition",
        importPlayer        = "jymt.player",
        importAlgor         = "jymt.algor",
        importHelper        = "jymt.helper",
        importSystem        = "jymt.system",
        importLogic         = "jymt.algor",
        importType          = "jymt.type",
        importStatus        = "jymt.status",
        importError         = "jymt.error",
        importMessage       = "jymt.message",
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
            "jymt.Cfg",
        },

        ---@type boolean @是否双向
        bothway = false,
        ---@type boolean @是否满线
        fulllin = true,
    },
    [10002] = {
        name = "金鸡报喜",
        open = true,
        assignClass         = senum.assignSingle(),
        importDeploy        = "jjbx.Cfg",
        importCompetition   = "jjbx.competition",
        importPlayer        = "jjbx.player",
        importAlgor         = "jjbx.algor",
        importHelper        = "jjbx.helper",
        importSystem        = "jjbx.system",
        importLogic         = "jjbx.algor",
        importType          = "jjbx.type",
        importStatus        = "jjbx.status",
        importError         = "jjbx.error",
        importMessage       = "jjbx.message",
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
            "jjbx.Cfg",
        },

        ---@type boolean @是否双向
        bothway = false,
        ---@type boolean @是否满线
        fulllin = true,
    },
    [20001] = {
        name = "龙虎斗",
        open = senum.timer(),
        assignClass         = senum.assignSingle(),
        importDeploy        = "dragonTiger.Cfg",
        importCompetition   = "dragonTiger.competition",
        importPlayer        = "dragonTiger.player",
        importAlgor         = "dragonTiger.algor",
        importHelper        = "dragonTiger.helper",
        importSystem        = "dragonTiger.system",
        importLogic         = "dragonTiger.algor",
        importType          = "dragonTiger.type",
        importStatus        = "dragonTiger.status",
        importError         = "dragonTiger.error",
        importMessage       = "dragonTiger.message",
        minPlayer = 1,
        curPlayer = 0,
        maxPlayer = 100,
        minBanker = 1,
        curBanker = 0,
        maxBanker = 1,
        sharedList = { --共享模块
            "dragonTiger.Cfg"
        }
    },
    [30001] = {
        name = "血战麻将",
        open = false,--senum.people(),
        minPlayer = 4,
        curPlayer = 0,
        maxPlayer = 4,
        assignClass         = "assignKilling",
        importDeploy        = "mahjong.deploy.scxzConfig",
        importCompetition   = "mahjong.scxz.competition",
        importPlayer        = "mahjong.scxz.player",
        importAlgor         = "mahjong.scxz.algor",
        importHelper        = "mahjong.scxz.helper",
        importSystem        = "mahjong.scxz.system",
        importLogic         = "mahjong.scxz.algor",
        importType          = "mahjong.scxz.type",
        importStatus        = "mahjong.scxz.status",
        importError         = "mahjong.scxz.error",
        importMessage       = "mahjong.scxz.message",
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