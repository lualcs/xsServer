--[[
    file:extend_debug.lua 
    desc:debug 扩展
    auto:Carol Luo
]]

local skynet = require("skynet")
local debug = debug

function debug.error(...)
    skynet.error(...)
end

function debug.warning(...)
    skynet.error(...)
end

function debug.normal(...)
    skynet.error(...)
end


return debug


--[[
    {   --包含系统库 请不要覆盖
        setmetatable = function: 0x55ce6efb5d20,
        getupvalue = function: 0x55ce6efb5ca0,
        setupvalue = function: 0x55ce6efb5c80,
        traceback = function: 0x55ce6efb6130,
        setlocal = function: 0x55ce6efb6220,
        getuservalue = function: 0x55ce6efb5f30,
        sethook = function: 0x55ce6efb6360,
        setuservalue = function: 0x55ce6efb5dd0,
        gethook = function: 0x55ce6efb6a80,
        upvaluejoin = function: 0x55ce6efb5e60,
        upvalueid = function: 0x55ce6efb5e20,
        getinfo = function: 0x55ce6efb66e0,
        getregistry = function: 0x55ce6efb5be0,
        getmetatable = function: 0x55ce6efb5f00,
        getlocal = function: 0x55ce6efb6580,
        debug = function: 0x55ce6efb5f70,
}
]]