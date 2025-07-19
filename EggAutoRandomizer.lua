– Enhanced Egg Randomizer Script
– إصدار محسن ومتطور

– خدمات اللعبة
local Players = game:GetService(“Players”)
local TweenService = game:GetService(“TweenService”)
local RunService = game:GetService(“RunService”)
local UserInputService = game:GetService(“UserInputService”)
local SoundService = game:GetService(“SoundService”)

– متغيرات أساسية
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild(“PlayerGui”)

– حالات النظام
local SystemStates = {
espEnabled = false,
autoRandomizeEnabled = false,
soundEnabled = true,
notifications = true
}

– إعدادات الألوان والتصميم
local UIColors = {
primary = Color3.fromRGB(45, 45, 55),
secondary = Color3.fromRGB(35, 35, 45),
accent = Color3.fromRGB(255, 165, 0),
success = Color3.fromRGB(46, 204, 113),
danger = Color3.fromRGB(231, 76, 60),
warning = Color3.fromRGB(241, 196, 15),
text = Color3.fromRGB(255, 255, 255),
textSecondary = Color3.fromRGB(189, 195, 199)
}

– إنشاء الواجهة الرئيسية
local function createMainUI()
– حاوي الواجهة الرئيسي
local screenGui = Instance.new(“ScreenGui”)
screenGui.Name = “EnhancedEggRandomizer”
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

```
-- الإطار الرئيسي مع تأثيرات بصرية
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 380, 0, 450)
mainFrame.Position = UDim2.new(1.2, 0, 0.5, -225)
mainFrame.BackgroundColor3 = UIColors.primary
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- تأثير الظل
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.Position = UDim2.new(0, -3, 0, -3)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = mainFrame.ZIndex - 1
shadow.Parent = mainFrame

-- تأثير التدرج في الخلفية
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, UIColors.primary),
    ColorSequenceKeypoint.new(1, UIColors.secondary)
}
gradient.Rotation = 45
gradient.Parent = mainFrame

-- زوايا مستديرة
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

local shadowCorner = corner:Clone()
shadowCorner.Parent = shadow

return screenGui, mainFrame
```

end

– إنشاء شريط العنوان
local function createTitleBar(parent)
local titleBar = Instance.new(“Frame”)
titleBar.Name = “TitleBar”
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = UIColors.accent
titleBar.BorderSizePixel = 0
titleBar.Parent = parent

```
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

-- إخفاء الزوايا السفلية
local bottomCover = Instance.new("Frame")
bottomCover.Size = UDim2.new(1, 0, 0, 15)
bottomCover.Position = UDim2.new(0, 0, 1, -15)
bottomCover.BackgroundColor3 = UIColors.accent
bottomCover.BorderSizePixel = 0
bottomCover.Parent = titleBar

-- عنوان النافذة
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -120, 1, 0)
titleLabel.Position = UDim2.new(0, 60, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🥚 Enhanced Egg Randomizer"
titleLabel.TextColor3 = UIColors.text
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- أيقونة البرنامج
local iconLabel = Instance.new("TextLabel")
iconLabel.Name = "IconLabel"
iconLabel.Size = UDim2.new(0, 50, 1, 0)
iconLabel.Position = UDim2.new(0, 5, 0, 0)
iconLabel.BackgroundTransparency = 1
iconLabel.Text = "🎲"
iconLabel.TextColor3 = UIColors.text
iconLabel.Font = Enum.Font.Gotham
iconLabel.TextSize = 24
iconLabel.Parent = titleBar

-- معلومات المطور
local creatorLabel = Instance.new("TextLabel")
creatorLabel.Name = "CreatorLabel"
creatorLabel.Size = UDim2.new(0, 110, 1, 0)
creatorLabel.Position = UDim2.new(1, -115, 0, 0)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Text = "by munkizzz"
creatorLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
creatorLabel.Font = Enum.Font.Gotham
creatorLabel.TextSize = 12
creatorLabel.TextXAlignment = Enum.TextXAlignment.Right
creatorLabel.Parent = titleBar

return titleBar
```

end

– إنشاء زر محسن
local function createEnhancedButton(name, text, icon, color, parent)
local button = Instance.new(“TextButton”)
button.Name = name
button.Size = UDim2.new(1, -20, 0, 50)
button.BackgroundColor3 = color
button.BorderSizePixel = 0
button.Font = Enum.Font.GothamSemibold
button.TextColor3 = UIColors.text
button.TextSize = 14
button.Parent = parent

