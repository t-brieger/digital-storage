local util = require("./util.lua")
local guis = require("./guiComponents.lua")

local function NetworkCreationGui(info)
    local newgui = info.parent.add({
        type = "frame",
        name = "digistore:network-ui",
        style = "digistore:network-ui",
        direction = "vertical"
    })
    newgui.auto_center = true

    guis.addCloseButtonTitleBar(newgui, {"entity-name.digistore:server-entity"})

    local contentFrame = newgui.add({
        type = "frame",
        name = "digistore:network-ui-content-frame",
        style = "inside_shallow_frame_with_padding"
    })

    local content = contentFrame.add({
        type = "flow",
        name = "digistore:network-ui-content",
        direction = "vertical",
        style = "digistore:content-flow"
    })

    local statusIndicatorFlow = content.add({
        type = "flow",
        name = "digistore:network-ui-status-flow",
        direction = "horizontal",
        style = "digistore:status-flow"
    })

    local entityPreviewFrame = content.add({
        type = "frame",
        name = "digistore:network-ui-entity-preview-frame",
        style = "deep_frame_in_shallow_frame"
    })
    local entityPreview = entityPreviewFrame.add({
        type = "entity-preview",
        name = "digistore:network-ui-entity-preview",
        style = "wide_entity_button"
    })

    entityPreview.entity = info.entity

    return newgui
end

local function UpdateGui(info)
    local function Return()
        -- update status indicator?
    end
    return Return
end

util.OverwriteGui("digistore:server-entity", NetworkCreationGui, UpdateGui)
