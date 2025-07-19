-- إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- إطار رئيسي (مع شكل مميز)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(1, 0, 0.5, -125) -- تبدأ من خارج الشاشة (يمين)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 100, 150) -- لون أزرق غامق
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- إضافة تأثير خلفية متدرجة
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 100, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 60, 90))
}
uiGradient.Parent = mainFrame

-- حواف مستديرة
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- تأثير التحريك
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenIn = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -150, 0.5, -125)})
local tweenOut = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(1, 0, 0.5, -125)})
tweenIn:Play()

-- عنوان Egg Randomizer
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- لون برتقالي مميز
titleLabel.Text = "Egg Randomizer"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- زر Randomize Eggs
local randomizeButton = Instance.new("TextButton")
randomizeButton.Size = UDim2.new(0.8, 0, 0, 50)
randomizeButton.Position = UDim2.new(0.1, 0, 0.25, 0)
randomizeButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- لون ذهبي
randomizeButton.Text = "Randomize Eggs"
randomizeButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- نص أسود للتباين
randomizeButton.Font = Enum.Font.SourceSansBold
randomizeButton.Parent = mainFrame
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = randomizeButton

-- خيار ESP
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0.8, 0, 0, 50)
espToggle.Position = UDim2.new(0.1, 0, 0.45, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- لون أخضر غامق
espToggle.Text = "ESP: OFF"
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.SourceSansBold
espToggle.Parent = mainFrame
local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 8)
espCorner.Parent = espToggle

-- خيار Auto Randomize
local autoToggle = Instance.new("TextButton")
autoToggle.Size = UDim2.new(0.8, 0, 0, 50)
autoToggle.Position = UDim2.new(0.1, 0, 0.65, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0) -- لون أخضر داكن
autoToggle.Text = "Auto Randomize: OFF"
autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoToggle.Font = Enum.Font.SourceSansBold
autoToggle.Parent = mainFrame
local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = autoToggle

-- زر إغلاق
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.8, 0, 0, 30)
closeButton.Position = UDim2.new(0.1, 0, 0.85, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- لون أحمر غامق
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- زر إعادة فتح (مخفي في البداية)
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 100, 0, 50)
reopenButton.Position = UDim2.new(0.9, -100, 0.5, -25)
reopenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- لون أخضر فاتح
reopenButton.Text = "Reopen Menu"
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.Font = Enum.Font.SourceSansBold
reopenButton.Visible = false
reopenButton.Parent = screenGui
local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(0, 8)
reopenCorner.Parent = reopenButton

-- وظيفة اكتشاف البيض تلقائيًا
local function detectEggs()
    local potentialEggs = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("egg") then
            table.insert(potentialEggs, obj)
        end
    end
    return potentialEggs
end

-- وظيفة تغيير الحيوانات الأليفة داخل البيض
local function randomizeEggs()
    local eggs = detectEggs()
    if #eggs == 0 then return end
    for _, egg in pairs(eggs) do
        if egg:IsA("Model") then
            local petInside = egg:FindFirstChild("Pet")
            if petInside then
                local newPet = game.Workspace.Pets:FindFirstChildOfClass("Model")
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

-- وظيفة ESP (عرض البيض)
local function toggleESP()
    local espState = espToggle.Text == "ESP: ON"
    local eggs = detectEggs()
    if #eggs == 0 then return end
    for _, egg in pairs(eggs) do
        if egg:IsA("Model") then
            local highlight = egg:FindFirstChild("EggHighlight") or Instance.new("Highlight")
            highlight.Name = "EggHighlight"
            highlight.Parent = egg
            highlight.Enabled = not espState
            highlight.FillColor = Color3.fromRGB(255, 215, 0)
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
            randomizeEggs()
            wait(5)
        end
    end)
end

-- ربط الأحداث
randomizeButton.MouseButton1Click:Connect(randomizeEggs)
espToggle.MouseButton1Click:Connect(toggleESP)
autoToggle.MouseButton1Click:Connect(toggleAutoRandomize)
closeButton.MouseButton1Click:Connect(function()
    tweenOut:Play()
    reopenButton.Visible = true
end)
reopenButton.MouseButton1Click:Connect(function()
    reopenButton.Visible = false
    tweenIn:Play()
end)
