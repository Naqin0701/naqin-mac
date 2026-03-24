# AGENTS.md - Agentic Coding Guidelines for sketchybar Config

This repository contains a sketchybar configuration written in Lua using the sbarlua library.

## Build / Validation Commands

### Syntax Validation
```bash
# Validate Lua syntax (requires luac installed)
luac -p ~/.config/sketchybar/init.lua

# Validate all Lua files in the config
for f in ~/.config/sketchybar/*.lua ~/.config/sketchybar/items/*.lua; do
  luac -p "$f" && echo "OK: $f"
done
```

### Reload Configuration
```bash
# Reload sketchybar (hot reload - no restart needed)
sketchybar --reload

# Full restart
brew services restart sketchybar
```

### Dependency Check
```bash
# Check sketchybar is running
sketchybar --ping

# Verify sbarlua is available
sbarlua -v
```

## Code Style Guidelines

### General Principles
- Use 2 spaces for indentation (no tabs)
- Use double quotes for strings (`"string"` not `'string'`)
- Add spaces around operators: `a + b` not `a+b`
- Add trailing commas in multi-line tables: `{ a = 1, b = 2, }`

### File Organization
```
~/.config/sketchybar/
├── sketchybarrc      # Shell entry point
├── init.lua          # Main config entry, requires all modules
├── colors.lua        # Color scheme (One Dark)
├── icons.lua         # Icon constants
├── bar.lua           # Bar appearance settings
├── default.lua       # Default item properties
└── items/
    ├── spaces.lua    # Yabai workspaces
    ├── clock.lua     # Clock widget
    ├── date.lua      # Date widget
    └── apps.lua      # App shortcuts
```

### Imports
```lua
-- Always use local require at the top of files
local colors = require("colors")
local sbar = require("sketchybar")

-- For nested modules, use relative paths
local module = require("items.spaces")
```

### Naming Conventions
- **Files**: snake_case.lua (e.g., `clock.lua`, `spaces.lua`)
- **Variables**: snake_case (e.g., `local num_spaces = 9`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `local DEFAULT_HEIGHT = 36`)
- **Item names**: dot-separated (e.g., `"apps.finder"`, `"widgets.clock"`)
- **Comments**: Use Chinese comments for user-facing config, English for code logic

### Table Definitions
```lua
-- Preferred: multi-line with trailing comma
local config = {
  key = "value",
  number = 42,
  nested = {
    inner = true,
  },
}

-- Single-line for simple cases
local colors = { fg = 0xffabb2bf, blue = 0xff61afef }
```

### Functions and Methods
```lua
-- Use colon syntax for sbarlua object methods
local item = sbar.add("item", "name", "left", { ... })

item:subscribe("mouse.entered", function(env)
  item:set({ background = { color = colors.bg_subtle } })
end)

-- Named function for complex callbacks
local function handle_space_change(env)
  local is_active = (tonumber(env.INFO.space) == i)
  -- ...
end
space:subscribe("space_change", handle_space_change)
```

### Error Handling
```lua
-- Check for nil before using values
if spaces_json and spaces_json ~= "" then
  -- safe to use
end

-- Use pcall for potentially failing operations
local success, result = pcall(function()
  return some_function()
end)
if not success then
  -- handle error
end
```

### sbarlua Specific Patterns

#### Item Creation
```lua
local item = sbar.add("item", "unique.name", "left|right", {
  icon = { ... },
  label = { ... },
  background = { ... },
  padding_left = 2,
  padding_right = 2,
  click_script = "shell command",
})
```

#### Updating Items
```lua
-- Set properties
item:set({ icon = { string = "new_icon" } })

-- Subscribe to events
item:subscribe("update", function(_)
  -- periodic update
end)
```

#### Colors
- Use hex format with alpha: `0xAARRGGBB` or `0xRRGGBB`
- Colors module (`colors.lua`) defines One Dark palette
- Always import colors: `local colors = require("colors")`

### Configuration Tips

1. **Right-side items**: Require files in reverse order (rightmost first) since sketchybar renders right items right-to-left

2. **Workspace count**: Update `NUM_SPACES` in `items/spaces.lua` to match your yabai configuration

3. **App shortcuts**: Edit `app_list` table in `items/apps.lua` to customize

4. **Hot reload**: Configuration supports live reload via `sbar.hotload(true)` - no need to restart

### Common Patterns

#### Hover Effects
```lua
item:subscribe("mouse.entered", function(_)
  item:set({ background = { color = colors.bg_subtle } })
end)

item:subscribe("mouse.exited", function(_)
  item:set({ background = { color = colors.transparent } })
end)
```

#### Conditional Styling
```lua
item:subscribe("space_change", function(env)
  local is_active = (tonumber(env.INFO.space) == target)
  item:set({
    icon = { color = is_active and colors.blue or colors.fg_dim },
    background = { color = is_active and colors.bg_dim or colors.transparent },
  })
end)
```

### Adding New Items

1. Create new file in `items/` directory
2. Add require in `init.lua` (order matters for right-side items)
3. Use existing items as templates
4. Run `sketchybar --reload` to test
