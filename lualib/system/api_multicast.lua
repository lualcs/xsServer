--[[
    desc:组播
    auth:Carol Luo
]]

local assert = assert
local class = require("class")
local multicast = require "skynet.multicast"


---@class api_multicast @组播
local api_multicast = class()
local this = api_multicast

---构造函数
function api_multicast:ctor()
   
end

---获取频道
function api_multicast:channel()
    return self._channelObj.channel
end

---创建频道
function api_multicast:create()
    ---组播对象
    ---@type channelObj
    self._channelObj = multicast.new()
end


---绑定频道
---@param channel   channel     @频道
---@param dispatch  function    @消息
function api_multicast:createBinding(channel,dispatch)
    ---组播对象
    ---@type channelObj
    self._channelObj = multicast.new({
        channel = channel,
        dispatch = dispatch
    })

    ---订阅消息
    self._channelObj:subscribe()
end


---推动消息
---@param cmd string @命令
function api_multicast:publish(cmd,...)
    self._channelObj:publish(cmd,...)
end

return api_multicast