--[[
    file:fauto.lua 
    desc:自增长函数
    auth:Carol Luo
]]

return function()
    local auto = 0
    return function()
        auto=auto+1
        return auto
    end
end