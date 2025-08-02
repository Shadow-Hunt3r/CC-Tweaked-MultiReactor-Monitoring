local base = "https://raw.githubusercontent.com/YourUsername/YourRepo/main/"

local files = {
  "config.lua",
  "utils.lua",
  "loader.lua",
  "reactorHandler.lua",
  "turbineHandler.lua",
  "autoSelector.lua"
}

for _, file in ipairs(files) do
  local url = base .. file
  print("Downloading " .. file .. "...")
  shell.run("wget", url, file)
end

print("✅ All files downloaded.")
