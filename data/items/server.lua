data:extend({{
    type = "item",
    name = "digistore:server-item",

    icon = "__digital-storage__/sprites/items/network-server.png",
    icon_size = 126,
    icon_mipmaps = 4,

    place_result = 'digistore:server-entity',
    stack_size = 50
}})

data:extend({{
    type = "recipe",
    name = "digistore:server-recipe",
    normal = {
        enabled = true,
        ingredients = {
            {"iron-plate", 1}
        },
        result = "digistore:server-item"
    }
}})