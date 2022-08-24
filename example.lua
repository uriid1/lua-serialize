local serialize = require("serialize")

--
local user_info = {
    name   = "Elon Musk",
    age    = 40,
    gender = "Male",
}

--
local my_table = {
    -- param
    param = user_info,

    -- Weapoon
    gun = {
        player = {
            [1] = "Ak47",
            [2] = "Deagle",
            [3] = "Uzi",
            [4] = 1 / 0,
            [5] = 0 / 0,
            [6] = -1 / 0
        }
    },
    
    -- LOl :D
    depth = {
        depth1 = {
            depth2 = {
                depth3 = {
                    depth4 = {
                        depth5 = {
                            text = "U are awesome!" 
                        }
                    }
                }
            }
        }
    },
}

-- test recurse
my_table.recurse = my_table
my_table.recurse.foo = my_table

-- Save my_table
serialize.save(my_table, "my_table.tbl")

-- Load the table you just saved
local data = serialize.load("my_table.tbl")

-- Table content
print( 'name: '   .. data.param.name )
print( 'age: '    .. data.param.age )
print( 'gender: ' .. data.param.gender )
print( 'Guns: ' .. table.concat( data.gun.player, ', ' ) )
print( 'Depth text: '..data.depth.depth1.depth2.depth3.depth4.depth5.text )