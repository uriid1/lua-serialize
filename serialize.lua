-- This lib based on https://github.com/rxi/lume
--[[
    ####--------------------------------####
    #--# Author:   by uriid1            #--#
    #--# license:  GNU GPL              #--#
    #--# telegram: @foxdacam            #--#
    #--# Mail:     appdurov@gmail.com   #--#
    ####--------------------------------####
--]]

local M = {}

local pairs    = pairs
local type     = type
local tostring = tostring

-- Recursive serialization
local serialize_map = {
  ["boolean"] = tostring,
  ["string"]  = function(v, value)
        if value then
            return "[["..tostring(v).."]]"
        end
        return "'"..tostring(v).."'"
  end,
  ["number"]  = function(v)
    if      (v ~=  v)     then return  "0/0";      --  nan
    elseif  (v ==  1 / 0) then return  "1/0";      --  inf
    elseif  (v == -1 / 0) then return "-1/0"; end  -- -inf
    return tostring(v)
  end,
  ["table"] = function(tbl)
    local tmp = {}
    local tmp_len = #tmp
    for k, v in pairs(tbl) do 
      tmp[tmp_len + 1] = "[" .. M.create(k, false) .. "]=" .. M.create(v, true)
    end
    return "{" .. table.concat(tmp, ",") .. "}"
  end
}

-- Serialize Table
function M.create(tbl, value)
    return serialize_map[type(tbl)](tbl, value)
end

-- Load Table
function M.load(fname)
    local file = io.open(fname)
    local rfile = file:read("*a")
    file:close()
    return assert((loadstring or load)("return"..rfile))()
end

-- Load String
function M.loadstring(str)
    return assert((loadstring or load)("return"..str))()
end

-- Save Table
function M.save(tbl, fname)
    local file = io.open(fname, "w")
    local wtable = M.create(tbl)
    file:write(wtable)
    file:close()
end

return M