-- ####--------------------------------####
-- #--# Author:   by uriid1            #--#
-- #--# License:  GNU GPLv3            #--#
-- #--# Telegram: @main_moderator      #--#
-- #--# E-mail:   appdurov@gmail.com   #--#
-- ####--------------------------------####

local M = {
    _version = 1.0;
}

local special = {
    [7]  = 'a';
    [8]  = 'b';
    [9]  = 't';
    [10] = 'n';
    [11] = 'v';
    [12] = 'f';
    [13] = 'r';
}

local controls = {}
for i = 0, 31 do
    local c = special[i]
    
    if not c then
        if i < 10 then
            c = "00" .. tostring(i)
        else
            c = "0" .. tostring(i)
        end
    end

    controls[i] = tostring('\\' .. c)
end

controls[92] = tostring('\\\\')
controls[34] = tostring('\\"')
controls[39] = tostring("\\'")

for i = 128, 255 do
    local c
    if i < 100 then
        c = "0" .. tostring(i)
    else
        c = tostring(i)
    end

    controls[i] = tostring('\\' .. c)
end

local function stringEscape(c)
    return controls[string.byte(c, 1)]
end

local function efmt(str)
    return "'"..string.gsub(str, '[%c\\\128-\255]', stringEscape).."'"
end

-- Recursive serialization
local serialize_map = {}

--
local function dump(tbl, t_stack)
    t_stack = t_stack or {}
    return serialize_map[type(tbl)](tbl, t_stack)
end

serialize_map = {
  ["boolean"] = tostring,

  ["string"]  = function(v)
        return efmt(v)
  end,

  ["number"]  = function(v)
    if      v ~=  v     then return  "0/0";      --  nan
    elseif  v ==  1 / 0 then return  "1/0";      --  inf
    elseif  v == -1 / 0 then return "-1/0"; end  -- -inf
    return tostring(v)
  end,

  ["table"] = function(t, t_stack)
    local tmp = {}
    for k, v in pairs(t) do
        if serialize_map[type(v)] and (not t_stack[k]) and (v ~= t) then
            t_stack[k] = true
            tmp[#tmp + 1] = "[" .. dump(k, t_stack) .. "]=" .. dump(v, t_stack)
        end
    end

    return "{" .. table.concat(tmp, ",") .. "}"
  end
}

-- Serialize Table
function M.create(t)
    return dump(t)
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