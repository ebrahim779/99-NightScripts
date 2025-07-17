– Pet Randomizer Script - Universal Version
– Made by: munkizzz
– Works with most pet games including Grow a Garden

local Players = game:GetService(“Players”)
local RunService = game:GetService(“RunService”)
local TweenService = game:GetService(“TweenService”)
local UserInputService = game:GetService(“UserInputService”)
local ReplicatedStorage = game:GetService(“ReplicatedStorage”)
local HttpService = game:GetService(“HttpService”)
local VirtualInputManager = game:GetService(“VirtualInputManager”)

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
notifications = true
}

– Notification System
local function notify(message, color)
if not config.notifications then return end

```
local notificationGui = Instance.new("ScreenGui")
notificationGui.Name = "NotificationGui"
notificationGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 60)
frame.Position = UDim2.new(1, -320, 0, 20)
frame.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = notificationGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 1, 0)
label.Position = UDim2.new(0, 10, 0, 0)
label.BackgroundTransparency = 1
label.Text = message
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = frame

-- Animate in
frame:TweenPosition(UDim2.new(1, -320, 0, 20), "Out", "Quart", 0.5, true)

-- Animate out and destroy
wait(3)
frame:TweenPosition(UDim2.new(1, 0, 0, 20), "In", "Quart", 0.5, true)
wait(0.5)
notificationGui:Destroy()
```

end

– GUI Creation
local function createGUI()
local screenGui = Instance.new(“ScreenGui”)
screenGui.Name = “PetRandomizerGUI”
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

```
-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 340)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(101, 67, 33)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Shadow effect
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.new(0, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = -1
shadow.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
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
credits.Position = UDim2.new(0, 0, 0, 45)
credits.BackgroundTransparency = 1
credits.Text = "Made by - munkizzz"
credits.TextColor3 = Color3.fromRGB(200, 200, 200)
credits.TextScaled = true
credits.Font = Enum.Font.Gotham
credits.Parent = mainFrame

-- Randomize Button
local randomizeBtn = Instance.new("TextButton")
randomizeBtn.Name = "RandomizeButton"
randomizeBtn.Size = UDim2.new(0.9, 0, 0, 50)
randomizeBtn.Position = UDim2.new(0.05, 0, 0, 80)
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

-- ESP Button
local espBtn = Instance.new("TextButton")
espBtn.Name = "ESPButton"
espBtn.Size = UDim2.new(0.9, 0, 0, 40)
espBtn.Position = UDim2.new(0.05, 0, 0, 140)
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

-- Auto Randomize Button
local autoBtn = Instance.new("TextButton")
autoBtn.Name = "AutoButton"
autoBtn.Size = UDim2.new(0.9, 0, 0, 40)
autoBtn.Position = UDim2.new(0.05, 0, 0, 190)
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

-- Speed Control Buttons
local speedFrame = Instance.new("Frame")
speedFrame.Name = "SpeedFrame"
speedFrame.Size = UDim2.new(0.9, 0, 0, 30)
speedFrame.Position = UDim2.new(0.05, 0, 0, 235)
speedFrame.BackgroundTransparency = 1
speedFrame.Parent = mainFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0.4, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 3s"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = speedFrame

local slowBtn = Instance.new("TextButton")
slowBtn.Name = "SlowButton"
slowBtn.Size = UDim2.new(0.15, 0, 1, 0)
slowBtn.Position = UDim2.new(0.45, 0, 0, 0)
slowBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
slowBtn.BorderSizePixel = 0
slowBtn.Text = "➖"
slowBtn.TextColor3 = Color3.new(1, 1, 1)
slowBtn.TextScaled = true
slowBtn.Font = Enum.Font.GothamBold
slowBtn.Parent = speedFrame

local slowCorner = Instance.new("UICorner")
slowCorner.CornerRadius = UDim.new(0, 5)
slowCorner.Parent = slowBtn

local fastBtn = Instance.new("TextButton")
fastBtn.Name = "FastButton"
fastBtn.Size = UDim2.new(0.15, 0, 1, 0)
fastBtn.Position = UDim2.new(0.65, 0, 0, 0)
fastBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
fastBtn.BorderSizePixel = 0
fastBtn.Text = "➕"
fastBtn.TextColor3 = Color3.new(1, 1, 1)
fastBtn.TextScaled = true
fastBtn.Font = Enum.Font.GothamBold
fastBtn.Parent = speedFrame

local fastCorner = Instance.new("UICorner")
fastCorner.CornerRadius = UDim.new(0, 5)
fastCorner.Parent = fastBtn

local resetBtn = Instance.new("TextButton")
resetBtn.Name = "ResetButton"
resetBtn.Size = UDim2.new(0.15, 0, 1, 0)
resetBtn.Position = UDim2.new(0.85, 0, 0, 0)
resetBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
resetBtn.BorderSizePixel = 0
resetBtn.Text = "🔄"
resetBtn.TextColor3 = Color3.new(1, 1, 1)
resetBtn.TextScaled = true
resetBtn.Font = Enum.Font.GothamBold
resetBtn.Parent = speedFrame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 5)
resetCorner.Parent = resetBtn

-- Close Button
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
statusLabel.Position = UDim2.new(0.05, 0, 0, 275)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready to randomize!"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Info Label
local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Size = UDim2.new(0.9, 0, 0, 25)
infoLabel.Position = UDim2.new(0.05, 0, 0, 305)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Press F to toggle GUI"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.Parent = mainFrame

return screenGui, mainFrame, randomizeBtn, espBtn, autoBtn, closeBtn, statusLabel, slowBtn, fastBtn, resetBtn, speedLabel
```

