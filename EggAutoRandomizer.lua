-- إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- إطار رئيسي (شكل مشابه للصورة)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(1, 0, 0.5, -100) -- تبدأ من خارج الشاشة (يمين)
mainFrame.BackgroundColor3 = Color3.fromRGB(139, 69, 19) -- لون بني غامق مثل الصورة
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- تأثير التحريك
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenIn = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -150, 0.5, -100)})
local tweenOut = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(1, 0, 0.5, -100)})
tweenIn:Play()

-- عنوان Pet Randomizer
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1 -- شفاف ليظهر الخلفية
titleLabel.Text = "Egg Randomizer"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

-- إضافة أيقونات القدمين والنجوم
local pawIcon1 = Instance.new("ImageLabel")
pawIcon1.Size = UDim2.new(0, 20, 0, 20)
pawIcon1.Position = UDim2.new(0.05, 0, 0.1, 0)
pawIcon1.Image = "rbxassetid://11677106844" -- أيقونة قدم (يمكنك تغيير الـ asset ID)
pawIcon1.BackgroundTransparency = 1
pawIcon1.Parent = titleLabel

local pawIcon2 = pawIcon1:Clone()
pawIcon2.Position = UDim2.new(0.1, 0, 0.1, 0)
pawIcon2.Parent = titleLabel

local starIcon1 = Instance.new("ImageLabel")
starIcon1.Size = UDim2.new(0, 20, 0, 20)
starIcon1.Position = UDim2.new(0.85, 0, 0.1, 0)
starIcon1.Image = "rbxassetid://11677106844" -- أيقونة نجمة (يمكنك تغيير الـ asset ID)
starIcon1.BackgroundTransparency = 1
starIcon1.Parent = titleLabel

local starIcon2 = starIcon1:Clone()
starIcon2.Position = UDim2.new(0.9, 0, 0.1, 0)
starIcon2.Parent = titleLabel

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, 0, 0, 20)
madeByLabel.Position = UDim2.new(0, 0, 0.6, 0)
madeByLabel.BackgroundTransparency = 1
madeByLabel.Text = "Made by - munkizzz"
madeByLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
madeByLabel.Font = Enum.Font.SourceSans
madeByLabel.TextSize = 14
madeByLabel.Parent = titleLabel

-- زر Randomize Pets
local randomizeButton = Instance.new("TextButton")
randomizeButton.Size = UDim2.new(1, -10, 0, 50)
randomizeButton.Position = UDim2.new(0.05, 0, 0.3, 0)
randomizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- لون برتقالي
randomizeButton.Text = "Randomize Eggs"
randomizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizeButton.Font = Enum.Font.SourceSansBold
randomizeButton.Parent = mainFrame

-- أيقونة النرد
local diceIcon = Instance.new("ImageLabel")
diceIcon.Size = UDim2.new(0, 30, 0, 30)
diceIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
diceIcon.Image = "rbxassetid://11677106844" -- أيقونة نرد (يمكنك تغيير الـ asset ID)
diceIcon.BackgroundTransparency = 1
diceIcon.Parent = randomizeButton

-- خيار ESP
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(1, -10, 0, 50)
espToggle.Position = UDim2.new(0.05, 0, 0.5, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- لون رمادي داكن
espToggle.Text = "ESP: OFF"
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.SourceSansBold
espToggle.Parent = mainFrame

-- أيقونة العين
local eyeIcon = Instance.new("ImageLabel")
eyeIcon.Size = UDim2.new(0, 30, 0, 30)
eyeIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
eyeIcon.Image = "rbxassetid://11677106844" -- أيقونة عين (يمكنك تغيير الـ asset ID)
eyeIcon.BackgroundTransparency = 1
eyeIcon.Parent = espToggle

-- خيار Auto Randomize
local autoToggle = Instance.new("TextButton")
autoToggle.Size = UDim2.new(1, -10, 0, 50)
autoToggle.Position = UDim2.new(0.05, 0, 0.7, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(0, 128, 0) -- لون أخضر
autoToggle.Text = "Auto Randomize: OFF"
autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoToggle.Font = Enum.Font.SourceSansBold
autoToggle.Parent = mainFrame

-- أيقونة الدوران
local refreshIcon = Instance.new("ImageLabel")
refreshIcon.Size = UDim2.new(0, 30, 0, 30)
refreshIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
refreshIcon.Image = "rbxassetid://11677106844" -- أيقونة دوران (يمكنك تغيير الـ asset ID)
refreshIcon.BackgroundTransparency = 1
refreshIcon.Parent = autoToggle

-- زر إغلاق
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.8, 0, 0, 30)
closeButton.Position = UDim2.new(0.1, 0, 0.85, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- لون أحمر
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame

-- زر إعادة فتح (مخفي في البداية)
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 100, 0, 50)
reopenButton.Position = UDim2.new(0.9, -100, 0.5, -25)
reopenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- لون أخضر
reopenButton.Text = "Reopen Menu"
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.Font = Enum.Font.SourceSansBold
reopenButton.Visible = false
reopenButton.Parent = screenGui

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
