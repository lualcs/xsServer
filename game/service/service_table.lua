--[[
    file:service.lua 
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
local service = {}
local this = service

---服务启动
---@param gameID     gameID @游戏ID
---@param gameCustom gameCustom @定制
function service.start(gameID,gameCustom)
    ---游戏信息
    ---@type gameInfo
    local gameInfo = this.infos[gameID]
    --共享内存
    for _,name in ipairs(gameInfo.sharedList) do
        local deploy = sharedata.query(name)
        _G.package.loaded[name] = deploy
    end
    --创建桌子
    local import = require(gameInfo.importTable)
    ---@type gameTable @游戏桌子
    this._table = import.new(this,gameInfo,gameCustom)
    this._table:gameStart()
    skynet.retpack(false)
end

---服务退出
function service.exit()
    skynet.retpack(true)
    skynet.exit()
end

skynet.init(function()
    ---@type gameInfos
    this.infos = sharedata.query("games.gameInfos")
end)

skynet.start(function()
    skynet.info_func(function()
        return this._table:getGameInfo()
    end)
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = this[cmd]
        if f then
            cs(f,...)
        else
            local table = this._table
            local f = table[cmd]
            cs(f,table,...)
        end
    end)
end)