```
-- زوايا مستديرة
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = button

-- تأثير الضغط
local pressEffect = Instance.new("Frame")
pressEffect.Name = "PressEffect"
pressEffect.Size = UDim2.new(1, 0, 1, 0)
pressEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
pressEffect.BackgroundTransparency = 1
pressEffect.BorderSizePixel = 0
pressEffect.Parent = button

local pressCorner = buttonCorner:Clone()
pressCorner.Parent = pressEffect

-- النص والأيقونة
local buttonText = Instance.new("TextLabel")
buttonText.Name = "ButtonText"
buttonText.Size = UDim2.new(1, -50, 1, 0)
buttonText.Position = UDim2.new(0, 45, 0, 0)
buttonText.BackgroundTransparency = 1
buttonText.Text = text
buttonText.TextColor3 = UIColors.text
buttonText.Font = Enum.Font.GothamSemibold
buttonText.TextSize = 14
buttonText.TextXAlignment = Enum.TextXAlignment.Left
buttonText.Parent = button

local buttonIcon = Instance.new("TextLabel")
buttonIcon.Name = "ButtonIcon"
buttonIcon.Size = UDim2.new(0, 40, 1, 0)
buttonIcon.Position = UDim2.new(0, 5, 0, 0)
buttonIcon.BackgroundTransparency = 1
buttonIcon.Text = icon
buttonIcon.TextColor3 = UIColors.text
buttonIcon.Font = Enum.Font.Gotham
buttonIcon.TextSize = 18
buttonIcon.Parent = button

-- تأثيرات بصرية
button.MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(
            math.min(255, color.R * 255 + 20),
            math.min(255, color.G * 255 + 20),
            math.min(255, color.B * 255 + 20)
        )
    })
    hoverTween:Play()
end)

button.MouseLeave:Connect(function()
    local unhoverTween = TweenService:Create(button, TweenInfo.new(0.2), {
        BackgroundColor3 = color
    })
    unhoverTween:Play()
end)

button.MouseButton1Down:Connect(function()
    local pressTween = TweenService:Create(pressEffect, TweenInfo.new(0.1), {
        BackgroundTransparency = 0.8
    })
    pressTween:Play()
end)

button.MouseButton1Up:Connect(function()
    local releaseTween = TweenService:Create(pressEffect, TweenInfo.new(0.1), {
        BackgroundTransparency = 1
    })
    releaseTween:Play()
end)

return button
```

end

– نظام الإشعارات
local function createNotification(message, notificationType)
if not SystemStates.notifications then return end

```
local notification = Instance.new("Frame")
notification.Name = "Notification"
notification.Size = UDim2.new(0, 300, 0, 60)
notification.Position = UDim2.new(1, 10, 1, -70)
notification.BackgroundColor3 = notificationType == "success" and UIColors.success or 
                               notificationType == "error" and UIColors.danger or UIColors.warning
notification.BorderSizePixel = 0
notification.Parent = playerGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 10)
notifCorner.Parent = notification

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1, -20, 1, 0)
notifText.Position = UDim2.new(0, 10, 0, 0)
notifText.BackgroundTransparency = 1
notifText.Text = message
notifText.TextColor3 = UIColors.text
notifText.Font = Enum.Font.Gotham
notifText.TextSize = 14
notifText.TextWrapped = true
notifText.Parent = notification

-- تحريك الإشعار
local slideIn = TweenService:Create(notification, TweenInfo.new(0.3), {
    Position = UDim2.new(1, -310, 1, -70)
})
slideIn:Play()

-- إخفاء الإشعار تلقائياً
wait(3)
local slideOut = TweenService:Create(notification, TweenInfo.new(0.3), {
    Position = UDim2.new(1, 10, 1, -70)
})
slideOut:Play()
slideOut.Completed:Connect(function()
    notification:Destroy()
end)
```

end

– وظائف النظام المحسنة
local EggSystem = {}

function EggSystem.detectEggs()
local eggs = {}
local searchAreas = {game.Workspace, game.Workspace.Map}

```
for _, area in pairs(searchAreas) do
    if area then
        for _, obj in pairs(area:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("Part") then
                local name = obj.Name:lower()
                if name:find("egg") or name:find("spawn") or name:find("hatch") then
                    table.insert(eggs, obj)
                end
            end
        end
    end
end

createNotification("تم العثور على " .. #eggs .. " بيضة", "success")
return eggs
```

end

function EggSystem.randomizeEggs()
local eggs = EggSystem.detectEggs()
local randomized = 0

```
for _, egg in pairs(eggs) do
    if egg and egg.Parent then
        -- محاولة تغيير خصائص البيضة
        pcall(function()
            if egg:IsA("Model") then
                local primaryPart = egg.PrimaryPart or egg:FindFirstChildOfClass("Part")
                if primaryPart then
                    -- تغيير اللون بشكل عشوائي
                    primaryPart.Color = Color3.fromHSV(math.random(), 1, 1)
                    
                    -- تأثير بصري
                    local highlight = primaryPart:FindFirstChild("RandomizeHighlight") or Instance.new("SelectionBox")
                    highlight.Name = "RandomizeHighlight"
                    highlight.Adornee = primaryPart
                    highlight.Color3 = Color3.fromRGB(255, 255, 0)
                    highlight.Transparency = 0.5
                    highlight.Parent = primaryPart
                    
                    -- إزالة التأثير بعد ثانيتين
                    game:GetService("Debris"):AddItem(highlight, 2)
                    
                    randomized = randomized + 1
                end
            end
        end)
    end
end

createNotification("تم تعديل " .. randomized .. " بيضة بنجاح", "success")
```

