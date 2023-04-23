script.on_init(
    function()
        -- table of networks, where the key the corresponding server entity's unit_number, the value is various information 
        --       about the network and a list of connected devices' unit numbers.
        global.networks = {}
        global.entity_to_network = {}
    end
)

require("control/server.lua")