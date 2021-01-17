--[[
    file:api_pbc.lua
    desc:protobuff 的使用
    auth:Carol Luo
]]

local debug = debug
local protobuf = require("protobuf")
local parser = require("parser")

---@class api_pbc @protbuff 的使用
local api_pbc = {}

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

return api_pbc