end

function EggSystem.toggleESP()
SystemStates.espEnabled = not SystemStates.espEnabled
local eggs = EggSystem.detectEggs()

```
for _, egg in pairs(eggs) do
    pcall(function()
        local highlight = egg:FindFirstChild("EggESP")
        if SystemStates.espEnabled then
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "EggESP"
                highlight.Parent = egg
            end
            highlight.Enabled = true
            highlight.FillColor = UIColors.warning
            highlight.OutlineColor = UIColors.danger
            highlight.FillTransparency = 0.5
        else
            if highlight then
                highlight:Destroy()
            end
        end
    end)
end

createNotification("ESP " .. (SystemStates.espEnabled and "مفعل" or "معطل"), "success")
```

end

function EggSystem.toggleAutoRandomize()
SystemStates.autoRandomizeEnabled = not SystemStates.autoRandomizeEnabled

```
if SystemStates.autoRandomizeEnabled then
    spawn(function()
        while SystemStates.autoRandomizeEnabled do
            EggSystem.randomizeEggs()
            wait(5) -- تكرار كل 5 ثوان
        end
    end)
    createNotification("التعديل التلقائي مفعل", "success")
else
    createNotification("التعديل التلقائي معطل", "warning")
end
```

end

– إنشاء الواجهة الكاملة
local function buildInterface()
local screenGui, mainFrame = createMainUI()
local titleBar = createTitleBar(mainFrame)

```
-- منطقة الأزرار
local buttonContainer = Instance.new("ScrollingFrame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -20, 1, -80)
buttonContainer.Position = UDim2.new(0, 10, 0, 70)
buttonContainer.BackgroundTransparency = 1
buttonContainer.BorderSizePixel = 0
buttonContainer.ScrollBarThickness = 6
buttonContainer.Parent = mainFrame

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.Padding = UDim.new(0, 10)
buttonLayout.Parent = buttonContainer

-- إنشاء الأزرار
local randomizeBtn = createEnhancedButton("RandomizeButton", "Randomize Eggs", "🎲", UIColors.accent, buttonContainer)
local espBtn = createEnhancedButton("ESPButton", "ESP: OFF", "👁️", UIColors.secondary, buttonContainer)
local autoBtn = createEnhancedButton("AutoButton", "Auto Randomize: OFF", "🔄", UIColors.success, buttonContainer)
local settingsBtn = createEnhancedButton("SettingsButton", "Settings", "⚙️", UIColors.secondary, buttonContainer)
local closeBtn = createEnhancedButton("CloseButton", "Close", "❌", UIColors.danger, buttonContainer)

-- زر إعادة الفتح
local reopenBtn = createEnhancedButton("ReopenButton", "Show", "📱", UIColors.success, screenGui)
reopenBtn.Size = UDim2.new(0, 100, 0, 40)
reopenBtn.Position = UDim2.new(1, -110, 0.5, -20)
reopenBtn.Visible = false

-- ربط الوظائف
randomizeBtn.MouseButton1Click:Connect(EggSystem.randomizeEggs)

espBtn.MouseButton1Click:Connect(function()
    EggSystem.toggleESP()
    espBtn.ButtonText.Text = "ESP: " .. (SystemStates.espEnabled and "ON" or "OFF")
end)

autoBtn.MouseButton1Click:Connect(function()
    EggSystem.toggleAutoRandomize()
    autoBtn.ButtonText.Text = "Auto Randomize: " .. (SystemStates.autoRandomizeEnabled and "ON" or "OFF")
end)

settingsBtn.MouseButton1Click:Connect(function()
    createNotification("الإعدادات قيد التطوير", "warning")
end)

-- تحريك النافذة
local function animateWindow(targetPosition)
    local tween = TweenService:Create(mainFrame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = targetPosition}
    )
    tween:Play()
    return tween
end

closeBtn.MouseButton1Click:Connect(function()
    animateWindow(UDim2.new(1.2, 0, 0.5, -225))
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    animateWindow(UDim2.new(0.5, -190, 0.5, -225))
    reopenBtn.Visible = false
end)

-- تحريك دخول النافذة
animateWindow(UDim2.new(0.5, -190, 0.5, -225))

-- رسالة ترحيب
wait(1)
createNotification("مرحباً بك في Enhanced Egg Randomizer!", "success")
```

end

– بدء تشغيل النظام
buildInterface()