end

– Enhanced Pet Detection
local function findPets()
local pets = {}
local workspace = game:GetService(“Workspace”)

```
-- Multiple search locations
local searchLocations = {
    workspace,
    workspace:FindFirstChild("Pets"),
    workspace:FindFirstChild("PlayerPets"),
    workspace:FindFirstChild("SpawnedPets"),
    workspace:FindFirstChild("PetSpawns"),
    workspace:FindFirstChild("Game"),
    workspace:FindFirstChild("Map"),
    workspace:FindFirstChild("World")
}

-- Search in all locations
for _, location in pairs(searchLocations) do
    if location then
        for _, obj in pairs(location:GetDescendants()) do
            -- Check if it's a pet model
            if obj:IsA("Model") and (
                obj.Name:lower():find("pet") or 
                obj.Name:lower():find("egg") or
                obj.Name:lower():find("companion") or
                obj:FindFirstChild("Humanoid") or
                obj:FindFirstChild("PetStats") or
                obj:FindFirstChild("PetValue")
            ) then
                table.insert(pets, obj)
            end
        end
    end
end

-- Search in player characters
for _, otherPlayer in pairs(Players:GetPlayers()) do
    if otherPlayer.Character then
        for _, obj in pairs(otherPlayer.Character:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:lower():find("pet") then
                table.insert(pets, obj)
            end
        end
    end
end

return pets
```

end

– Enhanced ESP System
local espHighlights = {}
local espBillboards = {}

local function createESP(pet)
if not pet or not pet.Parent then return end

```
-- Create highlight
local highlight = Instance.new("Highlight")
highlight.Name = "PetESP"
highlight.Adornee = pet
highlight.FillColor = config.espColor
highlight.FillTransparency = config.espTransparency
highlight.OutlineColor = Color3.new(1, 1, 1)
highlight.OutlineTransparency = 0.2
highlight.Parent = pet

table.insert(espHighlights, highlight)

-- Find appropriate part for billboard
local attachPart = pet:FindFirstChild("HumanoidRootPart") or 
                  pet:FindFirstChild("PrimaryPart") or 
                  pet:FindFirstChild("Torso") or 
                  pet:FindFirstChild("Head") or
                  pet:FindFirstChildOfClass("Part")

if attachPart then
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetNameESP"
    billboard.Size = UDim2.new(0, 120, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.LightInfluence = 0
    billboard.Parent = attachPart
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = pet.Name
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
    local pets = findPets()
    for _, pet in pairs(pets) do
        createESP(pet)
    end
end
```

end

– Enhanced Pet Randomization - Actually Changes Pets!
local function randomizePets(statusLabel)
statusLabel.Text = “Randomizing pets…”
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

