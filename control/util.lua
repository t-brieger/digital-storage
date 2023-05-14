local gc = require("control/guiControl.lua")

local util = {}

-- dictionary of arrays of event handlers, where the key is the event being raised.
local handlers = {}

-- surely there's a better way to have multiple event handlers than this?
-- we can't use filters: as the docs state, 
--      "Each mod can only register once for every event. [...] This holds true even if different filters are used for subsequent registrations."
function util.AddEventHandler(events, handler, fireLast)
    if type(events) == "table" then
        for _, event in pairs(events) do
            if handlers[event] == nil then
                handlers[event] = {}
                script.on_event(event,
                    function(e)
                        for _, f in pairs(handlers[event]) do
                            f(e)
                            -- not exactly a great way to do it, but I believe the only "universal" one across types of events:
                            -- some fields on events can become "invalid" for various reasons (like, for examples, GUI elements being destroyed)
                            -- if this happens, stop calling further handlers (because they would probably error)
                            for __, field in pairs(e) do
                                if field and type(field) == "table" and field.valid ~= nil and not field.valid then
                                    return
                                end
                            end
                        end
                    end
                )
            end
            
            table.insert(handlers[event], handler)
        end

        return
    end

    util.AddEventHandler({events}, handler)
end

function util.StartsWith(str, start)
    return str:sub(1, #start) == start
end

function util.OverwriteGui(entityName, buildGui, redrawFunctionFactory)
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
            gc.setActiveGui(new_gui, redrawFunctionFactory(info), event.entity)
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

util.AddEventHandler(
        {defines.events.on_entity_died, defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity},
        function(e)
            if gc.currentGui and e.entity.unit_number == gc.currentGui.entity.unit_number then
                gc.closeActiveGui()
            end
        end
    )

util.AddEventHandler(
        defines.events.on_tick,
        gc.redrawGui
    )

return util