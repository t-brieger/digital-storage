data.raw["gui-style"]["default"]["digistore:network-ui"] = {
    type = "frame_style",
    parent = "frame"
}

data.raw["gui-style"]["default"]["digistore:titlebar-filler"] = {
    type = "empty_widget_style",
    parent = "draggable_space",
    height = 24,
    horizontally_stretchable = "on"
}

data.raw["gui-style"]["default"]["digistore:content-flow"] = {
    type = "vertical_flow_style",
    parent = "vertical_flow",
    vertical_spacing = 12
}

data.raw["gui-style"]["default"]["digistore:status-flow"] = {
    type = "horizontal_flow_style",
    parent = "horizontal_flow",
    horizontal_spacing = 4,
    top_margin = -4,
    vertical_align = "center"
}