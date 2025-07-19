– إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new(“ScreenGui”)
screenGui.Parent = game.Players.LocalPlayer:WaitForChild(“PlayerGui”)

– إطار رئيسي
local mainFrame = Instance.new(“Frame”)
mainFrame.Size = UDim2.new(0, 300, 0, 280)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
mainFrame.Parent = screenGui

– جعل الإطار قابل للسحب
local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
local delta = input.Position - dragStart
mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

– شريط العنوان للسحب
local titleBar = Instance.new(“Frame”)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

– عنوان Egg Randomizer
local titleLabel = Instance.new(“TextLabel”)
titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = “🥚 Egg Randomizer”
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

– زر X للإغلاق في شريط العنوان
local closeButtonX = Instance.new(“TextButton”)
closeButtonX.Size = UDim2.new(0, 40, 0, 40)
closeButtonX.Position = UDim2.new(1, -45, 0, 5)
closeButtonX.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
closeButtonX.Text = “✕”
closeButtonX.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButtonX.Font = Enum.Font.SourceSansBold
closeButtonX.TextSize = 16
closeButtonX.BorderSizePixel = 0
closeButtonX.Parent = titleBar

– أحداث السحب
titleBar.InputBegan:Connect(function(input)
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

titleBar.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
if dragging then
updateInput(input)
end
end
end)

– محتوى القائمة
local contentFrame = Instance.new(“Frame”)
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

– زر Randomize Eggs
local randomizeButton = Instance.new(“TextButton”)
randomizeButton.Size = UDim2.new(0.9, 0, 0, 45)
randomizeButton.Position = UDim2.new(0.05, 0, 0.05, 0)
randomizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
randomizeButton.Text = “🎲 Randomize Eggs”
randomizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizeButton.Font = Enum.Font.SourceSansBold
randomizeButton.TextSize = 14
randomizeButton.BorderSizePixel = 0
randomizeButton.Parent = contentFrame

– تأثير hover للأزرار
local function addHoverEffect(button, normalColor, hoverColor)
button.MouseEnter:Connect(function()
button.BackgroundColor3 = hoverColor
end)
button.MouseLeave:Connect(function()
button.BackgroundColor3 = normalColor
end)
end

addHoverEffect(randomizeButton, Color3.fromRGB(255, 165, 0), Color3.fromRGB(255, 185, 50))