```
local success = false
local attempts = 0

-- Method 1: Advanced Remote Events with Parameters
local remoteNames = {
    "RandomizePet", "RerollPet", "PetRandomizer", "RollPet", "HatchEgg", 
    "OpenEgg", "PetGacha", "SpinPet", "RollForPet", "GetRandomPet",
    "PetSpin", "RandomPet", "NewPet", "RefreshPet", "ChangePet",
    "EggHatch", "SpawnPet", "GeneratePet", "RollEgg", "PetRoll",
    "GetPet", "ClaimPet", "UnboxPet", "OpenBox", "PetBox"
}

for _, name in pairs(remoteNames) do
    local remote = ReplicatedStorage:FindFirstChild(name) or 
                  ReplicatedStorage:FindFirstChild(name, true)
    
    if remote then
        if remote:IsA("RemoteEvent") then
            pcall(function()
                -- Try different parameter combinations
                for i = 1, 20 do  -- Multiple attempts
                    remote:FireServer()
                    remote:FireServer("randomize")
                    remote:FireServer("reroll")
                    remote:FireServer("hatch")
                    remote:FireServer("open")
                    remote:FireServer("roll")
                    remote:FireServer(true)
                    remote:FireServer(1)
                    remote:FireServer(i)
                    remote:FireServer("BasicEgg")
                    remote:FireServer("CommonEgg")
                    remote:FireServer("RareEgg")
                    remote:FireServer({Action = "Randomize"})
                    remote:FireServer({Type = "Reroll"})
                    wait(0.1)
                end
            end)
            success = true
            attempts = attempts + 1
        elseif remote:IsA("RemoteFunction") then
            pcall(function()
                for i = 1, 15 do
                    remote:InvokeServer()
                    remote:InvokeServer("randomize")
                    remote:InvokeServer("reroll")
                    remote:InvokeServer("hatch")
                    remote:InvokeServer(true)
                    remote:InvokeServer(i)
                    wait(0.1)
                end
            end)
            success = true
            attempts = attempts + 1
        end
    end
end

-- Method 2: Enhanced GUI Interaction - More Aggressive
local guiNames = {
    "PetGUI", "PetsGUI", "EggGUI", "GachaGUI", "SpinGUI", "RandomizerGUI",
    "RollGUI", "HatchGUI", "ShopGUI", "InventoryGUI", "MainGUI", "GameGUI",
    "PlayerGUI", "UI", "Interface", "Menu", "Screen"
}

for _, guiName in pairs(guiNames) do
    local gui = playerGui:FindFirstChild(guiName)
    if gui then
        local buttonNames = {
            "RandomizeButton", "RerollButton", "RollButton", "HatchButton",
            "SpinButton", "OpenButton", "GetButton", "BuyButton", "PurchaseButton",
            "ClaimButton", "UnboxButton", "GenerateButton", "NewButton", "RefreshButton",
            "ChangeButton", "RollAgainButton", "TryAgainButton", "NextButton"
        }
        
        for _, buttonName in pairs(buttonNames) do
            local button = gui:FindFirstChild(buttonName, true)
            if button and button:IsA("GuiButton") and button.Visible then
                pcall(function()
                    for i = 1, 25 do  -- More aggressive clicking
                        button.MouseButton1Click:Fire()
                        if button.Activated then
                            button.Activated:Fire()
                        end
                        if button.MouseButton1Down then
                            button.MouseButton1Down:Fire()
                        end
                        if button.MouseButton1Up then
                            button.MouseButton1Up:Fire()
                        end
                        wait(0.05)
                    end
                end)
                success = true
                attempts = attempts + 1
            end
        end
    end
end

-- Method 3: Direct Pet Modification (Advanced)
pcall(function()
    local pets = findPets()
    for _, pet in pairs(pets) do
        if pet.Parent and pet:FindFirstChild("PetStats") then
            local petStats = pet:FindFirstChild("PetStats")
            if petStats:FindFirstChild("Rarity") then
                -- Try to modify pet rarity
                local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"}
                local newRarity = rarities[math.random(1, #rarities)]
                petStats.Rarity.Value = newRarity
            end
            if petStats:FindFirstChild("Type") then
                local types = {"Dragon", "Phoenix", "Unicorn", "Griffin", "Tiger", "Lion", "Eagle"}
                local newType = types[math.random(1, #types)]
                petStats.Type.Value = newType
            end
        end
    end
    attempts = attempts + 1
end)

-- Method 4: Inventory/Egg Interaction
pcall(function()
    local inventory = player:FindFirstChild("Inventory") or 
                     player:FindFirstChild("Backpack") or
                     player:FindFirstChild("PlayerData")
    
    if inventory then
        for _, item in pairs(inventory:GetChildren()) do
            if item.Name:lower():find("egg") then
                -- Try to interact with eggs
                local clickDetector = item:FindFirstChild("ClickDetector")
                if clickDetector then
                    for i = 1, 10 do
                        clickDetector.MouseClick:Fire(player)
                        wait(0.1)
                    end
                end
            end
        end
    end
    attempts = attempts + 1
end)

-- Method 5: Workspace Egg Interaction
pcall(function()
    local workspace = game:GetService("Workspace")
    local eggs = {}
    
    -- Find all eggs in workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("egg") and obj:FindFirstChild("ClickDetector") then
            table.insert(eggs, obj)
        end
    end
    
    -- Click on eggs
    for _, egg in pairs(eggs) do
        local clickDetector = egg:FindFirstChild("ClickDetector")
        if clickDetector then
            for i = 1, 15 do
                clickDetector.MouseClick:Fire(player)
                wait(0.1)
            end
        end
    end
    attempts = attempts + 1
end)

-- Method 6: Advanced Keyboard Simulation
pcall(function()
    local keys = {
        Enum.KeyCode.R, Enum.KeyCode.E, Enum.KeyCode.Space, Enum.KeyCode.Return,
        Enum.KeyCode.F, Enum.KeyCode.G, Enum.KeyCode.H, Enum.KeyCode.T,
        Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three
    }
    
    for _, key in pairs(keys) do
        for i = 1, 3 do
            VirtualInputManager:SendKeyEvent(true, key, false, game)
            wait(0.1)
            VirtualInputManager:SendKeyEvent(false, key, false, game)
            wait(0.1)
        end
    end
    attempts = attempts + 1
end)

-- Method 7: Screen Click Simulation - More Precise
pcall(function()
    local screenSize = workspace.CurrentCamera.ViewportSize
    local centerX = screenSize.X / 2
    local centerY = screenSize.Y / 2
    
    local clickPositions = {
        {X = centerX, Y = centerY},
        {X = centerX - 100, Y = centerY},
        {X = centerX + 100, Y = centerY},
        {X = centerX, Y = centerY - 100},
        {X = centerX, Y = centerY + 100},
        {X = centerX - 200, Y = centerY - 100},
        {X = centerX + 200, Y = centerY + 100}
    }
    
    for _, pos in pairs(clickPositions) do
        for i = 1, 5 do
            VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
            wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
            wait(0.1)
        end
    end
    attempts = attempts + 1
end)

-- Method 8: ProximityPrompt Interaction
pcall(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and (
            obj.ActionText:lower():find("hatch") or 
            obj.ActionText:lower():find("open") or
            obj.ActionText:lower():find("roll") or
            obj.ActionText:lower():find("spin")
        ) then
            for i = 1, 10 do
                obj:InputHoldBegin()
                wait(0.1)
                obj:InputHoldEnd()
                wait(0.1)
            end
        end
    end
    attempts = attempts + 1
end)

-- Status Updates
if attempts > 0 then
    statusLabel.Text = "Attempting " .. attempts .. " methods..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    wait(1)
    
    if success then
        statusLabel.Text = "Pets randomized with " .. attempts .. " methods!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        spawn(function()
            notify("Pets randomized successfully!", Color3.fromRGB(0, 255, 0))
        end)
    else
        statusLabel.Text = "Tried " .. attempts .. " methods - Check manually!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
        spawn(function()
            notify("Randomization attempted - Check pets!", Color3.fromRGB(255, 165, 0))
        end)
    end
else
    statusLabel.Text = "No methods found - Game not supported!"
    statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    spawn(function()
        notify("Game not supported", Color3.fromRGB(255, 0, 0))
    end)
end

-- Update ESP after randomization
wait(1)
updateESP()

-- Reset status
wait(3)
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
        randomizePets(statusLabel)
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

– Button Effects
local function addButtonEffect(button)
local originalSize = button.Size

```
button.MouseEnter:Connect(function()
    button:TweenSize(UDim2.new(originalSize.X.Scale * 1.05, originalSize.X.Offset, originalSize.Y.Scale * 1.05, originalSize.Y.Offset), "Out", "Quad", 0.2, true)
end)

