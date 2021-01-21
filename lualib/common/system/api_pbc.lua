--[[
    file:api_pbc.lua
    desc:protobuff 的使用
    auth:Carol Luo
]]

local pcall = pcall
local string = string
local debug = require("extend_debug")
local parser = require("parser")
local protobuf = require("protobuf")

---@class api_pbc @protbuff 的使用
local api_pbc = {}
local this = api_pbc

---保存protobuff 到注册表-因为是userdata 所以算是共享数据
---@param ENV userdata
function api_pbc.set_protobuf_env(ENV)
    debug.getregistry().PROTOBUF_ENV = ENV
end

---获取protobuff 的userdata
---@return 的userdata
function api_pbc.get_protobuf_env()
    return protobuf.get_protobuf_env()
end

---文件注册 .pd文件
---@param file string @文件相对路径
function api_pbc.register_file(file)
    protobuf.register_file(file)
end

---协议编码-table->buffer
---@param name string   @列如 package.name -> cs.test
---@param data table    @数据
---@return string       @buffer
function api_pbc.encode(name,data)
    return protobuf.encode(name,data)
end

---协议解码-buffer->table 
---@param name      string @列如 package.name -> cs.test
---@param buffer    string @buffer
---@return table
function api_pbc.decode(name,buffer)
    return protobuf.decode(name,buffer)
end

---协议编码-Pattern模式
---@param pattern string @
---@return string @数据包
function api_pbc.pack(pattern,...)
    return protobuf.pack(pattern,...)
end

---协议解码-Pattern模式
---@param pattern string @
---@param param   string @
---@param length  number @
---@return ... @返回结果
function api_pbc.unpack(pattern, buffer, length)
    return protobuf.unpack(pattern, buffer, length)
end 


---文件注册 .proto 文件
---@param fileset    string|string[]    @单个文件或者文件名集
---@param fileDir    string             @.proto 目录
function api_pbc.parser_register(fileset,fileDir)
    parser.register(fileset,fileDir)
end

---编码消息
---@param name  string @结构名
function api_pbc.encode_message(name,msg)

    --消息头
    local head = {name = name}
    local ok,msghead = pcall(this.encode, "msgHead",head)
    if not ok then
        debug.protobuff("encode_message msgHead:",{[name]=msg})
        return
    end

    --消息包
    local ok,msgbody = pcall(this.encode, name, msg)
    if not ok then
        debug.protobuff("encode_message msgbody:",{[name]=msg})
        return
    end

    return string.pack(">s2", msghead)..msgbody
end

---解码消息
---@param msgbuf  string @数据
---@param size    number @大小
function api_pbc.decode_message(msgbuf,size)

    --数据切割
    local headsize = msgbuf:byte(1) * 256 + msgbuf:byte(2)
    local headbuf,bodybuf = msgbuf:sub(3,2+headsize), msgbuf:sub(3+headsize)

    --头部解析
    local ok,msghead,error = pcall(this.decode, "msgHead", headbuf, string.len(headbuf))
    if not ok then
        debug.protobuff("decode_message msghead:",error)
        return
    end

    --数据解析
    local ok,msgbody,error = pcall(this.decode, msghead.name, bodybuf, string.len(bodybuf))
    if not ok then
        debug.protobuff("decode_message msghead:",error)
        return
    end

    return msghead,msgbody
end

return api_pbc