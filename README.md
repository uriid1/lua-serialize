# lua-serialize
This is a very very very simple implementation for serializing and deserializing lua tables.

## Installation
The [serialize.lua](https://github.com/uriid1/lua-serialize/blob/main/serialize.lua) file should be dropped into an existing project and required by it:
```lua
local serialize = require "serialize"
```

## exemple
```lua
-- load lib
local serialize = require "serialize"

-- table
local my_table = {
    -- Weapoon
    gun = {
        player = {
            [1] = "Ak47",
            [2] = "Deagle",
            [3] = "Uzi"
        }
    },
}

-- Save my_table
serialize.save(my_table, "my_table.tbl")

-- Load the table you just saved
local data = serialize.load("my_table.tbl")

-- It's easy!
print( data.gun.player[1] )
```
