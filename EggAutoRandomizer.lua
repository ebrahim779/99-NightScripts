– Pet Randomizer UI for Roblox (تعليمي فقط)
– ضع هذا السكريبت في StarterGui أو كـ LocalScript

local Players = game:GetService(“Players”)
local UserInputService = game:GetService(“UserInputService”)
local TweenService = game:GetService(“TweenService”)
local RunService = game:GetService(“RunService”)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild(“PlayerGui”)

– إنشاء ScreenGui
local screenGui = Instance.new(“ScreenGui”)
screenGui.Name = “PetRandomizerGUI”
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

– الإعدادات
local settings = {
esp = true,
autoRandomize = false,
visible = true
}

– إنشاء الإطار الرئيسي
local mainFrame = Instance.new(“Frame”)
mainFrame.Name = “MainFrame”
mainFrame.Size = UDim2.new(0, 350, 0, 200)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

– إضافة Corner للتدوير
local corner = Instance.new(“UICorner”)
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

– إنشاء الهيدر
local header = Instance.new(“Frame”)
header.Name = “Header”
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(139, 90, 60)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new(“UICorner”)
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

– نص العنوان
local titleLabel = Instance.new(“TextLabel”)
titleLabel.Name = “TitleLabel”
titleLabel.Size = UDim2.new(1, -20, 1, -20)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = “🐾 Pet Randomizer ✨”
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = header

– نص المطور
local creatorLabel = Instance.new(“TextLabel”)
creatorLabel.Name = “CreatorLabel”
creatorLabel.Size = UDim2.new(1, -20, 0, 15)
creatorLabel.Position = UDim2.new(0, 10, 1, -25)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Text = “Made by - munkizzz”
creatorLabel.TextColor3 = Color3.fromRGB(212, 165, 116)
creatorLabel.TextScaled = true
creatorLabel.Font = Enum.Font.Gotham
creatorLabel.Parent = header

– زر Randomize Pets
local randomizeButton = Instance.new(“TextButton”)
randomizeButton.Name = “RandomizeButton”
randomizeButton.Size = UDim2.new(1, -20, 0, 35)
randomizeButton.Position = UDim2.new(0, 10, 0, 70)
randomizeButton.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
randomizeButton.Text = “🎲 Randomize Pets”
randomizeButton.TextColor3 = Color3.new(1, 1, 1)
randomizeButton.TextScaled = true
randomizeButton.Font = Enum.Font.GothamSemibold
randomizeButton.BorderSizePixel = 0
randomizeButton.Parent = mainFrame

local randomizeCorner = Instance.new(“UICorner”)
randomizeCorner.CornerRadius = UDim.new(0, 5)
randomizeCorner.Parent = randomizeButton

– ESP Toggle
local espFrame = Instance.new(“Frame”)
espFrame.Name = “ESPFrame”
espFrame.Size = UDim2.new(1, -20, 0, 30)
espFrame.Position = UDim2.new(0, 10, 0, 115)
espFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espFrame.BorderSizePixel = 0
espFrame.Parent = mainFrame

local espCorner = Instance.new(“UICorner”)
espCorner.CornerRadius = UDim.new(0, 5)
espCorner.Parent = espFrame

local espLabel = Instance.new(“TextLabel”)
espLabel.Name = “ESPLabel”
espLabel.Size = UDim2.new(0.7, 0, 1, 0)
espLabel.Position = UDim2.new(0, 10, 0, 0)
espLabel.BackgroundTransparency = 1
espLabel.Text = “👁️ ESP”
espLabel.TextColor3 = Color3.new(1, 1, 1)
espLabel.TextScaled = true
espLabel.Font = Enum.Font.Gotham
espLabel.TextXAlignment = Enum.TextXAlignment.Left
espLabel.Parent = espFrame

local espStatus = Instance.new(“TextLabel”)
espStatus.Name = “ESPStatus”
espStatus.Size = UDim2.new(0.3, -10, 1, 0)
espStatus.Position = UDim2.new(0.7, 0, 0, 0)
espStatus.BackgroundTransparency = 1
espStatus.Text = “ON”
espStatus.TextColor3 = Color3.fromRGB(72, 187, 120)
espStatus.TextScaled = true
espStatus.Font = Enum.Font.GothamBold
espStatus.Parent = espFrame

– Auto Randomize Toggle
local autoFrame = Instance.new(“Frame”)
autoFrame.Name = “AutoFrame”
autoFrame.Size = UDim2.new(1, -20, 0, 30)
autoFrame.Position = UDim2.new(0, 10, 0, 155)
autoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
autoFrame.BorderSizePixel = 0
autoFrame.Parent = mainFrame

