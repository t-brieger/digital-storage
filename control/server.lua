local util = require("./util.lua")
local guis = require("./guiComponents.lua")
local guiControl = require("./guiControl.lua")

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

    -- TODO!
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

    content.add({
        type = "line"
    })

    local networkNameFlow = content.add({
        type = "flow",
        name = "digistore:network-ui-netname-flow",
        direction = "vertical"
    })

    networkNameFlow.add({
        type = "label",
        style = "heading_3_label",
        caption = {"digistore:gui.network-name-selection"}
    })

    local networkNameSelectFlow = content.add({
        type = "flow",
        name = "digistore:network-ui-netname-select-flow",
        direction = "horizontal"
    })

    -- TODO: (low-priority) add icon selector, like in train station name UI
    local networkNameField = networkNameSelectFlow.add({
        type = "textfield",
        name = "digistore:network-name-selector",
        text = global.networks[info.entity.unit_number].name
    })
    networkNameField.style.horizontally_stretchable = "on"
    networkNameField.style.maximal_width = 0

    networkNameSelectFlow.add({
        type = "sprite-button",
        name = "digistore:network-name-selector-confirm",
        style = "item_and_count_select_confirm",
        sprite = "utility/check_mark",
        hovered_sprite = "utility/check_mark",
        clicked_sprite = "utility/check_mark"
    })

    return newgui
end

local function GuiRedrawHandlerFactory(info)
    local function Redraw()
        -- update status indicator?
    end
    return Redraw
end

util.OverwriteGui("digistore:server-entity", NetworkCreationGui, GuiRedrawHandlerFactory)

util.AddEventHandler({defines.events.on_built_entity, defines.events.on_robot_built_entity},
    function(e)
        if e.created_entity.name == "digistore:server-entity" then
            global.networks[e.created_entity.unit_number] = {
                name = string.format("%x", e.created_entity.unit_number),
                contents = {},
                connected = {}
            }
        end
    end
)

util.AddEventHandler({defines.events.on_entity_died, defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity},
    function(e)
        if e.entity.name == "digistore:server-entity" then
            global.networks[e.entity.unit_number] = nil
        end
    end
)

util.AddEventHandler(defines.events.on_gui_click,
    function(e)
        if e.element.name == "digistore:network-name-selector-confirm" and e.button == defines.mouse_button_type.left then
            global.networks[guiControl.currentGui.entity.unit_number].name = e.element.parent["digistore:network-name-selector"].text
        end
    end
)