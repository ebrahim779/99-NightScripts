– Pet Randomizer Script - Complete Working Version
– Made by: Woz
– Designed for Grow a Garden and similar pet games

local Players = game:GetService(“Players”)
local RunService = game:GetService(“RunService”)
local TweenService = game:GetService(“TweenService”)
local UserInputService = game:GetService(“UserInputService”)
local ReplicatedStorage = game:GetService(“ReplicatedStorage”)
local Workspace = game:GetService(“Workspace”)
local CoreGui = game:GetService(“CoreGui”)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild(“PlayerGui”)
local mouse = player:GetMouse()

– Configuration
local config = {
espEnabled = true,
autoRandomize = false,
autoRandomizeInterval = 3,
espColor = Color3.fromRGB(255, 255, 0),
espTransparency = 0.3,
detectedGameName = “Unknown Game”
}

– Game Detection System
local function detectGame()
local gameDetection = {
[“Grow a Garden”] = {
identifiers = {“Garden”, “Plant”, “Seed”, “Flower”, “Tree”, “GrowthSystem”},
petLocations = {“Pets”, “PlayerPets”, “Garden”, “Plants”},
eggLocations = {“Eggs”, “Seeds”, “EggSpawns”, “SeedSpawns”},
randomizeEvents = {“HatchEgg”, “PlantSeed”, “RandomizeEgg”, “EggHatch”, “SeedPlant”}
},
[“Pet Simulator”] = {
identifiers = {“PetSimulator”, “Coins”, “Gems”, “Rebirth”, “World”},
petLocations = {“Pets”, “PlayerPets”, “SpawnedPets”},
eggLocations = {“Eggs”, “EggSpawns”, “Shop”},
randomizeEvents = {“HatchEgg”, “BuyEgg”, “OpenEgg”, “PurchaseEgg”}
},
[“Adopt Me”] = {
identifiers = {“AdoptMe”, “Nursery”, “School”, “Hospital”, “Shops”},
petLocations = {“Pets”, “PlayerPets”, “AdoptedPets”},
eggLocations = {“Eggs”, “NurseryEggs”, “Shop”},
randomizeEvents = {“HatchEgg”, “AdoptPet”, “BuyEgg”}
}
}

```
-- Check game name first
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

for gameType, data in pairs(gameDetection) do
    for _, identifier in pairs(data.identifiers) do
        if gameName:lower():find(identifier:lower()) or
           Workspace:FindFirstChild(identifier) or
           ReplicatedStorage:FindFirstChild(identifier) then
            config.detectedGameName = gameType
            return data
        end
    end
end

-- Default detection
return {
    petLocations = {"Pets", "PlayerPets", "SpawnedPets", "Characters"},
    eggLocations = {"Eggs", "EggSpawns", "Shop", "Store"},
    randomizeEvents = {"HatchEgg", "RandomizeEgg", "OpenEgg", "BuyEgg", "PurchaseEgg"}
}
```

end

– Create Main GUI
local function createMainGUI()
– Remove existing GUI if it exists
if playerGui:FindFirstChild(“PetRandomizerGUI”) then
playerGui:FindFirstChild(“PetRandomizerGUI”):Destroy()
end

