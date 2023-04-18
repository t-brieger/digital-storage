local util = require("./util.lua")

local guis = {}

-- adapted with minor changes from https://forums.factorio.com/viewtopic.php?t=98713
function guis.addCloseButtonTitleBar(frame, caption)
    local bar = frame.add({
        type = "flow"
    })
    bar.drag_target = frame
    bar.add({
        type = "label",
        style = "frame_title",
        caption = caption,
        ignored_by_interaction = true
    })
    
    bar.add({
        type = "empty-widget",
        style = "digistore:titlebar-filler",
        ignored_by_interaction = true
    })
    
    bar.add({
        type = "sprite-button",
        name = "digistore:close-opened-gui",
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        tooltip = {"gui.close-instruction"},
    })
end

util.AddEventHandler(defines.events.on_gui_click,
    function(event)
        if event.element and event.element.name == "digistore:close-opened-gui" then
            game.get_player(event.player_index).opened = nil
        end
    end
)

return guis