local autoCorner = Instance.new(“UICorner”)
autoCorner.CornerRadius = UDim.new(0, 5)
autoCorner.Parent = autoFrame

local autoLabel = Instance.new(“TextLabel”)
autoLabel.Name = “AutoLabel”
autoLabel.Size = UDim2.new(0.7, 0, 1, 0)
autoLabel.Position = UDim2.new(0, 10, 0, 0)
autoLabel.BackgroundTransparency = 1
autoLabel.Text = “🔄 Auto Randomize”
autoLabel.TextColor3 = Color3.new(1, 1, 1)
autoLabel.TextScaled = true
autoLabel.Font = Enum.Font.Gotham
autoLabel.TextXAlignment = Enum.TextXAlignment.Left
autoLabel.Parent = autoFrame

local autoStatus = Instance.new(“TextLabel”)
autoStatus.Name = “AutoStatus”
autoStatus.Size = UDim2.new(0.3, -10, 1, 0)
autoStatus.Position = UDim2.new(0.7, 0, 0, 0)
autoStatus.BackgroundTransparency = 1
autoStatus.Text = “OFF”
autoStatus.TextColor3 = Color3.fromRGB(229, 62, 62)
autoStatus.TextScaled = true
autoStatus.Font = Enum.Font.GothamBold
autoStatus.Parent = autoFrame

– متغيرات للوظائف
local espConnections = {}
local autoRandomizeConnection = nil
local espBoxes = {}

– وظائف التحكم
local function showNotification(message)
– إنشاء إشعار بسيط
local notification = Instance.new(“Frame”)
notification.Size = UDim2.new(0, 250, 0, 40)
notification.Position = UDim2.new(1, -260, 0, 10)
notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notification.BackgroundTransparency = 0.1
notification.BorderSizePixel = 0
notification.Parent = screenGui

```
local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 5)
notifCorner.Parent = notification

local notifLabel = Instance.new("TextLabel")
notifLabel.Size = UDim2.new(1, -10, 1, -10)
notifLabel.Position = UDim2.new(0, 5, 0, 5)
notifLabel.BackgroundTransparency = 1
notifLabel.Text = message
notifLabel.TextColor3 = Color3.new(1, 1, 1)
notifLabel.TextScaled = true
notifLabel.Font = Enum.Font.Gotham
notifLabel.Parent = notification

-- حذف الإشعار بعد 3 ثوان
game:GetService("Debris"):AddItem(notification, 3)
```

end

– وظيفة ESP للاعبين
local function createESPBox(part)
local espGui = Instance.new(“BillboardGui”)
espGui.Name = “ESPBox”
espGui.Adornee = part
espGui.Size = UDim2.new(4, 0, 6, 0)
espGui.StudsOffset = Vector3.new(0, 0, 0)
espGui.Parent = part

```
local espFrame = Instance.new("Frame")
espFrame.Size = UDim2.new(1, 0, 1, 0)
espFrame.BackgroundTransparency = 1
espFrame.BorderSizePixel = 2
espFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
espFrame.Parent = espGui

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 4)
espCorner.Parent = espFrame

-- إضافة اسم اللاعب
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 20)
nameLabel.Position = UDim2.new(0, 0, -0.3, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = part.Parent.Name
nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextStrokeTransparency = 0
nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
nameLabel.Parent = espGui

return espGui
```

end

local function enableESP()
– ESP للاعبين
for _, player in pairs(Players:GetPlayers()) do
if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild(“HumanoidRootPart”) then
local espBox = createESPBox(player.Character.HumanoidRootPart)
table.insert(espBoxes, espBox)
end
end

```
-- مراقبة اللاعبين الجدد
espConnections[1] = Players.PlayerAdded:Connect(function(player)
    if settings.esp then
        player.CharacterAdded:Connect(function(character)
            if character:FindFirstChild("HumanoidRootPart") then
                local espBox = createESPBox(character.HumanoidRootPart)
                table.insert(espBoxes, espBox)
            end
        end)
    end
end)
```

end

local function disableESP()
– إزالة جميع صناديق ESP
for _, espBox in pairs(espBoxes) do
if espBox then
espBox:Destroy()
end
end
espBoxes = {}

```
-- قطع الاتصالات
for _, connection in pairs(espConnections) do
    if connection then
        connection:Disconnect()
    end
end
espConnections = {}
```

end

