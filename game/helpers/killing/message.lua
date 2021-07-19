--[[
    file:gameEnum.lua 
    desc:游戏枚举
    auth:Caorl Luo
]]

local ipairs = ipairs
local class = require("class")
local senum = require("game.enum")
local table = require("extend_table")
local proto = require("api_websocket")

---@class killingMessage @游戏消息
local message = class()

local copy1 = {nil}
---通知客户端-服务-私有的
---@param fd      socket        @服务地址
---@param name    string        @结构名字
---@param data    msgBody       @游戏数据
local function ntfMsgToClient(fd,name,data)
    local cmds = table.clear(copy1)
    table.insert(cmds,senum.competition())
    proto.sendpbc(fd,name,cmds,data)
end

local copy1 = {nil}
---通知客户端-服务-私有的
---@param fds     socket[]      @服务地址
---@param name    string        @结构名字
---@param data    msgBody       @游戏数据
local function ntfMsgToClients(fds,name,data)
    local cmds = table.clear(copy1)
    table.insert(cmds,senum.competition())
    proto.sendpbcs(fds,name,cmds,data)
end

---通知客户端-玩家
---@param player  gamePlayer     @游戏玩家
---@param name    string         @结构名字
---@param cmd     senum          @消息命令
---@param data    msgBody    @游戏数据
function message:ntfMsgToPlayer(player,name,cmd,data)
    ntfMsgToClient(player:fd(),name,cmd,data)
end

---通知客户端-玩家-缓存
---@param player    gamePlayer     @游戏玩家
---@param name      string         @结构名字
---@param cmd       senum          @消息命令
---@param data      msgBody    @游戏数据
function message:ntfCacheMsgToPlayer(player,name,cmd,data)
    self:ntfMsgToPlayer(player,name,cmd,data)
    self._cac:dataPush({
        msgName = name,
        msgInfo = data,
    })
end

---通知客户端-玩家-缓存
---@param name      string              @结构名字
---@param cmd       senum               @消息命令
---@param data      msgBody         @游戏数据
---@param sees      message_see_info    @可见信息
function message:ntfCacheMsgToTable(name,data,sees)
    self:ntfMsgToTable(name,data,sees)
    self._cac:dataPush({
        msgName = name,
        msgInfo = table.copy_deep(data),
        msgRoot = table.copy_deep(sees),
    })
end


local copy1 = {nil}
local copy2 = {nil}
---通知客户端-广播
---@param name    string            @服务地址
---@param data   msgBody            @游戏数据
---@param sees   message_see_info   @可见信息
function message:ntfMsgToTable(name,data,sees)
    ---@type table<any,any>    @备份数据
    local back = table.clear(copy1)
    ---去除私有数据
    if sees then
        for _,field in ipairs(sees.fields) do
            back[field] = table.delete(data,field)
        end
    end

    --通知旁观玩家
    local socs = table.clear(copy2)
    for _,player in ipairs(self._mapPlayer) do
        if not sees then
            table.insert(socs,player:fd())
        else
            local seat = player:getSeatID()
            if not table.exist(sees.chairs,seat) then
                table.insert(socs,player:fd())
            end
        end
    end
    ---通知旁观玩家
    ntfMsgToClients(socs,name,data)

    ---隐私数据
    if sees then
        ---还原私有数据
        socs = table.clear(copy2)
        for _,field in ipairs(sees.fields) do
            data[field] = back[field]
        end

        ---通知知情玩家
        for seat,_ in ipairs(sees.chairs) do
            --通知数据
            local player = self._arrPlayer[seat]
            table.insert(socs,player:fd())
        end

        ---通知知情玩家
        ntfMsgToClients(socs,name,data)
    end
end

---请求
---@param rid           userID          @玩家
---@param msg           messageInfo     @消息
---@return boolean,string|any
function message:message(rid,msg)
    local player = self._mapPlayer[rid]
    self:setCurPlayer(player)
    self:messageBy(player,msg)
end

---请求
---@param player        gamePlayer      @玩家
---@param msg           messageInfo     @消息
---@return boolean,string|any
function message:messageBy(player,msg)
   
end

return message