```
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetRandomizerGUI"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

-- Main Frame (Control Panel)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(101, 67, 33)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Add shadow effect
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 8, 1, 8)
shadow.Position = UDim2.new(0, -4, 0, -4)
shadow.BackgroundColor3 = Color3.new(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = mainFrame.ZIndex - 1
shadow.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Title with paw prints
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "🐾 Pet Randomizer ✨"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Credits
local credits = Instance.new("TextLabel")
credits.Name = "Credits"
credits.Size = UDim2.new(1, 0, 0, 25)
credits.Position = UDim2.new(0, 0, 0, 55)
credits.BackgroundTransparency = 1
credits.Text = "Made by - munkizzz"
credits.TextColor3 = Color3.fromRGB(200, 200, 200)
credits.TextScaled = true
credits.Font = Enum.Font.Gotham
credits.Parent = mainFrame

-- Game Detection Label
local gameLabel = Instance.new("TextLabel")
gameLabel.Name = "GameLabel"
gameLabel.Size = UDim2.new(1, 0, 0, 20)
gameLabel.Position = UDim2.new(0, 0, 0, 75)
gameLabel.BackgroundTransparency = 1
gameLabel.Text = "Detected: " .. config.detectedGameName
gameLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
gameLabel.TextScaled = true
gameLabel.Font = Enum.Font.Gotham
gameLabel.Parent = mainFrame

-- Randomize Pets Button (Orange like in image)
local randomizeBtn = Instance.new("TextButton")
randomizeBtn.Name = "RandomizeButton"
randomizeBtn.Size = UDim2.new(0.9, 0, 0, 50)
randomizeBtn.Position = UDim2.new(0.05, 0, 0, 100)
randomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
randomizeBtn.BorderSizePixel = 0
randomizeBtn.Text = "🎲 Randomize Pets"
randomizeBtn.TextColor3 = Color3.new(1, 1, 1)
randomizeBtn.TextScaled = true
randomizeBtn.Font = Enum.Font.GothamBold
randomizeBtn.Parent = mainFrame

local randomizeCorner = Instance.new("UICorner")
randomizeCorner.CornerRadius = UDim.new(0, 8)
randomizeCorner.Parent = randomizeBtn

-- ESP Button (Dark Gray like in image)
local espBtn = Instance.new("TextButton")
espBtn.Name = "ESPButton"
espBtn.Size = UDim2.new(0.9, 0, 0, 40)
espBtn.Position = UDim2.new(0.05, 0, 0, 160)
espBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
espBtn.BorderSizePixel = 0
espBtn.Text = "👁️ ESP: ON"
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.TextScaled = true
espBtn.Font = Enum.Font.GothamBold
espBtn.Parent = mainFrame

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 8)
espCorner.Parent = espBtn

-- Auto Randomize Button (Green like in image)
local autoBtn = Instance.new("TextButton")
autoBtn.Name = "AutoButton"
autoBtn.Size = UDim2.new(0.9, 0, 0, 40)
autoBtn.Position = UDim2.new(0.05, 0, 0, 210)
autoBtn.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
autoBtn.BorderSizePixel = 0
autoBtn.Text = "🔄 Auto Randomize: OFF"
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.TextScaled = true
autoBtn.Font = Enum.Font.GothamBold
autoBtn.Parent = mainFrame

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = autoBtn

-- Close Button (Red X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeBtn

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0.9, 0, 0, 30)
statusLabel.Position = UDim2.new(0.05, 0, 0, 260)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready to randomize!"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Controls Info
local controlsLabel = Instance.new("TextLabel")
controlsLabel.Name = "ControlsLabel"
controlsLabel.Size = UDim2.new(0.9, 0, 0, 25)
controlsLabel.Position = UDim2.new(0.05, 0, 0, 290)
controlsLabel.BackgroundTransparency = 1
controlsLabel.Text = "Press F to toggle GUI | Drag to move"
controlsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
controlsLabel.TextScaled = true
controlsLabel.Font = Enum.Font.Gotham
controlsLabel.Parent = mainFrame

-- Pet Count Label
local petCountLabel = Instance.new("TextLabel")
petCountLabel.Name = "PetCountLabel"
petCountLabel.Size = UDim2.new(0.9, 0, 0, 20)
petCountLabel.Position = UDim2.new(0.05, 0, 0, 320)
petCountLabel.BackgroundTransparency = 1
petCountLabel.Text = "Pets found: 0 | Eggs found: 0"
petCountLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
petCountLabel.TextScaled = true
petCountLabel.Font = Enum.Font.Gotham
petCountLabel.Parent = mainFrame

return screenGui, mainFrame, randomizeBtn, espBtn, autoBtn, closeBtn, statusLabel, gameLabel, petCountLabel
```

end

– Enhanced Pet and Egg Detection
local function findPetsAndEggs()
local pets = {}
local eggs = {}
local gameData = detectGame()

```
-- Search in workspace
local function searchInLocation(location, targetTable, searchTerms)
    if not location then return end
    
    for _, obj in pairs(location:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart") then
            local objName = obj.Name:lower()
            
            for _, term in pairs(searchTerms) do
                if objName:find(term:lower()) then
                    table.insert(targetTable, obj)
                    break
                end
            end
        end
    end
end

-- Pet search terms
local petSearchTerms = {"pet", "animal", "companion", "creature", "char", "npc"}

-- Egg search terms
local eggSearchTerms = {"egg", "seed", "spawn", "hatch", "incubator", "nest"}

-- Search in common locations
local searchLocations = {
    Workspace,
    Workspace:FindFirstChild("Game"),
    Workspace:FindFirstChild("Map"),
    Workspace:FindFirstChild("World"),
    Workspace:FindFirstChild("Environment")
}

-- Add game-specific locations
for _, location in pairs(gameData.petLocations) do
    table.insert(searchLocations, Workspace:FindFirstChild(location))
end

for _, location in pairs(gameData.eggLocations) do
    table.insert(searchLocations, Workspace:FindFirstChild(location))
end

-- Search all locations
for _, location in pairs(searchLocations) do
    searchInLocation(location, pets, petSearchTerms)
    searchInLocation(location, eggs, eggSearchTerms)
end

-- Search in player characters
for _, otherPlayer in pairs(Players:GetPlayers()) do
    if otherPlayer.Character then
        searchInLocation(otherPlayer.Character, pets, petSearchTerms)
    end
end

return pets, eggs
```