local function toggleESP()
settings.esp = not settings.esp
if settings.esp then
espStatus.Text = “ON”
espStatus.TextColor3 = Color3.fromRGB(72, 187, 120)
enableESP()
showNotification(“ESP تم تفعيله!”)
else
espStatus.Text = “OFF”
espStatus.TextColor3 = Color3.fromRGB(229, 62, 62)
disableESP()
showNotification(“ESP تم إيقافه!”)
end
end

local function toggleAutoRandomize()
settings.autoRandomize = not settings.autoRandomize
if settings.autoRandomize then
autoStatus.Text = “ON”
autoStatus.TextColor3 = Color3.fromRGB(72, 187, 120)
showNotification(“Auto Randomize تم تفعيله!”)

```
    -- تشغيل Auto Randomize كل 5 ثوان
    autoRandomizeConnection = RunService.Heartbeat:Connect(function()
        wait(5)
        if settings.autoRandomize then
            randomizePets()
        end
    end)
else
    autoStatus.Text = "OFF"
    autoStatus.TextColor3 = Color3.fromRGB(229, 62, 62)
    showNotification("Auto Randomize تم إيقافه!")
    
    if autoRandomizeConnection then
        autoRandomizeConnection:Disconnect()
        autoRandomizeConnection = nil
    end
end
```

end

local function randomizePets()
showNotification(“تم تشغيل Randomize Pets!”)

```
-- محاولة البحث عن pets في workspace
local pets = {}
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("Model") and (string.find(string.lower(obj.Name), "pet") or 
                             string.find(string.lower(obj.Name), "animal") or
                             string.find(string.lower(obj.Name), "cat") or
                             string.find(string.lower(obj.Name), "dog")) then
        table.insert(pets, obj)
    end
end

-- تغيير مواقع الـ pets إذا وجدت
if #pets > 0 then
    for _, pet in pairs(pets) do
        if pet.PrimaryPart then
            local randomX = math.random(-50, 50)
            local randomZ = math.random(-50, 50)
            pet:SetPrimaryPartCFrame(pet.PrimaryPart.CFrame + Vector3.new(randomX, 0, randomZ))
        end
    end
    showNotification("تم تحريك " .. #pets .. " pets!")
else
    -- إنشاء تأثير بصري
    local sparkles = Instance.new("Sparkles")
    if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        sparkles.Parent = Players.LocalPlayer.Character.HumanoidRootPart
        game:GetService("Debris"):AddItem(sparkles, 3)
    end
    showNotification("تم تشغيل Randomize (لا توجد pets مرئية)!")
end

print("Randomizing pets executed!")
```

end

local function toggleMenu()
settings.visible = not settings.visible
mainFrame.Visible = settings.visible
end

– ربط الأحداث
randomizeButton.MouseButton1Click:Connect(randomizePets)

– جعل ESP قابل للنقر
local espButton = Instance.new(“TextButton”)
espButton.Size = UDim2.new(1, 0, 1, 0)
espButton.Position = UDim2.new(0, 0, 0, 0)
espButton.BackgroundTransparency = 1
espButton.Text = “”
espButton.Parent = espFrame
espButton.MouseButton1Click:Connect(toggleESP)

– جعل Auto Randomize قابل للنقر
local autoButton = Instance.new(“TextButton”)
autoButton.Size = UDim2.new(1, 0, 1, 0)
autoButton.Position = UDim2.new(0, 0, 0, 0)
autoButton.BackgroundTransparency = 1
autoButton.Text = “”
autoButton.Parent = autoFrame
autoButton.MouseButton1Click:Connect(toggleAutoRandomize)

– التحكم بالكيبورد (INSERT للإظهار/الإخفاء)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

```
if input.KeyCode == Enum.KeyCode.Insert then
    toggleMenu()
end
```

end)

– جعل النافذة قابلة للسحب
local dragging = false
local dragStart = nil
local startPos = nil

local function update(input)
local delta = input.Position - dragStart
mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = mainFrame.Position

```
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end
```

end)

header.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
update(input)
end
end)

– إضافة تأثيرات hover
local function addHoverEffect(button)
button.MouseEnter:Connect(function()
local tween = TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.1})
tween:Play()
end)

```
button.MouseLeave:Connect(function()
    local tween = TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0})
    tween:Play()
end)
```

end

addHoverEffect(randomizeButton)

– تفعيل ESP بشكل افتراضي عند التشغيل
if settings.esp then
enableESP()
end

print(“Pet Randomizer UI تم تحميله بنجاح مع الوظائف!”)
showNotification(“Pet Randomizer UI جاهز للاستخدام!”)
