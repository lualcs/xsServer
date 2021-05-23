--[[
    desc:游戏信息
    auth:Carol Luo
]]

return {
    --创建游戏数据库
    [[
        DROP DATABASE IF EXISTS `dbgameinfo`;
        CREATE DATABASE `dbgameinfo` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
    ]],
    ---切换数据库使用
    [[ USE `dbgameinfo`;]],

    --创建金玉满堂玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatJYMT
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatJYMT`;
        CREATE TABLE `playerCombatJYMT`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `betScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注分数',
          `spinCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转成本',
          `spinBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转彩金',
          `spinWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转胜利次数',
          `spinLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转失败次数',
          `spinDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转和局次数',
          `spinAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转触发免费次数',
          `spinFreeBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '免费旋转派彩',
          `spinFreeWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转胜利次数',
          `spinFreeDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转和局次数',
          `spinFreeAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转触发免费次数',
          `spinAxleCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转成本',
          `spinAxleBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转彩金',
          `spinAxleWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转胜利次数',
          `spinAxleLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转失败次数',
          `spinAxleDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转和局次数',
          `leftFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '剩余免费次数',
          PRIMARY KEY (`rid`, `betScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '金玉满堂玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建宝石神兽玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatBSSS
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatBSSS`;
        CREATE TABLE `playerCombatBSSS`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `betScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注分数',
          `spinCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转成本',
          `spinBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转彩金',
          `spinWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转胜利次数',
          `spinLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转失败次数',
          `spinDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转和局次数',
          `spinAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转触发免费次数',
          `spinFreeBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '免费旋转派彩',
          `spinFreeWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转胜利次数',
          `spinFreeDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转和局次数',
          `spinFreeAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转触发免费次数',
          `spinAxleCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转成本',
          `spinAxleBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转彩金',
          `spinAxleWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转胜利次数',
          `spinAxleLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转失败次数',
          `spinAxleDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转和局次数',
          `leftFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '剩余免费次数',
          PRIMARY KEY (`rid`, `betScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '宝石神兽玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建龙狮挣霸玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatLSZB
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatLSZB`;
        CREATE TABLE `playerCombatLSZB`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `betScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注分数',
          `spinCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转成本',
          `spinBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转彩金',
          `spinWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转胜利次数',
          `spinLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转失败次数',
          `spinDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转和局次数',
          `spinAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转触发免费次数',
          `spinFreeBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '免费旋转派彩',
          `spinFreeWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转胜利次数',
          `spinFreeDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转和局次数',
          `spinFreeAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转触发免费次数',
          `spinAxleCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转成本',
          `spinAxleBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转彩金',
          `spinAxleWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转胜利次数',
          `spinAxleLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转失败次数',
          `spinAxleDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转和局次数',
          `leftFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '剩余免费次数',
          PRIMARY KEY (`rid`, `betScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '龙狮争霸玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建金鸡报喜玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatJJBX
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatJJBX`;
        CREATE TABLE `playerCombatJJBX`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `betScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注分数',
          `spinCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转成本',
          `spinBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转彩金',
          `spinWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转胜利次数',
          `spinLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转失败次数',
          `spinDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转和局次数',
          `spinAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转触发免费次数',
          `spinFreeBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '免费旋转派彩',
          `spinFreeWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转胜利次数',
          `spinFreeDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转和局次数',
          `spinFreeAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转触发免费次数',
          `spinAxleCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转成本',
          `spinAxleBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '重转旋转彩金',
          `spinAxleWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转胜利次数',
          `spinAxleLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转失败次数',
          `spinAxleDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '重转旋转和局次数',
          `leftFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '剩余免费次数',
          PRIMARY KEY (`rid`, `betScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '金鸡报喜玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建水果玛丽玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMary
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMary`;
        CREATE TABLE `playerCombatMary`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `betScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注分数',
          `spinCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转成本',
          `spinBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '正常旋转彩金',
          `spinWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转胜利次数',
          `spinLoserCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转失败次数',
          `spinDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转和局次数',
          `spinAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转触发免费次数',
          `spinAppendMaryCount` int(11) NOT NULL DEFAULT 0 COMMENT '正常旋转触发玛利次数',
          `spinFreeBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '免费旋转派彩',
          `spinFreeWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转胜利次数',
          `spinFreeDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转和局次数',
          `spinFreeAppendFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转触发免费次数',
          `spinFreeAppendMaryCount` int(11) NOT NULL DEFAULT 0 COMMENT '免费旋转触发玛利次数',
          `spinMarryBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '玛利旋转彩金',
          `spinMarryWinnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '玛利旋转胜利次数',
          `spinMarryDrawCount` int(11) NOT NULL DEFAULT 0 COMMENT '玛利旋转和局次数',
          `leftFreeCount` int(11) NOT NULL DEFAULT 0 COMMENT '剩余免费次数',
          `leftMarryCount` int(11) NOT NULL DEFAULT 0 COMMENT '剩余玛利次数',
          PRIMARY KEY (`rid`, `betScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '水果玛丽玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建龙虎斗玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatDragonTiger
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatDragonTiger`;
        CREATE TABLE `playerCombatDragonTiger`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `betCostScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注成本',
          `betBounsScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏下注彩金',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '龙虎斗玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建扯旋玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatCX
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatCX`;
        CREATE TABLE `playerCombatCX`  (
          `rid` int(11) NOT NULL DEFAULT 0 COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `waiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '弃牌次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '扯旋玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建炸金花玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatZJH
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatZJH`;
        CREATE TABLE `playerCombatZJH`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `bomBwaiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '炸弹弃牌次数',
          `straightFlushwaiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '同花顺弃牌次数',
          `flushWaiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '同花弃牌次数',
          `straightWaiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '顺子弃牌次数',
          `pairWaiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '对子弃牌次数',
          `highWaiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '高牌弃牌次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '炸金花玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建斗公牛玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatDGN
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatDGN`;
        CREATE TABLE `playerCombatDGN`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `waiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '弃牌次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '斗公玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建六癞牛玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatLLN
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatLLN`;
        CREATE TABLE `playerCombatLLN`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `waiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '弃牌次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '六癞牛玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建七癞牛玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatQLN
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatQLN`;
        CREATE TABLE `playerCombatQLN`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `waiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '弃牌次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '七癞牛玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建德州扑克玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatTexasPoker
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatTexasPoker`;
        CREATE TABLE `playerCombatTexasPoker`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `waiveCount` int(11) NOT NULL DEFAULT 0 COMMENT '弃牌次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '德州扑克玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建开封麻将玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMahjongKF
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMahjongKF`;
        CREATE TABLE `playerCombatMahjongKF`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `pengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰牌次数',
          `raoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次数',
          `mingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '明杠次数',
          `anGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次数',
          `pingCount` int(11) NOT NULL DEFAULT 0 COMMENT '平胡次数',
          `dianPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '点碰牌次数',
          `dianRaoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点绕杠次数',
          `dianMingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次数',
          `dianPaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '点炮次数',
          `ziMoCount` int(11) NOT NULL DEFAULT 0 COMMENT '自摸次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '开封麻将胡玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建郑州麻将玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMahjongZZ
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMahjongZZ`;
        CREATE TABLE `playerCombatMahjongZZ`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `pengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰牌次数',
          `raoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次数',
          `mingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '明杠次数',
          `anGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次数',
          `pingCount` int(11) NOT NULL DEFAULT 0 COMMENT '平胡次数',
          `dianPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '点碰牌次数',
          `dianRaoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点绕杠次数',
          `dianMingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次数',
          `dianPaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '点炮次数',
          `ziMoCount` int(11) NOT NULL DEFAULT 0 COMMENT '自摸次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '郑州麻将胡玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建河南推倒胡玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMahjongHNTDH
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMahjongHNTDH`;
        CREATE TABLE `playerCombatMahjongHNTDH`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `pengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰牌次数',
          `raoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次数',
          `mingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '明杠次数',
          `anGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次数',
          `pingCount` int(11) NOT NULL DEFAULT 0 COMMENT '平胡次数',
          `qiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '七对次数',
          `dianPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '点碰牌次数',
          `dianRaoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点绕杠次数',
          `dianMingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次数',
          `dianPaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '点炮次数',
          `ziMoCount` int(11) NOT NULL DEFAULT 0 COMMENT '自摸次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '河南推倒胡玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建洛阳杠次玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMahjongLYGC
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMahjongLYGC`;
        CREATE TABLE `playerCombatMahjongLYGC`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `pengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰牌次数',
          `raoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次数',
          `mingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '明杠次数',
          `anGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次数',
          `pingCount` int(11) NOT NULL DEFAULT 0 COMMENT '平胡次数',
          `dianGangCiCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次次数',
          `raoGangCiCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次次数',
          `anGangCiCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次次数',
          `piGangCiCount` int(11) NOT NULL DEFAULT 0 COMMENT '皮杠次次数',
          `dianPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '点碰牌次数',
          `dianRaoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点绕杠次数',
          `dianMingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次数',
          `dianPaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '点炮次数',
          `ziMoCount` int(11) NOT NULL DEFAULT 0 COMMENT '自摸次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '洛阳杠次玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建卡五星玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMahjongKWX
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMahjongKWX`;
        CREATE TABLE `playerCombatMahjongKWX`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `pengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰牌次数',
          `raoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次数',
          `mingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '明杠次数',
          `anGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次数',
          `pingCount` int(11) NOT NULL DEFAULT 0 COMMENT '平胡次数',
          `kwxCount` int(11) NOT NULL DEFAULT 0 COMMENT '卡五星次数',
          `liangDaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '亮倒次数',
          `dianPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '点碰牌次数',
          `dianRaoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点绕杠次数',
          `dianMingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次数',
          `dianPaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '点炮次数',
          `ziMoCount` int(11) NOT NULL DEFAULT 0 COMMENT '自摸次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '卡五星玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    --创建血战麻将玩家对局统计数据
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        -- ----------------------------
        -- Table structure for playerCombatMahjongXZ
        -- ----------------------------
        DROP TABLE IF EXISTS `playerCombatMahjongXZ`;
        CREATE TABLE `playerCombatMahjongXZ`  (
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL DEFAULT 0 COMMENT '游戏和局次数',
          `pengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰牌次数',
          `raoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '绕杠次数',
          `mingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '明杠次数',
          `anGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '暗杠次数',
          `pingCount` int(11) NOT NULL DEFAULT 0 COMMENT '平胡次数',
          `pengPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '碰碰胡次数',
          `qiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '七对次数',
          `qingQiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '清七对次数',
          `qingLongQiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '清龙七对次数',
          `shuangQingLongQiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '双清龙七对次数',
          `longQiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '龙七对次数',
          `shuangLongQiDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '双龙七对次数',
          `jiangDuiCount` int(11) NOT NULL DEFAULT 0 COMMENT '将对',
          `shiBaLuoHanCount` int(11) NOT NULL DEFAULT 0 COMMENT '十八罗汉',
          `qingShiBaLuoHanCount` int(11) NOT NULL DEFAULT 0 COMMENT '清十八罗汉',
          `qingYiSeCount` int(11) NOT NULL DEFAULT 0 COMMENT '清一色次数',
          `dianGangHuaCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠花次数',
          `gangShangHuaCount` int(11) NOT NULL DEFAULT 0 COMMENT '杠上花次数',
          `qingPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '清碰次数',
          `qiangGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '抢杠胡',
          `dianPengCount` int(11) NOT NULL DEFAULT 0 COMMENT '点碰牌次数',
          `dianRaoGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点绕杠次数',
          `dianMingGangCount` int(11) NOT NULL DEFAULT 0 COMMENT '点杠次数',
          `dianPaoCount` int(11) NOT NULL DEFAULT 0 COMMENT '点炮次数',
          `ziMoCount` int(11) NOT NULL DEFAULT 0 COMMENT '自摸次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '血战麻将玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],
}