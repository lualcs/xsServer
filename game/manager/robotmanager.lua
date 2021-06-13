--[[
    desc:机器人管理
    auth:Caorl Luo
]]

local ipairs = ipairs
local skynet = require("skynet")
local class = require("class")
local timer = require("timer")
local table = require("extend_table")
local debug = require("extend_debug")
local senum = require("managerEnum")

---@class robotmanager @gate管理
local robotmanager = class()
local this = robotmanager

---构造
---@param service service_robot         @gate服务
function robotmanager:ctor(service)
    ---机器人服务
    self._service = service
    ---创建定时器
    ---@type timer
    self._timer = timer.new(1)
    ---空闲机器人
    ---@type userID[]
    self._idles = {nil}
    ---邀请机器人
    self._invis = {nil}
    ---工作机器人
    ---@type userID[]
    self._works = {nil}
    ---完成数量
    self._count = 0
    ---完成状态
    self._finish = nil
end

---重置
function robotmanager:dataReboot()
end

---服务
---@return serviceInf @服务信息
function robotmanager:getServices()
    return self._service._services
end

---服务
---@param rlist userID[] @机器列表
function robotmanager:feachRobotList(rlist)
    local _idles = self._idles
    table.push_list(_idles,rlist)
end

---完成
---@param rlist userID[] @机器列表
function robotmanager:feachRobotOver()
    
    ---完成检查
    local _idles = self._idles
    local index = self._count + 1
    local userID = _idles[index]
    if not userID then
        skynet.error("robotmanager finish")
        self._finish = true
        self._timer:interval(10)
        return true
    end

    ---通知登录
    local services = self:getServices()
    self._count = index
    skynet.send(services.login,"lua","robotLogin",userID)
   
    ---定时回调
    self._timer:appendCall(10,function()
        self:feachRobotOver()
    end)

    return false
end

---邀请 
---@param assign        service @分配服务
---@param competition   service @桌子服务
function robotmanager:inviteEnter(assign,competition)
    if not self._finish then
       return 
    end

    if table.empty(self._idles) then
        return
    end

    local services = self:getServices()
    local userID = table.remove(self._idles)
    table.insert(self._invis,userID)
    skynet.send(services.gates,"lua","inviteEnterTable",assign,competition,userID)
end

---请求
---@param fd  socket      @套接字
---@param msg msgBody @数据
function robotmanager:message(fd,msg)
  
end

return robotmanager