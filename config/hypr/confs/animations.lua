hl.config({
    animations = {
        enabled = true,
    },
})

-- Bezier Curves
hl.curve("fluent_decel",   { type = "bezier", points = { {0.1, 1}, {0, 1} } })
hl.curve("md3_decel",      { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })
hl.curve("md3_accel",      { type = "bezier", points = { {0.3, 0}, {0.8, 0.15} } })
hl.curve("elegant_bounce", { type = "bezier", points = { {0.55, 1.07}, {0.28, 1.12} } })
hl.curve("backward",       { type = "bezier", points = { {0.49, 0.09}, {0.38, 1.24} } })
hl.curve("linear",         { type = "bezier", points = { {1, 1}, {1, 1} } })

-- Windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "elegant_bounce", style = "slide down" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "md3_accel", style = "slide up" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "fluent_decel", style = "slide" })

-- Borders
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linear", style = "loop" })

-- Fading
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "fluent_decel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "md3_decel", style = "slidefadevert 15%" })

-- Layers
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "fluent_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "md3_accel", style = "slide" })
