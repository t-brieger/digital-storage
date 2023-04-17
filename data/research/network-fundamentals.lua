data:extend({{
    type = "technology",
    name = "digistore:network-fundamentals",
    prerequisites = {"plastics"},
    effects = {
        {
            type = "nothing",
            effect_description = {'digistore:other.sample-bonus'},
            icon = "__digital-storage__/sprites/base-placeholder.png",
            icon_size = 128,
            icon_mipmaps = 4
        }
    },
    unit = {
        count = 50,
        ingredients = {
            {"automation-science-pack", 1}
        },
        time = 30
    },

    icon = "__digital-storage__/sprites/technology/network-fundamentals.png",
    icon_size = 128,
    icon_mipmaps = 4
}})