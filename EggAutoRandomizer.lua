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

– وظيفة اكتشاف البيض تلقائيًا
local function detectEggs()
local potentialEggs = {}
for _, obj in pairs(game.Workspace:GetDescendants()) do
if obj:IsA(“Model”) and obj.Name:lower():find(“egg”) then
table.insert(potentialEggs, obj)
end
end
return potentialEggs
end

– وظيفة تغيير الحيوانات الأليفة داخل البيض
local function randomizeEggs()
local eggs = detectEggs()
if #eggs == 0 then return end
for _, egg in pairs(eggs) do
if egg:IsA(“Model”) then
local petInside = egg:FindFirstChild(“Pet”)
if petInside then
local newPet = game.Workspace.Pets:FindFirstChildOfClass(“Model”)
if newPet then
petInside:Destroy()
newPet:Clone().Parent = egg
local randomPosition = Vector3.new(math.random(-50, 50), egg.Position.Y, math.random(-50, 50))
pcall(function() egg:MoveTo(randomPosition) end)
end
end
end
end
end

– وظيفة ESP (عرض البيض)
local function toggleESP()
local espState = espToggle.Text:find(“ON”) ~= nil
local eggs = detectEggs()
if #eggs == 0 then return end
for _, egg in pairs(eggs) do
if egg:IsA(“Model”) then
local highlight = egg:FindFirstChild(“EggHighlight”) or Instance.new(“Highlight”)
highlight.Name = “EggHighlight”
highlight.Parent = egg
highlight.Enabled = not espState
highlight.FillColor = Color3.fromRGB(255, 215, 0)
highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
end
end
espToggle.Text = “👁️ ESP: “ .. (espState and “OFF” or “ON”)
espToggle.BackgroundColor3 = espState and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(0, 100, 200)
end

– وظيفة Auto Randomize
local autoRunning = false
local function toggleAutoRandomize()
autoRunning = not autoRunning
autoToggle.Text = “⚡ Auto Randomize: “ .. (autoRunning and “ON” or “OFF”)
autoToggle.BackgroundColor3 = autoRunning and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(0, 128, 0)
spawn(function()
while autoRunning do
randomizeEggs()
wait(5)
end
end)
end

– ربط الأحداث
randomizeButton.MouseButton1Click:Connect(randomizeEggs)
espToggle.MouseButton1Click:Connect(toggleESP)
autoToggle.MouseButton1Click:Connect(toggleAutoRandomize)
closeButton.MouseButton1Click:Connect(hideMenu)
closeButtonX.MouseButton1Click:Connect(hideMenu)
reopenButton.MouseButton1Click:Connect(showMenu)

print(“🥚 Egg Randomizer GUI loaded successfully! You can now drag the menu around and close/reopen it.”)
