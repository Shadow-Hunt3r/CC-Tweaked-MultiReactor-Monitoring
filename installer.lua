local base = "https://raw.githubusercontent.com/Shadow-Hunt3r/CC-Tweaked-MultiReactor-Monitoring/main/"

local files = {
  "config.lua",
  "loader.lua",
  "reactorHandler.lua",
  "turbineHandler.lua",
}

for _, file in ipairs(files) do
  local url = base .. file
  print("Downloading " .. file .. "...")
  shell.run("wget", url, file)
end

print("✅ All files downloaded.")
