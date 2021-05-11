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
          `betScore` bigint(20) NOT NULL COMMENT '游戏下注分数',
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
          `betScore` bigint(20) NOT NULL COMMENT '游戏下注分数',
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
          `betScore` bigint(20) NOT NULL COMMENT '游戏下注分数',
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
          `betCostScore` bigint(20) NOT NULL COMMENT '游戏下注成本',
          `betBounsScore` bigint(20) NOT NULL COMMENT '游戏下注彩金',
          `winnerCount` int(11) NOT NULL COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL COMMENT '游戏和局次数',
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
          `rid` int(11) NOT NULL COMMENT '游戏角色',
          `baseScore` bigint(20) NOT NULL COMMENT '游戏基础分数',
          `winnerScore` bigint(20) NOT NULL COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL COMMENT '游戏和局次数',
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
          `winnerScore` bigint(20) NOT NULL COMMENT '游戏对局赢分',
          `loserScore` bigint(20) NOT NULL COMMENT '游戏对局输分',
          `winnerCount` int(11) NOT NULL COMMENT '游戏胜利次数',
          `loserCount` int(11) NOT NULL COMMENT '游戏失败次数',
          `drawCount` int(11) NOT NULL COMMENT '游戏和局次数',
          PRIMARY KEY (`rid`, `baseScore`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '炸金花玩家对局统计数据' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],
}