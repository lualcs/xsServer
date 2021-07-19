--[[
    file:service.lua 
    desc:桌子服务
    auth:Carol Luo
]]

local _G = _G
local format = string.format
local ipairs = ipairs
local skynet = require("skynet")
local table = require("extend_table")
local multicast = require("api_multicast")
local sharedata = require("skynet.sharedata")
local queue = require("skynet.queue")
local senum = require("game.enum")
local cs = queue()


---@class service_competition @桌子服务
local service = {}
local this = service

---服务启动
---@param handle     service    @分配服务
---@param gameID     gameID     @游戏ID
---@param custom     gameCustom @定制
function service.start(handle,gameID,custom)
    this.shareFech()
    ---分配服务
    ---@type service
    this._assign = handle
    ---服务信息
    ---@type serviceInf
    this._services = sharedata.query(senum.mapServices())
    ---游戏信息
    ---@type gameInfo
    local gameInfos = require("games.gameInfos")
    local gameInfo = gameInfos[gameID]
    --共享内存
    for _,name in ipairs(gameInfo.sharedList) do
        local deploy = sharedata.query(name)
        _G.package.loaded[name] = deploy
    end
    ---创建桌子
    local import = require(gameInfo.importCompetition)
    ---@type gameCompetition @游戏桌子
    this._competition = import.new(this,gameInfo,custom)
    this._competition:dataReboot()
    ---组播对象
    this.multicast()
end


---退出
function service.exit()
    skynet.exit()
end

---加载共享
function service.shareFech()
    local shareFech = sharedata.query("share.fech")
      --通用部分
      for _,name in ipairs(shareFech.general_fech) do
          local deploy = sharedata.query(name)
          _G.package.loaded[name] = deploy
      end
      --独属部分
      for _,name in ipairs(shareFech.service_competition) do
        local deploy = sharedata.query(name)
        _G.package.loaded[name] = deploy
    end
end

---服务表
function service.mapServices(name)
    local services = sharedata.query(name)
     ---@type serviceInf @服务地址信息
     this._services = services
end

---组播
function service.multicast()
	---服务
	local services = this._services
	---组播
	---@type api_multicast
	this._multicast = multicast.new()
	this._multicast:createBinding(services.mainChannel,function(channel,source,cmd,...)
		this._manger:multicastMsg(cmd,...)
	end)
end



skynet.start(function()
    skynet.info_func(function()
        return this._competition:getGameInfo()
    end)
    skynet.dispatch("lua",function(_,_,cmd,...)
        local f = this[cmd]
        local pack
        if f then
            pack = cs(f,...)
        else
            local table = this._competition
            local f = table[cmd]
            pack = cs(f,table,...)
        end

        skynet.retpack(pack or false)
    end)
end)
