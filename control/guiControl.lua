local control = {}

control.currentGui = nil
function control.redrawGui()
    if control.currentGui == nil then
        return
    end
    control.currentGui.redraw()
end
function control.setActiveGui(topLevelElement, redraw, entity)
    if control.currentGui ~= nil then
        control.closeActiveGui()
    end
    control.currentGui = {
        element = topLevelElement,
        redraw = redraw,
        entity = entity
    }
end
function control.closeActiveGui()
    if control.currentGui == nil then
        return
    end
    control.currentGui.element.destroy()
    control.currentGui = nil
end

return control