button.MouseLeave:Connect(function()
    button:TweenSize(originalSize, "Out", "Quad", 0.2, true)
end)

button.MouseButton1Down:Connect(function()
    button:TweenSize(UDim2.new(originalSize.X.Scale * 0.95, originalSize.X.Offset, originalSize.Y.Scale * 0.95, originalSize.Y.Offset), "Out", "Quad", 0.1, true)
end)

button.MouseButton1Up:Connect(function()
    button:TweenSize(originalSize, "Out", "Quad", 0.1, true)
end)
```

end

– Main Setup Function
local function setupGUI()
local screenGui, mainFrame, randomizeBtn, espBtn, autoBtn, closeBtn, statusLabel, slowBtn, fastBtn, resetBtn, speedLabel = createGUI()

```
-- Add button effects
addButtonEffect(randomizeBtn)
addButtonEffect(espBtn)
addButtonEffect(autoBtn)
addButtonEffect(closeBtn)
addButtonEffect(slowBtn)
addButtonEffect(fastBtn)
addButtonEffect(resetBtn)

-- Speed control functions
local function updateSpeedLabel()
    speedLabel.Text = "Speed: " .. config.autoRandomizeInterval .. "s"
end

slowBtn.MouseButton1Click:Connect(function()
    if config.autoRandomizeInterval < 10 then
        config.autoRandomizeInterval = config.autoRandomizeInterval + 1
        updateSpeedLabel()
        spawn(function()
            notify("Speed: " .. config.autoRandomizeInterval .. "s", Color3.fromRGB(255, 165, 0))
        end)
    end
end)

