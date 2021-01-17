--[[
    file:service_table.lua 
    desc:桌子服务
    auth:Carol Luo
]]

local _G = _G
local format = string.format
local ipairs = ipairs
local table = require("extend_table")
local skynet = require("skynet")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local cs = queue()


---@class service_table @桌子服务
local service_table = {}
local this = service_table

---服务启动
---@param gameID     gameID @游戏ID
---@param gameCustom gameCustom @定制
function service_table.start(gameID,gameCustom)
    ---@type gameInfo
    local gameInfo = this._gameInfos[gameID]
    --共享内存
    for _,name in ipairs(gameInfo.sharedList) do
        local deploy = sharedata.query(name)
        _G.package.loaded[name] = deploy
    end
    --创建桌子
    local import = require(gameInfo.importTable)
    ---@type gameTable @游戏桌子
    this._gameTable = import.new(this,gameInfo,gameCustom)
    skynet.retpack(false)
end

---服务退出
function service_table.exit()
    skynet.retpack(true)
    skynet.exit()
end

skynet.init(function()
    ---@type gameInfos
    this._gameInfos = sharedata.query("games.gameInfos")
end)

skynet.start(function()
    skynet.info_func(function()
        return this._gameTable:getGameInfo()
    end)
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = this[cmd]
        if f then
            cs(f,...)
        else
            local table = this._gameTable
            local f = table[cmd]
            cs(f,table,...)
        end
    end)
end)
