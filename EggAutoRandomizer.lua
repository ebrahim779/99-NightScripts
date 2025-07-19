-- إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- إطار رئيسي (مع شكل متطور وقابل للتحريك)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 400) -- زيادة الارتفاع لتحسين الترتيب
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- إضافة تأثير إضاءة متدرجة
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 69, 19)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(165, 42, 42)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 69, 19))
}
uiGradient.Rotation = 45
uiGradient.Parent = mainFrame

-- حواف مستديرة
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 20)
uiCorner.Parent = mainFrame

-- زر إغلاق في الزاوية اليمنى العلوية
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "❌"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

-- زر إعادة فتح (مخفي في البداية)
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 120, 0, 50)
reopenButton.Position = UDim2.new(0.9, -120, 0.5, -25)
reopenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
reopenButton.Text = "Reopen Menu 🔙"
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.Font = Enum.Font.GothamBold
reopenButton.Visible = false
reopenButton.Parent = screenGui
local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(0, 10)
reopenCorner.Parent = reopenButton

-- عنوان Egg Randomizer
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 60)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Egg Randomizer 🌱"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 24
titleLabel.Parent = mainFrame

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, -40, 0, 20)
madeByLabel.Position = UDim2.new(0, 0, 0.85, 0)
madeByLabel.BackgroundTransparency = 1
madeByLabel.Text = "Made by - munkizzz ✨"
madeByLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
madeByLabel.Font = Enum.Font.Gotham
madeByLabel.TextSize = 14
madeByLabel.Parent = mainFrame

-- زر Randomize Eggs (أعلى الأزرار)
local randomizeButton = Instance.new("TextButton")
randomizeButton.Size = UDim2.new(0.9, 0, 0, 50)
randomizeButton.Position = UDim2.new(0.05, 0, 0.2, 0)
randomizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
randomizeButton.Text = "Randomize Eggs 🎲"
randomizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizeButton.Font = Enum.Font.GothamBold
randomizeButton.Parent = mainFrame
local buttonGradient1 = Instance.new("UIGradient")
buttonGradient1.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
}
buttonGradient1.Parent = randomizeButton
local buttonCorner1 = Instance.new("UICorner")
buttonCorner1.CornerRadius = UDim.new(0, 10)
buttonCorner1.Parent = randomizeButton

-- خيار ESP (في الأعلى)
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0.9, 0, 0, 50)
espToggle.Position = UDim2.new(0.05, 0, 0.32, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espToggle.Text = "ESP: OFF 👁️"
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.GothamBold
espToggle.Parent = mainFrame
local buttonGradient2 = Instance.new("UIGradient")
buttonGradient2.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 70, 70))
}
buttonGradient2.Parent = espToggle
local buttonCorner2 = Instance.new("UICorner")
buttonCorner2.CornerRadius = UDim.new(0, 10)
buttonCorner2.Parent = espToggle

-- خيار Auto Randomize (في الأسفل)
local autoToggle = Instance.new("TextButton")
autoToggle.Size = UDim2.new(0.9, 0, 0, 50)
autoToggle.Position = UDim2.new(0.05, 0, 0.44, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
autoToggle.Text = "Auto Randomize: OFF 🔄"
autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoToggle.Font = Enum.Font.GothamBold
autoToggle.Parent = mainFrame
local buttonGradient3 = Instance.new("UIGradient")
buttonGradient3.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 128, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 0))
}
buttonGradient3.Parent = autoToggle
local buttonCorner3 = Instance.new("UICorner")
buttonCorner3.CornerRadius = UDim.new(0, 10)
buttonCorner3.Parent = autoToggle

-- منطقة عرض اسم الحيوان
local petDisplay = Instance.new("TextLabel")
petDisplay.Size = UDim2.new(0.9, 0, 0, 50)
petDisplay.Position = UDim2.new(0.05, 0, 0.6, 0)
petDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
petDisplay.Text = "New Pet: Unknown 🐾"
petDisplay.TextColor3 = Color3.fromRGB(255, 255, 0)
petDisplay.Font = Enum.Font.Gotham
petDisplay.TextSize = 18
petDisplay.Parent = mainFrame
local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 10)
displayCorner.Parent = petDisplay

-- شريط تقدم لـ Auto Randomize
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0.9, 0, 0, 10)
progressBar.Position = UDim2.new(0.05, 0, 0.72, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressBar.Parent = mainFrame
local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 5)
progressCorner.Parent = progressBar

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
progressFill.Parent = progressBar
local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 5)
fillCorner.Parent = progressFill

-- قوائم الحيوانات حسب نوع البيض بناءً على المصادر (مرتبة من الأقل إلى الأعلى ندرة)
local eggTypes = {
    ["common"] = {"Chicken 🐔", "Duck 🦆", "Turkey 🦃"},
    ["moonlight"] = {"Raccoon 🦝"},
    ["oasis"] = {"Meerkat 🦔", "Sand Snake 🐍", "Axolotl 🦎", "Ruby Parrot 🦜", "Fennec Fox 🦊"},
    ["primitive"] = {"Dilophosaurus 🦖", "Iguanodon 🦕", "Pachycephalosaurus 🦏", "Parasaurolophus 🦒"}
}

-- وظيفة اكتشاف البيض وتحديد نوعه
local function detectEggs()
    local potentialEggs = {}
    for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("egg") then
            local eggType = "common"
            if obj.Name:lower():find("moonlight") then eggType = "moonlight"
            elseif obj.Name:lower():find("oasis") then eggType = "oasis"
            elseif obj.Name:lower():find("primitive") then eggType = "primitive" end
            table.insert(potentialEggs, {model = obj, type = eggType})
        end
    end
    return potentialEggs
end

-- وظيفة تغيير الحيوانات الأليفة داخل البيض
local function randomizeEggs()
    local eggs = detectEggs()
    if #eggs == 0 then
        petDisplay.Text = "No Eggs Found! 🥚"
        return
    end
    for _, eggData in pairs(eggs) do
        local egg = eggData.model
        local eggType = eggData.type
        if egg:IsA("Model") then
            local petInside = egg:FindFirstChild("Pet") or egg:FindFirstChildOfClass("Model")
            if petInside then
                local newPetName = eggTypes[eggType][math.random(1, #eggTypes[eggType])]
                petInside:Destroy()
                local newPet = game.Workspace.Pets:FindFirstChildOfClass("Model")
                if newPet then
                    newPet:Clone().Parent = egg
                    local randomPosition = Vector3.new(math.random(-50, 50), egg.Position.Y, math.random(-50, 50))
                    pcall(function() egg:MoveTo(randomPosition) end)
                    petDisplay.Text = "New Pet: " .. newPetName
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
    for _, eggData in pairs(eggs) do
        local egg = eggData.model
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
            for i = 0, 1, 0.1 do
                progressFill.Size = UDim2.new(i, 0, 1, 0)
                wait(0.5)
            end
            progressFill.Size = UDim2.new(0, 0, 1, 0)
            wait(1)
        end
    end)
end

-- ربط الأحداث
randomizeButton.MouseButton1Click:Connect(randomizeEggs)
espToggle.MouseButton1Click:Connect(toggleESP)
autoToggle.MouseButton1Click:Connect(toggleAutoRandomize)
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    reopenButton.Visible = true
end)
reopenButton.MouseButton1Click:Connect(function()
    reopenButton.Visible = false
    mainFrame.Visible = true
end)