– خيار ESP
local espToggle = Instance.new(“TextButton”)
espToggle.Size = UDim2.new(0.9, 0, 0, 45)
espToggle.Position = UDim2.new(0.05, 0, 0.25, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espToggle.Text = “👁️ ESP: OFF”
espToggle.TextColor3 = Color3.fromRGB(0, 191, 255)
espToggle.Font = Enum.Font.SourceSansBold
espToggle.TextSize = 14
espToggle.BorderSizePixel = 0
espToggle.Parent = contentFrame

addHoverEffect(espToggle, Color3.fromRGB(50, 50, 50), Color3.fromRGB(70, 70, 70))

– خيار Auto Randomize
local autoToggle = Instance.new(“TextButton”)
autoToggle.Size = UDim2.new(0.9, 0, 0, 45)
autoToggle.Position = UDim2.new(0.05, 0, 0.45, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
autoToggle.Text = “⚡ Auto Randomize: OFF”
autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoToggle.Font = Enum.Font.SourceSansBold
autoToggle.TextSize = 14
autoToggle.BorderSizePixel = 0
autoToggle.Parent = contentFrame

addHoverEffect(autoToggle, Color3.fromRGB(0, 128, 0), Color3.fromRGB(0, 148, 0))

– زر إغلاق
local closeButton = Instance.new(“TextButton”)
closeButton.Size = UDim2.new(0.9, 0, 0, 40)
closeButton.Position = UDim2.new(0.05, 0, 0.7, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = “🚪 Close Menu”
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.BorderSizePixel = 0
closeButton.Parent = contentFrame

addHoverEffect(closeButton, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 80, 80))

– زر إعادة فتح (مخفي في البداية)
local reopenButton = Instance.new(“TextButton”)
reopenButton.Size = UDim2.new(0, 120, 0, 50)
reopenButton.Position = UDim2.new(0, 20, 0, 20)
reopenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
reopenButton.Text = “📋 Open Menu”
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.Font = Enum.Font.SourceSansBold
reopenButton.TextSize = 12
reopenButton.BorderSizePixel = 0
reopenButton.Visible = false
reopenButton.Parent = screenGui

addHoverEffect(reopenButton, Color3.fromRGB(0, 200, 100), Color3.fromRGB(0, 220, 120))

– تأثيرات التحريك
local tweenService = game:GetService(“TweenService”)
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function hideMenu()
local tweenOut = tweenService:Create(mainFrame, tweenInfo, {
Size = UDim2.new(0, 0, 0, 0),
Position = UDim2.new(0.5, 0, 0.5, 0)
})
tweenOut:Play()
tweenOut.Completed:Connect(function()
mainFrame.Visible = false
reopenButton.Visible = true
– تأثير ظهور زر إعادة الفتح
local reopenTween = tweenService:Create(reopenButton, tweenInfo, {
Size = UDim2.new(0, 120, 0, 50)
})
reopenTween:Play()
end)
end

local function showMenu()
reopenButton.Visible = false
mainFrame.Visible = true
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

```
local tweenIn = tweenService:Create(mainFrame, tweenInfo, {
    Size = UDim2.new(0, 300, 0, 280),
    Position = UDim2.new(0.5, -150, 0.5, -140)
})
tweenIn:Play()
```

end

– وظيفة اكتشاف البيض في لعبة Grow a Garden
local function detectEggs()
local eggs = {}

```
-- البحث في أماكن مختلفة حيث قد توجد البيض
local searchLocations = {
    game.Workspace,
    game.Workspace:FindFirstChild("Eggs"),
    game.Workspace:FindFirstChild("Items"),
    game.Workspace:FindFirstChild("Collectibles"),
    game.Workspace:FindFirstChild("Garden"),
    game.Workspace:FindFirstChild("Map")
}

for _, location in pairs(searchLocations) do
    if location then
        for _, obj in pairs(location:GetDescendants()) do
            -- البحث عن البيض بطرق مختلفة
            if obj:IsA("Part") or obj:IsA("UnionOperation") or obj:IsA("Model") then
                local objName = obj.Name:lower()
                -- أنماط مختلفة لأسماء البيض في Grow a Garden
                if objName:find("egg") or 
                   objName:find("بيض") or 
                   objName:find("ovum") or
                   (obj:IsA("Part") and obj.Shape == Enum.PartType.Ball and obj.Size.X < 10) or
                   (obj.Parent and obj.Parent.Name:lower():find("egg")) then
                    table.insert(eggs, obj)
                end
            end
        end
    end
end

-- البحث في مخزون اللاعب أيضاً
local player = game.Players.LocalPlayer
if player.Character then
    for _, obj in pairs(player.Character:GetDescendants()) do
        if obj.Name:lower():find("egg") then
            table.insert(eggs, obj)
        end
    end
end

return eggs
```

end

– وظيفة تطبيق تأثيرات عشوائية على البيض
local function randomizeEggs()
local eggs = detectEggs()
local effectsApplied = 0

```
if #eggs == 0 then 
    print("❌ No eggs found in the game!")
    return 
end

print("🔍 Found " .. #eggs .. " eggs, applying randomization...")

for _, egg in pairs(eggs) do
    if egg and egg.Parent then
        -- تطبيق تأثيرات مختلفة حسب نوع الكائن
        pcall(function()
            -- تغيير اللون عشوائياً
            if egg:IsA("Part") then
                egg.BrickColor = BrickColor.Random()
                egg.Material = Enum.Material.Neon
                effectsApplied = effectsApplied + 1
            end
            
            -- تغيير الحجم قليلاً
            if egg.Size then
                local scale = math.random(80, 120) / 100
                egg.Size = egg.Size * scale
            end
            
            -- إضافة تأثير بريق
            local sparkles = egg:FindFirstChild("Sparkles") or Instance.new("Sparkles")
            sparkles.Parent = egg
            sparkles.SparkleColor = Color3.new(math.random(), math.random(), math.random())
            
            -- تدوير عشوائي
            if egg.CFrame then
                egg.CFrame = egg.CFrame * CFrame.Angles(
                    math.rad(math.random(-30, 30)),
                    math.rad(math.random(-30, 30)),
                    math.rad(math.random(-30, 30))
                )
            end
            
            -- إضافة ClickDetector للتفاعل
            if not egg:FindFirstChild("ClickDetector") then
                local click = Instance.new("ClickDetector")
                click.Parent = egg
                click.MouseClick:Connect(function()
                    print("🥚 Clicked randomized egg!")
                end)
            end
            
        end)
    end
end

print("✅ Applied randomization to " .. effectsApplied .. " eggs!")
```

end

– وظيفة ESP محسنة لجميع البيض
local function toggleESP()
local espState = espToggle.Text:find(“ON”) ~= nil
local eggs = detectEggs()

```
if #eggs == 0 then 
    print("❌ No eggs found for ESP!")
    return 
end

print("👁️ Toggling ESP for " .. #eggs .. " eggs...")

for _, egg in pairs(eggs) do
    if egg and egg.Parent then
        pcall(function()
            -- إزالة أو إضافة Highlight
            local highlight = egg:FindFirstChild("EggHighlight")
            if espState then
                -- إيقاف ESP
                if highlight then highlight:Destroy() end
                local billboard = egg:FindFirstChild("EggBillboard")
                if billboard then billboard:Destroy() end
            else
                -- تشغيل ESP
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "EggHighlight"
                    highlight.Parent = egg
                    highlight.FillColor = Color3.fromRGB(255, 215, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                end
                
                -- إضافة نص فوق البيضة
                if not egg:FindFirstChild("EggBillboard") and egg:FindFirstChildOfClass("Part") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "EggBillboard"
                    billboard.Parent = egg:FindFirstChildOfClass("Part")
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    
                    local label = Instance.new("TextLabel")
                    label.Parent = billboard
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = "🥚 EGG"
                    label.TextColor3 = Color3.fromRGB(255, 255, 0)
                    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    label.TextStrokeTransparency = 0
                    label.Font = Enum.Font.SourceSansBold
                    label.TextScaled = true
                end
            end
        end)
    end
end

espToggle.Text = "👁️ ESP: " .. (espState and "OFF" or "ON")
espToggle.BackgroundColor3 = espState and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(0, 100, 200)
print("✅ ESP " .. (espState and "disabled" or "enabled") .. "!")
```

end

– وظيفة Auto Randomize محسنة
local autoRunning = false
local autoConnection = nil

local function toggleAutoRandomize()
autoRunning = not autoRunning
autoToggle.Text = “⚡ Auto Randomize: “ .. (autoRunning and “ON” or “OFF”)
autoToggle.BackgroundColor3 = autoRunning and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(0, 128, 0)

```
if autoRunning then
    print("🔄 Auto Randomize started!")
    autoConnection = game:GetService("RunService").Heartbeat:Connect(function()
        wait(3) -- فترة انتظار أقل لتأثير أسرع
        randomizeEggs()
    end)
else
    print("⏹️ Auto Randomize stopped!")
    if autoConnection then
        autoConnection:Disconnect()
        autoConnection = nil
    end
end
```

end

– ربط الأحداث
randomizeButton.MouseButton1Click:Connect(randomizeEggs)
espToggle.MouseButton1Click:Connect(toggleESP)
autoToggle.MouseButton1Click:Connect(toggleAutoRandomize)
closeButton.MouseButton1Click:Connect(hideMenu)
closeButtonX.MouseButton1Click:Connect(hideMenu)
reopenButton.MouseButton1Click:Connect(showMenu)

print(“🥚 Advanced Egg Randomizer for Grow a Garden loaded successfully!”)
print(“📋 Features: Drag menu, randomize all eggs, ESP with labels, auto-randomize”)
print(“🎮 The script will work on ALL eggs found in the game world!”)
