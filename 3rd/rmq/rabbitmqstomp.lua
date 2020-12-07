local byte = string.byte
local concat = table.concat
local error = error
local find = string.find
local gsub = string.gsub
local insert = table.insert
local len = string.len
local pairs = pairs
local setmetatable = setmetatable
local sub = string.sub

local skynet = require "skynet"
local socketchannel =  require "skynet.socketchannel"

--headers["destination"] = "/queue/stayData1"  队列的名字
--headers["persistent"] = "true"   是否持久化
--headers["id"] = "skynet_rabbitmq"  订阅不同的消息队列需要不同的ID
--headers["ack"] = "client-individual"  应答方式 
--auto, client, client-individual, 默认为auto.

  --  当ack为auto时，client收到server发来的消息后不需要回复ACK frame. server假定消息发出去后client就已经收到。这种确认方式可以减少消息传输的次数.
  --当ack为client时, client必须发送ACK frame给servers, 让它处理消息. 如果在client发送ACK frame之前连接断开了，那么server将假设消息没有被处理，可能会再次发送消息给另外的客户端。

--headers["receipt"] = "111"  设置了这个字段 消息队列服务器就会有响应消息
--headers["prefetch-count"] = '1' 设置每次只给订阅方发送一个消息

local _M = {
    _VERSION = "0.1",
}
_M.__index = _M

local mt = { __index = _M }


local LF = "\x0a"
local EOL = "\x0d\x0a"
local NULL_BYTE = "\x00"


function _M:_build_frame(command, headers, body)
    local frame = {command, EOL}

    if body then
        headers["content-length"] = len(body)
    end

    for key, value in pairs(headers) do
        insert(frame, key)
        insert(frame, ":")
        insert(frame, value)
        insert(frame, EOL)
    end

    insert(frame, EOL)

    if body then
        insert(frame, body)
    end

    insert(frame, NULL_BYTE)
    insert(frame, EOL)
    return concat(frame, "")
end

local function __dispatch_resp(self)
    return function (sock)
        local frame = nil
        if self.opts.trailing_lf == nil or self.opts.trailing_lf == true then
            frame = sock:readline(NULL_BYTE .. LF)
        else
            frame = sock:readline(NULL_BYTE)
        end

        if not frame then
            return false
        end

        -- We successfully received a frame, but it was an ERROR frame
        if sub(frame, 1, len('ERROR') ) == 'ERROR' then
            skynet.error("rabbitmq error:", frame)
        end
       -- skynet.error("resp frame:", frame)
        return true, frame
    end
end

function _M:_send_frame(frame)
    local dispatch_resp = __dispatch_resp(self)
  --  skynet.error("aaa",frame,dispatch_resp)
    return self.__sock:request(frame, dispatch_resp)
end

function _M:_send_frame_no_resp(frame)
    
    return self.__sock:request(frame, nil)
end

local function rabbitmq_login(self)
   
    return function(sc)
        local headers = {}
        headers["accept-version"] = "1.2"
        headers["login"] = self.opts.username
        headers["passcode"] = self.opts.password
       
        headers["host"] = self.opts.vhost
      -- headers["heart-beat"] = "3000,3000"
       
        return self:_send_frame(self:_build_frame("CONNECT", headers, nil))
      
    end
end

function _M.connect(conf, opts)
    if opts == nil then
        opts = {username = "guest", password = "guest", vhost = "/", trailing_lf = true}
    end
    
    local obj = {
        opts = opts,
    }

    obj.__sock = socketchannel.channel {
        auth = rabbitmq_login(obj),
        host = conf.host or "127.0.0.1",
        port = conf.port or 61613,
        nodelay = true,
        overload = conf.overload,
    }
    
    setmetatable(obj, _M)
    obj.__sock:connect(true)
    return obj
end

function _M:send(smsg, headers)
    local f = nil
    if headers["receipt"] ~= nil then
        f = __dispatch_resp(self)
    end
    return self.__sock:request(self:_build_frame("SEND", headers, smsg), f)
end

function _M:subscribe(headers, cb)
    self.__cb = cb 
    return self:_send_frame(self:_build_frame("SUBSCRIBE", headers))
end

function _M:unsubscribe(headers)
    return self:_send_frame_no_resp(self:_build_frame("UNSUBSCRIBE", headers))
end
function _M:ackframe(headers)
    return self:_send_frame_no_resp(self:_build_frame("ACK", headers))
end

function _M:receive()
    local so = self.__sock
    while so do
        local dispatch_resp = __dispatch_resp(self)
        local data, err = so:response(dispatch_resp)
        --skynet.error("receive:", data, err)
        
        if not data then
            return nil, err
        end
        --增加对错误消息的处理
        local idx = find(data, "\n\n", 2)
        self.__cb(sub(data, idx + 2),data)
    end
end

function _M:close()
    if self.state then
        -- Graceful shutdown
        local headers = {}
        headers["receipt"] = "disconnect"
        self:_send_frame(self:_build_frame("DISCONNECT", headers, nil))
    end

    self.__sock:close()
    setmetatable(self, nil)
end


--queue 队列名 jsonstring 生成的json字符串
function _M:send_rmq_msg(queue,jsonstring)

    local headers = {}
      headers["destination"] = "/queue/"..queue
      headers["persistent"] = "true"
      headers["content-type"] = "application/json"

      self:send(jsonstring, headers)

end
--queue 队列名 id 订阅ID fun 收到消息处理函数
function _M:subscribe_rmq_msg(queue,id,fun)

       local headers = {}    
        headers["destination"] = "/queue/"..queue
        headers["persistent"] = "true"
        headers["id"] = id
        headers["ack"] = "client-individual"
        headers["prefetch-count"] = '1'
        headers["receipt"] = os.time()
        self:subscribe(headers, fun)
end
--msgid 应答的消息ID
function _M:ack_rmq_msg(msgid)

    local headers = {}     
     headers["id"] = msgid
     self:ackframe(headers)
end

return _M
