--[[

    ####****************************####
    #//# Author: by uriid1          #\\#
    #//# license: NO                #\\#
    #//# telegram: uriid1           #\\#
    #//# Mail: appdurov@gmail.com   #\\#
    ####****************************####

    This project is based on https://github.com/rxi/lume

--]]

local pairs = pairs
local type  = type
local tostring, tonumber = tostring, tonumber
local serialize = {}

-- 
local serialize_map = {
  [ "boolean" ] = tostring,
  [ "string"  ] = function(v) return "'"..tostring(v).."'" end,
  [ "number"  ] = function(v) return v end,
  [ "table"   ] = function(tbl)
    local tmp = {}
    for k, v in pairs(tbl) do
        tmp[#tmp + 1] = "[" .. serialize.create(k) .. "]=" .. serialize.create(v)
    end
    return "{" ..  table.concat(tmp, ",") .. "}"
  end
}

-- Serialize Table
function serialize.create(tbl)
    return serialize_map[type(tbl)](tbl)
end

-- Load Table
function serialize.load(fname)
    local file = io.open(fname)
    local rfile = file:read("*a")
    file:close()
    return assert((loadstring or load)("return"..rfile))()
end

-- Save Table
function serialize.save(tbl, fname)
    local file = io.open(fname, "w")
    local wtable = serialize.create(tbl)
    file:write(wtable)
    file:close()
end

return serialize