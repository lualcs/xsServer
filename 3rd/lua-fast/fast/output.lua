local json = require "cjson"

local output = {}

local function get_type_first_print(t)
    local str = type(t)
    return string.upper(string.sub(str, 1, 1)) .. ":"
end

function output.json(tab)
    print(json.encode(tab))
end

function output.dump(t, prefix, indent_input, print)
    local indent = indent_input
    if indent_input == nil then
        indent = 1
    end

    if print == nil then
        print = _G["print"]
    end

    local p = nil

    local formatting = string.rep("    ", indent)
    if prefix ~= nil then
        formatting = prefix .. formatting
    end

    if t == nil then
        print(formatting .. " nil")
        return
    end

    if type(t) ~= "table" then
        print(formatting .. get_type_first_print(t) .. tostring(t))
        return
    end

    local output_count = 0
    for k, v in pairs(t) do
        local str_k = get_type_first_print(k)
        if type(v) == "table" then
            print(formatting .. str_k .. k .. " -> ")

            util.dump_table(v, prefix, indent + 1, print)
        else
            print(formatting .. str_k .. k .. " -> " .. get_type_first_print(v) .. tostring(v))
        end
        output_count = output_count + 1
    end

    if output_count == 0 then
        print(formatting .. " {}")
    end
end

return output