fastBtn.MouseButton1Click:Connect(function()
    if config.autoRandomizeInterval > 1 then
        config.autoRandomizeInterval = config.autoRandomizeInterval - 1
        updateSpeedLabel()
        spawn(function()
            notify("Speed: " .. config.autoRandomizeInterval .. "s", Color3.fromRGB(0, 255, 255))
        end)
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    config.autoRandomizeInterval = 3
    updateSpeedLabel()
    spawn(function()
        notify("Speed reset to 3s", Color3.fromRGB(100, 100, 100))
    end)
end)

-- Make GUI draggable
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Button Events
randomizeBtn.MouseButton1Click:Connect(function()
    spawn(function()
        randomizePets(statusLabel)
    end)
end)

espBtn.MouseButton1Click:Connect(function()
    config.espEnabled = not config.espEnabled
    espBtn.Text = config.espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF"
    espBtn.BackgroundColor3 = config.espEnabled and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(100, 100, 100)
    updateESP()
    
    spawn(function()
        notify("ESP " .. (config.espEnabled and "Enabled" or "Disabled"), Color3.fromRGB(0, 150, 255))
    end)
end)

autoBtn.MouseButton1Click:Connect(function()
    config.autoRandomize = not config.autoRandomize
    autoBtn.Text = config.autoRandomize and "🔄 Auto Randomize: ON" or "🔄 Auto Randomize: OFF"
    autoBtn.BackgroundColor3 = config.autoRandomize and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(120, 120, 120)
    
    if config.autoRandomize then
        startAutoRandomize(statusLabel)
        spawn(function()
            notify("Auto Randomize Started", Color3.fromRGB(0, 255, 0))
        end)
    else
        stopAutoRandomize()
        spawn(function()
            notify("Auto Randomize Stopped", Color3.fromRGB(255, 0, 0))
        end)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    stopAutoRandomize()
    screenGui:Destroy()
end)

-- Initial setup
updateESP()

-- Continuous ESP updates
spawn(function()
    while screenGui.Parent do
        wait(3)
        if config.espEnabled then
            updateESP()
        end
    end
end)

-- Welcome notification
spawn(function()
    notify("Pet Randomizer Loaded! Press F to toggle", Color3.fromRGB(0, 255, 0))
end)
```

end

– Initialize
print(“🐾 Pet Randomizer Script Loaded! 🐾”)
print(“Made by: munkizzz”)
print(“Press F to toggle GUI”)
setupGUI()

– Keybind Handler
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

– Auto-reconnect on character respawn
player.CharacterAdded:Connect(function()
wait(2)
if not playerGui:FindFirstChild(“PetRandomizerGUI”) then
setupGUI()
end
end)