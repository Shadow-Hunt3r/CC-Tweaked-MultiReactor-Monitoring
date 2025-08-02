local config = require("config")
local reactor = require("reactorHandler")
local turbine = require("turbineHandler")

-- Detect peripherals of a specific type (e.g., Reactor or Turbine)
local function getPeripheralsOfType(typeKey)
    local matchStr = config.allowedTypes[typeKey]
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
local reactors = getPeripheralsOfType("Reactor")
local turbines = getPeripheralsOfType("Turbine")

local reactorCount = #reactors
local turbineCount = #turbines
local maxReactor = config.allowedMax.Reactor or 0
local maxTurbine = config.allowedMax.Turbine or 0

-- Display findings
if reactorCount > 0 then
    print(("✅ Reactor(s) detected. (%d/%d)"):format(reactorCount, maxReactor))
end

if turbineCount > 0 then
    print(("✅ Turbine(s) detected. (%d/%d)"):format(turbineCount, maxTurbine))
end

-- Decision logic
if reactorCount > 0 and turbineCount == 0 then
    reactor.run()

elseif turbineCount > 0 and reactorCount == 0 then
    turbine.run()

elseif reactorCount > 0 and turbineCount > 0 then
    print("\nBoth Reactor and Turbine peripherals detected.")
    print("Choose which to manage:")
    print("[1] Reactors")
    print("[2] Turbines")
    io.write("> ")

    local choice = read()
    if choice == "1" then
        reactor.run()
    elseif choice == "2" then
        turbine.run()
    else
        print("❌ Invalid selection.")
    end

else
    print("❌ No valid Reactor or Turbine peripherals detected.")
end
