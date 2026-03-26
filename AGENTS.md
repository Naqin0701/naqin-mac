# AGENTS.md - Sketchybar Configuration

This is a **sketchybar** configuration repository. Sketchybar is a macOS status bar app configured via Lua.

## Repository Structure

```
sketchybar/.config/sketchybar/
├── init.lua              # Main entry point
├── globals.lua           # Global constants (SBAR, COLORS, DEFAULT_ITEM)
├── colors.lua            # Color scheme definitions
├── default.lua           # Default item styling
├── sketchybarrc         # Executable entry script
├── items/               # Status bar item definitions
│   ├── battery.lua
│   ├── calendar.lua
│   ├── clipboard.lua
│   ├── control_center.lua
│   ├── menus.lua
│   ├── pomodoro.lua
│   ├── resources.lua
│   ├── separator.lua
│   ├── spaces.lua
│   ├── spotify.lua
│   ├── theme_picker.lua
│   └── volume.lua
└── helpers/              # Helper modules
    ├── icon_map.lua      # App name to icon mapping
    └── menus/            # C-based menu helper
        ├── menus.c
        └── makefile
```

## Build/Lint/Test Commands

This is a **configuration repository**, not a software project. There are no traditional build/test commands.

### Reloading Configuration

To reload the sketchybar configuration:

```bash
sketchybar --reload
```

Or restart the sketchybar service.

### Building the Menus Helper (C Binary)

```bash
cd helpers/menus && make
```

### Syntax Check for Lua

To validate Lua syntax (requires lua installed):

```bash
lua -c items/*.lua helpers/*.lua *.lua
```

## Code Style Guidelines

### Language

This is **Lua** code using the sketchybar Lua API.

### Global Constants

All global constants are defined in `globals.lua`:

```lua
SBAR = require("sketchybar")      -- The main sketchybar API
COLORS = require("colors")         -- Color constants
DEFAULT_ITEM = require("default")   -- Default styling
APPLICATION_MENU_COLLAPSED = true  -- State flag
APPLICATION_MENU_TRANSITION_FRAMES = 30  -- Animation frames
```

**Never hardcode these values directly.** Always reference `SBAR`, `COLORS`, and `DEFAULT_ITEM`.

### Color Format

Colors are **ARGB hex integers** (not strings):

```lua
-- Format: 0xAARRGGBB
colors.white = 0xffffffff
colors.red = 0xffff4444
colors.transparent = 0x00000000
```

To convert from hex string to number:
```lua
local hex_color = 0xff15bdf9  -- direct number
```

### Creating Items

Use `SBAR.add()` to create status bar items:

```lua
local item = SBAR.add("item", "item_name", {
    position = "right",  -- or "left"
    update_freq = 60,
    icon = {
        font = { family = "Hack Nerd Font", style = "Regular", size = 13.5 },
        string = "icon",
        color = COLORS.accent_color,
        padding_left = 10,
        padding_right = 10,
        y_offset = 1,
    },
    label = {
        font = { family = "Hack Nerd Font", style = "Semibold", size = 13.5 },
        string = "label",
        drawing = false,  -- hidden by default
    },
    background = { drawing = true },
    drawing = true,
})
```

### Creating Brackets

Brackets group items together with shared background:

```lua
SBAR.add("bracket", { "item1", "item2", "item3" }, {
    background = { drawing = true },
})
```

### Updating Items

Use `:set()` method to update item properties:

```lua
item:set({
    icon = { string = "new_icon", color = COLORS.red },
    label = { drawing = true },
    drawing = true,
})
```

Use `SBAR.set()` with regex pattern for bulk updates:

```lua
SBAR.set("/menu\\..*/", { width = 0 })
```

### Event Handling

Subscribe to events with `:subscribe()`:

```lua
item:subscribe("mouse.clicked", function(env)
    -- Handle click
end)

item:subscribe({ "mouse.entered", "mouse.exited" }, function(env)
    -- Handle multiple events
end)

item:subscribe({ "routine", "power_source_change", "system_woke" }, callback)
```

Available events: `mouse.clicked`, `mouse.entered`, `mouse.exited`, `routine`, `power_source_change`, `system_woke`, `aerospace_workspace_change`, `front_app_switched`, `space_windows_change`, `display_change`

### Executing Shell Commands

```lua
SBAR.exec("pmset -g batt", function(output)
    -- Handle command output
end)

SBAR.exec("aerospace workspace " .. workspace_id)  -- Fire and forget
```

### Delayed Execution

```lua
SBAR.delay(0.5, function()
    -- Runs after 0.5 seconds
end)

SBAR.delay_cancel(timer_id)  -- Cancel a delayed execution
```

### Animations

```lua
SBAR.animate("sin", 10, function()
    item:set({ y_offset = 6 })
end)

SBAR.animate("tanh", 30, function()
    -- Animation logic
end)
```

### Configuration Batching

Wrap multiple operations in batch calls for performance:

```lua
SBAR.begin_config()
-- All SBAR.add() and item:set() calls here
SBAR.end_config()
```

### Custom Events

Define custom events:

```lua
SBAR.add("event", "aerospace_is_ready")
SBAR.trigger("aerospace_is_ready")
```

### File Paths

Use environment variables for paths:

```lua
local config_dir = os.getenv("CONFIG_DIR")
local menu_bin = config_dir .. "/helpers/menus/bin/menus"
```

### State Management

Use module-level variables for state:

```lua
local spaces_store = {}  -- keyed by workspace_id
local current_focused_workspace = nil
```

### String Pattern Matching

Lua pattern matching for parsing:

```lua
-- Find percentage
local found, _, charge = batt_info:find("(%d+)%%")

-- Split by newline
for line in windows:gmatch("[^\r\n]+") do
    local app, mid = line:match("^(.*)|(.-)$")
end
```

### String Trimming

```lua
local parsed = mode:gsub("^%s*(.-)%s*$", "%1")
```

### Returning Modules

For reusable modules (like separator.lua):

```lua
local M = {}

function M.create(name, position)
    -- implementation
    return separator
end

return M
```

### Requiring Modules

```lua
local separator_module = require("items.separator")
local icon_map = require("helpers.icon_map")
```

### Naming Conventions

- **Files**: `snake_case.lua`
- **Item names**: `item_name` (used in SBAR API)
- **Variables**: `snake_case`
- **Constants**: `UPPER_SNAKE_CASE` for config values, `PascalCase` for color scheme keys
- **Module table**: `M`

### Error Handling

Lua has no try-catch. Handle errors gracefully:

```lua
local handle = io.popen("command")
if handle then
    local result = handle:read("*a")
    handle:close()
    -- process result
end
```

### Font Names

Common fonts used:
- `Hack Nerd Font`
- `sketchybar-app-font` (special font for app icons)

### Icon Glyphs

Use Nerd Font glyphs or SF Symbols:
- `󰁹` (battery full)
- `󰂀` (battery 60%)
- `󰁾` (battery 40%)
- `󰁼` (battery 20%)
- `󰂎` (battery low)
- `` (charging)

## Dependencies

- **sketchybar** - The macOS status bar app
- **aerospace** - Workspace management (for spaces.lua)
- **pmset** - Battery info (system command)
- **clang** - For building the menus C helper (optional)
