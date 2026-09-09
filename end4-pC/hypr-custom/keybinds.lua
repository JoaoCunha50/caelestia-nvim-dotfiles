-- Manual Overrides
hl.unbind("SUPER + M")
hl.unbind("SUPER + SHIFT + M")
hl.unbind("SUPER + D")

-- Quickshell
hl.bind("SUPER + SHIFT + M", hl.dsp.global("quickshell:mediaControlsToggle"), { description = "Toggle media controls" })
hl.bind("SUPER + comma", hl.dsp.global("quickshell:settingsToggle"), { description = "Toggle settings" })

-- Special Workspaces
local specialWorkspaces = {
    chat  = { class = "vesktop", command = "vesktop" },
    music = { class = "Spotify", command = "spotify" },
}

local function toggleSpecial(name)
    local app = specialWorkspaces[name]
    return function()
        if #hl.get_windows({ class = app.class }) == 0 then
            hl.dispatch(hl.dsp.exec_cmd(app.command))
        end
        hl.dispatch(hl.dsp.workspace.toggle_special(name))
    end
end

hl.bind("SUPER + D", toggleSpecial("chat"), { description = "Toggle chat special workspace" })
hl.bind("SUPER + M", toggleSpecial("music"), { description = "Toggle music special workspace" })

-- Window Management
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