end

– ESP System
local espHighlights = {}
local espBillboards = {}

local function createESP(obj, isEgg)
if not obj or not obj.Parent then return end

```
local color = isEgg and Color3.fromRGB(255, 0, 255) or config.espColor

local highlight = Instance.new("Highlight")
highlight.Name = isEgg and "EggESP" or "PetESP"
highlight.Adornee = obj
highlight.FillColor = color
highlight.FillTransparency = config.espTransparency
highlight.OutlineColor = Color3.new(1, 1, 1)
highlight.OutlineTransparency = 0.2
highlight.Parent = obj

table.insert(espHighlights, highlight)

-- Find part for billboard
local attachPart = obj:FindFirstChild("HumanoidRootPart") or 
                  obj:FindFirstChild("PrimaryPart") or 
                  obj:FindFirstChildOfClass("Part") or
                  obj:FindFirstChildOfClass("MeshPart")

if attachPart then
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.LightInfluence = 0
    billboard.Parent = attachPart
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = (isEgg and "🥚 " or "🐾 ") .. obj.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextScaled = true
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboard
    
    table.insert(espBillboards, billboard)
end
```

end

local function updateESP()
– Clear existing ESP
for _, highlight in pairs(espHighlights) do
if highlight and highlight.Parent then
highlight:Destroy()
end
end
for _, billboard in pairs(espBillboards) do
if billboard and billboard.Parent then
billboard:Destroy()
end
end
espHighlights = {}
espBillboards = {}

```
if config.espEnabled then
    local pets, eggs = findPetsAndEggs()
    
    for _, pet in pairs(pets) do
        createESP(pet, false)
    end
    
    for _, egg in pairs(eggs) do
        createESP(egg, true)
    end
    
    -- Update pet count
    local gui = playerGui:FindFirstChild("PetRandomizerGUI")
    if gui then
        local petCountLabel = gui.MainFrame:FindFirstChild("PetCountLabel")
        if petCountLabel then
            petCountLabel.Text = "Pets found: " .. #pets .. " | Eggs found: " .. #eggs
        end
    end
end
```

end

– Enhanced Randomization System
local function randomizeEggs(statusLabel)
statusLabel.Text = “Randomizing eggs and pets…”
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

