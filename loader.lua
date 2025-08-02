local config = dofile("config.lua")
local reactor = dofile("reactorHandler.lua")
local turbine = dofile("turbineHandler.lua")

-- Detect peripherals of a specific type (e.g., Reactor or Turbine)
local function getPeripheralsOfType(typeKey)
    local matchStr = config.AllowedTypes[typeKey]
    local matches = {}

    for _, name in ipairs(peripheral.getNames()) do
        local pType = peripheral.getType(name)
        if pType and pType:match(matchStr) then
            table.insert(matches, name)
        end
    end

    return matches
end

-- Get connected peripherals and counts
local reactors = getPeripheralsOfType(config.AllowedTypes.Reactor)
local turbines = getPeripheralsOfType(config.AllowedTypes.Turbine)

local reactorCount = #reactors
local turbineCount = #turbines
local maxReactor = config.AllowedMax.Reactor or 0
local maxTurbine = config.AllowedMax.Turbine or 0

-- Display findings
if reactorCount > 0 then
    print(("Reactor(s) detected. (%d/%d)"):format(reactorCount, maxReactor))
end

if turbineCount > 0 then
    print(("Turbine(s) detected. (%d/%d)"):format(turbineCount, maxTurbine))
end

-- Decision logic
if reactorCount > 0 and turbineCount == 0 then
    reactor.run()

elseif turbineCount > 0 and reactorCount == 0 then
    turbine.run()

elseif reactorCount > 0 and turbineCount > 0 then
    local handlers = {
    ["1"] = function() reactor.run() end,
    ["2"] = function() turbine.run() end
    }

    print("\nBoth Reactor and Turbine peripherals detected.")
    print("Choose which to manage:")
    print("[1] Reactors")
    print("[2] Turbines")
    io.write("> ")

    local choice = read()

    if handlers[choice] then
        handlers[choice]()
    else
        print("Invalid selection.")
    end
else
    print("No valid Reactor or Turbine peripherals detected.")
end
