--[[
    ####****************************####
    #//# Author: by uriid1          #\\#
    #//# license: NO                #\\#
    #//# telegram: uriid1           #\\#
    #//# Mail: appdurov@gmail.com   #\\#
    ####****************************####
--]]

local serialize = {}

-- Serialize Table
function serialize.create(tbl)
    local result = "{ "
    local key_depth = false
    function serealize_table(tbl)
        --
        for k, v in pairs(tbl) do
            if type(tbl[k]) == "table" then
                result = result..k.." = {"
                serealize_table(tbl[k])
                key_depth = true
            else
                key_depth = false
                if type(k) == "number" then
                    result = result.."["..k.."]".." = "..tostring("'"..v.."'")..", "
                elseif type(k) == "string" then
                    result = result..k.." = "..tostring("'"..v.."'")..", "
                elseif type(k) == "boolean" then
                    result = result.."["..tostring(k).."]".." = "..tostring("'"..v.."'")..", "
                end
            end
            --
            if key_depth then result = result.."}, " end
        end
    end
    serealize_table(tbl)
    result = result.."}"
    return result
end

-- Load Table
function serialize.load(fname)
    local file = io.open(fname)
    local rfile = file:read("*a")
    file:close()
    local data = load("return"..rfile)()
    return data
end

-- Save Table
function serialize.save(tbl, fname)
    local file = io.open(fname, "w")
    local wtable = serialize.create(tbl)
    file:write(wtable)
    file:close()
end

return serialize