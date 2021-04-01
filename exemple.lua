-- load lib
local serialize = require "serialize" 

-- example table
local t_param = {
    name = "John Sina",
    age = 40,
    gender = "Male",
}

--
local my_table = {
    -- param
    param = t_param,

    -- Weapoon
    gun = {
        player = {
            [1] = "Ak47",
            [2] = "Deagle",
            [3] = "Uzi"
        }
    },
    
    -- LOl :D
    depth = {
        depth1 = {
            depth2 = {
                depth3 = {
                    depth4 = {
                        depth5 = {
                            text = "WOW! IS DEPTH IS 5!" 
                        }
                    }
                }
            }
        }
    },
}

-- Save my_table
serialize.save(my_table, "my_table.tbl")

-- Load the table you just saved
local data = serialize.load("my_table.tbl")

-- Table content
print( data.param.name )
print( data.param.age )
print( data.param.gender )

print( data.gun.player[1] )
print( data.gun.player[2] )
print( data.gun.player[3] )

print( data.depth.depth1.depth2.depth3.depth4.depth5.text )