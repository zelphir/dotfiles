local wezterm = require("wezterm")
local module = {}

local function h(path)
  if not path then
    return wezterm.home_dir
  end
  return wezterm.home_dir .. "/" .. path
end

local function project_dirs()
  local dirs = { "/Volumes/Workspace/kraken/*", "/Volumes/Workspace/others/*", h(".config/*") }
  local projects = {}
  for _, dir in ipairs(dirs) do
    for _, p in ipairs(wezterm.glob(dir)) do
      table.insert(projects, p)
    end
  end
  return projects
end

function module.choose_project()
  local choices = {}
  for _, value in ipairs(project_dirs()) do
    table.insert(choices, { label = value })
  end

  return wezterm.action.InputSelector({
    title = "Workspaces",
    choices = choices,
    fuzzy = true,
    action = wezterm.action_callback(function(child_window, child_pane, _, label)
      if label then
        child_window:perform_action(
          wezterm.action.SwitchToWorkspace({
            name = label:match("([^/]+)$"),
            spawn = {
              cwd = label,
            },
          }),
          child_pane
        )
      end
    end),
  })
end

return module