```
local success = false
local gameData = detectGame()

-- Method 1: Game-specific remote events
for _, eventName in pairs(gameData.randomizeEvents) do
    local remote = ReplicatedStorage:FindFirstChild(eventName, true)
    if remote then
        if remote:IsA("RemoteEvent") then
            for i = 1, 10 do
                pcall(function()
                    remote:FireServer()
                    remote:FireServer("hatch")
                    remote:FireServer("randomize")
                    remote:FireServer(true)
                    remote:FireServer(1)
                    remote:FireServer(player)
                end)
                wait(0.1)
            end
            success = true
        elseif remote:IsA("RemoteFunction") then
            for i = 1, 10 do
                pcall(function()
                    remote:InvokeServer()
                    remote:InvokeServer("hatch")
                    remote:InvokeServer("randomize")
                    remote:InvokeServer(true)
                end)
                wait(0.1)
            end
            success = true
        end
    end
end

-- Method 2: Find and interact with eggs directly
local _, eggs = findPetsAndEggs()
for _, egg in pairs(eggs) do
    pcall(function()
        -- Try to find ClickDetector
        local clickDetector = egg:FindFirstChild("ClickDetector", true)
        if clickDetector then
            for i = 1, 5 do
                fireclickdetector(clickDetector)
                wait(0.1)
            end
            success = true
        end
        
        -- Try to find ProximityPrompt
        local proximityPrompt = egg:FindFirstChild("ProximityPrompt", true)
        if proximityPrompt then
            for i = 1, 5 do
                fireproximityprompt(proximityPrompt)
                wait(0.1)
            end
            success = true
        end
    end)
end

-- Method 3: GUI interaction
local guiNames = {"EggGUI", "PetGUI", "ShopGUI", "InventoryGUI", "HatchGUI", "GachaGUI"}
for _, guiName in pairs(guiNames) do
    local gui = playerGui:FindFirstChild(guiName) or playerGui:FindFirstChild(guiName, true)
    if gui then
        local buttonNames = {"Hatch", "Open", "Buy", "Purchase", "Randomize", "Roll", "Spin"}
        for _, buttonName in pairs(buttonNames) do
            local button = gui:FindFirstChild(buttonName, true)
            if button and button:IsA("GuiButton") then
                for i = 1, 10 do
                    pcall(function()
                        button.MouseButton1Click:Fire()
                        if button.Activated then
                            button.Activated:Fire()
                        end
                    end)
                    wait(0.1)
                end
                success = true
            end
        end
    end
end

-- Method 4: Try common remote names
local commonRemotes = {
    "HatchEgg", "OpenEgg", "BuyEgg", "PurchaseEgg", "RandomizeEgg",
    "EggHatch", "EggOpen", "EggBuy", "EggPurchase", "EggRandomize",
    "PetHatch", "PetOpen", "PetBuy", "PetRandomize", "PetRoll"
}

for _, remoteName in pairs(commonRemotes) do
    local remote = ReplicatedStorage:FindFirstChild(remoteName, true)
    if remote and remote:IsA("RemoteEvent") then
        for i = 1, 15 do
            pcall(function()
                remote:FireServer()
                remote:FireServer("all")
                remote:FireServer(1)
                remote:FireServer(player)
                remote:FireServer(true)
            end)
            wait(0.05)
        end
        success = true
    end
end

if success then
    statusLabel.Text = "Eggs and pets randomized!"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
else
    statusLabel.Text = "No randomization method found!"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
end

-- Update ESP
wait(1)
updateESP()

-- Reset status
wait(2)
statusLabel.Text = "Ready to randomize!"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
```

end

– Auto Randomize System
local autoRandomizeRunning = false

local function startAutoRandomize(statusLabel)
if autoRandomizeRunning then return end
autoRandomizeRunning = true

```
spawn(function()
    while config.autoRandomize and autoRandomizeRunning do
        randomizeEggs(statusLabel)
        wait(config.autoRandomizeInterval)
    end
    autoRandomizeRunning = false
end)
```

end

local function stopAutoRandomize()
autoRandomizeRunning = false
config.autoRandomize = false
end

– Main Setup Function
local function setupGUI()
local gameData = detectGame()
local screenGui, mainFrame, randomizeBtn, espBtn, autoBtn, closeBtn, statusLabel, gameLabel, petCountLabel = createMainGUI()

```
-- Update game label
gameLabel.Text = "Detected: " .. config.detectedGameName

-- Button Events
randomizeBtn.MouseButton1Click:Connect(function()
    spawn(function()
        randomizeEggs(statusLabel)
    end)
end)

espBtn.MouseButton1Click:Connect(function()
    config.espEnabled = not config.espEnabled
    espBtn.Text = config.espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF"
    espBtn.BackgroundColor3 = config.espEnabled and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(100, 100, 100)
    updateESP()
end)

autoBtn.MouseButton1Click:Connect(function()
    config.autoRandomize = not config.autoRandomize
    autoBtn.Text = config.autoRandomize and "🔄 Auto Randomize: ON" or "🔄 Auto Randomize: OFF"
    autoBtn.BackgroundColor3 = config.autoRandomize and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(120, 120, 120)
    
    if config.autoRandomize then
        startAutoRandomize(statusLabel)
    else
        stopAutoRandomize()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    stopAutoRandomize()
    screenGui:Destroy()
end)

-- Initial ESP update
updateESP()

-- Continuous updates
spawn(function()
    while screenGui.Parent do
        wait(3)
        if config.espEnabled then
            updateESP()
        end
    end
end)
```

end

– Initialize Script
print(“🐾 Pet Randomizer Script Loaded!”)
print(“Made by: munkizzz”)
print(“Press F to toggle GUI”)

– Create GUI on startup
setupGUI()

– Keybind to toggle GUI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

```
if input.KeyCode == Enum.KeyCode.F then
    local existingGUI = playerGui:FindFirstChild("PetRandomizerGUI")
    if existingGUI then
        existingGUI:Destroy()
    else
        setupGUI()
    end
end
```

end)

– Auto-reconnect on respawn
player.CharacterAdded:Connect(function()
wait(2)
if not playerGui:FindFirstChild(“PetRandomizerGUI”) then
setupGUI()
end
end)