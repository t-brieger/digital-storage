local gc = require("./guiControl.lua")

local util = {}

-- dictionary of arrays of event handlers, where the key is the event being raised.
local handlers = {}

-- surely there's a better way to have multiple event handlers than this?
function util.AddEventHandler(event, handler)
    if handlers[event] == nil then
        handlers[event] = {}
        script.on_event(event,
            function(e)
                for _, f in pairs(handlers[event]) do
                    f(e)
                end
            end
        )
    end
    
    table.insert(handlers[event], handler)
end

function util.StartsWith(str, start)
    return str:sub(1, #start) == start
end

function util.OverwriteGui(entityName, buildGui, update)
    util.AddEventHandler(
        defines.events.on_gui_opened,
        function(event)
            if event.entity == nil or event.entity.name ~= entityName or (event.element ~= nil and util.StartsWith(event.element.name, "digistore:")) then
                -- either not our entity's GUI, or not the one we are trying to intercept (and instead the one we created)
                return
            end

            local player = game.get_player(event.player_index)
            local info = {
                parent = player.gui.screen,
                entity = event.entity
            }
            local new_gui = buildGui(info)
            info.element = new_gui
            gc.setActiveGui(new_gui, update(info))
            player.opened = new_gui
        end
    )
end

util.AddEventHandler(
        defines.events.on_gui_closed,
        function(e)
            if e.element and util.StartsWith(e.element.name, "digistore:") then
                gc.closeActiveGui()
            end
        end
    )

-- probably not very efficient, but the player will (hopefully) not be running around just having a config GUI open so it's not a huge problem.
util.AddEventHandler(
        defines.events.on_tick,
        gc.redrawGui
    )

return util