data:extend({{
    type = "container",
    name = "digistore:server-entity",
    
    -- TODO this is probably not meant to stay a container; add actual server-related behaviour!
    inventory_size = 1,

    picture = {
        filename = "__digital-storage__/sprites/entities/network-server.png",
        size = 128,
        scale = 1.0/2.0
    },
    icon = "__digital-storage__/sprites/items/network-server.png",
    icon_size = 128,
    icon_mipmaps = 4,
    
    drawing_box = {{-1, -1}, {1, 1}},
    collision_box = {{-0.95, -0.95}, {0.95, 0.95}},
    selection_box = {{-1, -1}, {1, 1}},

    minable = {
        mining_time = 5,
        result = "digistore:server-item"
    },
    placeable_by = {
        item = "digistore:server-item",
        count = 1
    },

    flags = {"placeable-player", "player-creation", "not-upgradable"}
}})