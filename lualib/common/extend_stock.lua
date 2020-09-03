--[[
    file:extend_stock.lua 
    desc:闭包库存
]]

local pairs = pairs
local ipairs = ipairs
local stock = {}

---@field new 创建一个库存
function stock.new()

    local lis = {}

    ---@class 库存对象
    local obj = {}

    ---@field fortab 申请一个库存
    function obj.fortab()
        local new = lis[#lis] or {}
        --清空数据
        for k,_ in pairs(new) do
            new[k] = nil
        end

        --返回一个表
        return new
    end

    ---@field recycle 回收一个库存
    function obj.recycle(t)
        lis[#lis+1] = t
    end

    ---@field recycle 释放所有库存
    function obj.release(t)
        for k,_ in pairs(lis) do
            lis[k] = nil
        end
    end

    return obj
end


return stock