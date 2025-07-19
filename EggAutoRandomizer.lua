-- إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- إطار رئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
mainFrame.Parent = screenGui

-- عنوان Pet Randomizer
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
titleLabel.Text = "Pet Randomizer"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

-- زر Randomize Pets
local randomizeButton = Instance.new("TextButton")
randomizeButton.Size = UDim2.new(0.8, 0, 0, 50)
randomizeButton.Position = UDim2.new(0.1, 0, 0.3, 0)
randomizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
randomizeButton.Text = "Randomize Pets"
randomizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizeButton.Font = Enum.Font.SourceSansBold
randomizeButton.Parent = mainFrame

-- خيار ESP
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0.8, 0, 0, 50)
espToggle.Position = UDim2.new(0.1, 0, 0.5, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espToggle.Text = "ESP: ON"
espToggle.TextColor3 = Color3.fromRGB(0, 191, 255)
espToggle.Font = Enum.Font.SourceSansBold
espToggle.Parent = mainFrame

-- خيار Auto Randomize
local autoToggle = Instance.new("TextButton")
autoToggle.Size = UDim2.new(0.8, 0, 0, 50)
autoToggle.Position = UDim2.new(0.1, 0, 0.7, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
autoToggle.Text = "Auto Randomize: OFF"
autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoToggle.Font = Enum.Font.SourceSansBold
autoToggle.Parent = mainFrame

-- وظيفة اكتشاف الحيوانات الأليفة تلقائيًا
local function detectPets()
    local potentialPets = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            table.insert(potentialPets, obj)
        end
    end
    return potentialPets
end

-- وظيفة تحديد الحيوانات الأليفة بشكل عشوائي
local function randomizePets()
    local pets = detectPets()
    for _, pet in pairs(pets) do
        if pet:IsA("Model") then
            local randomPosition = Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
            pet:MoveTo(randomPosition)
        end
    end
end

-- وظيفة ESP (عرض الحيوانات الأليفة)
local function toggleESP()
    local espState = espToggle.Text == "ESP: ON"
    local pets = detectPets()
    for _, pet in pairs(pets) do
        if pet:IsA("Model") then
            local highlight = pet:FindFirstChild("PetHighlight") or Instance.new("Highlight")
            highlight.Name = "PetHighlight"
            highlight.Parent = pet
            highlight.Enabled = espState
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
        end
    end
    espToggle.Text = "ESP: " .. (espState and "OFF" or "ON")
end

-- وظيفة Auto Randomize
local autoRunning = false
local function toggleAutoRandomize()
    autoRunning = not autoRunning
    autoToggle.Text = "Auto Randomize: " .. (autoRunning and "ON" or "OFF")
    spawn(function()
        while autoRunning do
            randomizePets()
            wait(5) -- كل 5 ثوانٍ
        end
    end)
end

-- ربط الأحداث لتشغيل الأوامر
randomizeButton.MouseButton1Click:Connect(randomizePets)
espToggle.MouseButton1Click:Connect(toggleESP)
autoToggle.MouseButton1Click:Connect(toggleAutoRandomize)
