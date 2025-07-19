-- إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- إطار رئيسي (مع شكل متطور وقابل للتحريك)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 350)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true -- لتفعيل التحريك
mainFrame.Draggable = true -- جعل الإطار قابل للسحب

-- إضافة تأثير إضاءة متدرجة مع حركة
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
reopenButton.Text = "Reopen Menu 🔙🌿"
reopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reopenButton.Font = Enum.Font.GothamBold
reopenButton.Visible = false
reopenButton.Parent = screenGui
local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(0, 10)
reopenCorner.Parent = reopenButton

-- عنوان Egg Randomizer
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 60) -- تقليص العرض لتجنب تغطية زر الإغلاق
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Egg Randomizer 🌟🍳🎉"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 24
titleLabel.Parent = mainFrame

-- أيقونات القدمين والنجوم
local pawIcon1 = Instance.new("ImageLabel")
pawIcon1.Size = UDim2.new(0, 30, 0, 30)
pawIcon1.Position = UDim2.new(0.05, 0, 0.2, 0)
pawIcon1.Image = "rbxassetid://6031090998" -- أيقونة قدم
pawIcon1.BackgroundTransparency = 1
pawIcon1.Parent = titleLabel

local pawIcon2 = pawIcon1:Clone()
pawIcon2.Position = UDim2.new(0.1, 0, 0.2, 0)
pawIcon2.Parent = titleLabel

local starIcon1 = Instance.new("ImageLabel")
starIcon1.Size = UDim2.new(0, 30, 0, 30)
starIcon1.Position = UDim2.new(0.8, 0, 0.2, 0) -- تعديل الموضع لتجنب الصراع
starIcon1.Image = "rbxassetid://6034468592" -- أيقونة نجمة
starIcon1.BackgroundTransparency = 1
starIcon1.Parent = titleLabel

local starIcon2 = starIcon1:Clone()
starIcon2.Position = UDim2.new(0.85, 0, 0.2, 0)
starIcon2.Parent = titleLabel

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, -40, 0, 20)
madeByLabel.Position = UDim2.new(0, 0, 0.7, 0)
madeByLabel.BackgroundTransparency = 1
madeByLabel.Text = "Made by - munkizzz ✨🔥"
madeByLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
madeByLabel.Font = Enum.Font.Gotham
madeByLabel.TextSize = 14
madeByLabel.Parent = titleLabel

-- زر Randomize Eggs
local randomizeButton = Instance.new("TextButton")
randomizeButton.Size = UDim2.new(1, -10, 0, 50)
randomizeButton.Position = UDim2.new(0.05, 0, 0.25, 0)
randomizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
randomizeButton.Text = "Randomize Eggs 🎲💥"
randomizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizeButton.Font = Enum.Font.GothamBold
randomizeButton.Parent = mainFrame
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = randomizeButton

local diceIcon = Instance.new("ImageLabel")
diceIcon.Size = UDim2.new(0, 30, 0, 30)
diceIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
diceIcon.Image = "rbxassetid://6031274457" -- أيقونة نرد
diceIcon.BackgroundTransparency = 1
diceIcon.Parent = randomizeButton

-- خيار ESP
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(1, -10, 0, 50)
espToggle.Position = UDim2.new(0.05, 0, 0.4, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espToggle.Text = "ESP: OFF 👁️🌌"
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.GothamBold
espToggle.Parent = mainFrame
local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 10)
espCorner.Parent = espToggle

local eyeIcon = Instance.new("ImageLabel")
eyeIcon.Size = UDim2.new(0, 30, 0, 30)
eyeIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
eyeIcon.Image = "rbxassetid://6031265973" -- أيقونة عين
eyeIcon.BackgroundTransparency = 1
eyeIcon.Parent = espToggle

-- خيار Auto Randomize
local autoToggle = Instance.new("TextButton")
autoToggle.Size = UDim2.new(1, -10, 0, 50)
autoToggle.Position = UDim2.new(0.05, 0, 0.55, 0)
autoToggle.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
autoToggle.Text = "Auto Randomize: OFF 🔄⚡"
autoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoToggle.Font = Enum.Font.GothamBold
autoToggle.Parent = mainFrame
local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 10)
autoCorner.Parent = autoToggle

local refreshIcon = Instance.new("ImageLabel")
refreshIcon.Size = UDim2.new(0, 30, 0, 30)
refreshIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
refreshIcon.Image = "rbxassetid://6031282035" -- أيقونة دوران
refreshIcon.BackgroundTransparency = 1
refreshIcon.Parent = autoToggle

-- منطقة عرض اسم الحيوان
local petDisplay = Instance.new("TextLabel")
petDisplay.Size = UDim2.new(0.9, 0, 0, 50)
petDisplay.Position = UDim2.new(0.05, 0, 0.75, -50)
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
progressBar.Position = UDim2.new(0.05, 0, 0.85, -10)
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

-- قوائم الحيوانات حسب نوع البيض بناءً على المصادر
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
            local eggType = "common" -- افتراضي
            if obj.Name:lower():find("moonlight") then eggType = "moonlight"
            elseif obj.Name:lower():find("oasis") then eggType = "oasis"
            elseif obj.Name:lower():find("primitive") then eggType = "primitive" end
            table.insert(potentialEggs, {model = obj, type = eggType})
        end
    end
    return potentialEggs
end

-- وظيفة تغيير الحيوانات الأليفة داخل البيض مع تأثير مذهل
local function randomizeEggs()
    local eggs = detectEggs()
    if #eggs == 0 then
        petDisplay.Text = "No Eggs Found! 🥚💔"
        return
    end
    for _, eggData in pairs(eggs) do
        local egg = eggData.model
        local eggType = eggData.type
        if egg:IsA("Model") then
            local petInside = egg:FindFirstChild("Pet") or egg:FindFirstChildOfClass("Model")
            if petInside then
                -- تأثير بصري مذهل: انفجار وجزيئات
                local explosion = Instance.new("Part")
                explosion.Shape = Enum.PartType.Ball
                explosion.Size = Vector3.new(10, 10, 10)
                explosion.Position = egg.Position
                explosion.BrickColor = BrickColor.Random()
                explosion.Material = Enum.Material.Neon
                explosion.Parent = game.Workspace
                game.Debris:AddItem(explosion, 2)

                local particle = Instance.new("ParticleEmitter")
                particle.Rate = 100
                particle.Speed = NumberRange.new(5, 20)
                particle.Lifetime = NumberRange.new(1, 3)
                particle.Color = ColorSequence.new(BrickColor.Random().Color)
                particle.Parent = explosion
                game.Debris:AddItem(particle, 3)

                -- محاولة تشغيل صوت
                pcall(function()
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://1837829537" -- صوت انفجار
                    sound.Volume = 0.5
                    sound.Parent = egg
                    sound:Play()
                    game.Debris:AddItem(sound, 3)
                end)

                local newPetName = eggTypes[eggType][math.random(1, #eggTypes[eggType])]
                petInside:Destroy()
                local newPet = game.Workspace.Pets:FindFirstChildOfClass("Model")
                if newPet then
                    newPet:Clone().Parent = egg
                    local randomPosition = Vector3.new(math.random(-50, 50), egg.Position.Y, math.random(-50, 50))
                    pcall(function() egg:MoveTo(randomPosition) end)

                    petDisplay.Text = "New Pet: " .. newPetName .. " 🎉🔥"
                    tweenService:Create(petDisplay, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(255, 0, 0)}):Play()
                    wait(0.5)
                    tweenService:Create(petDisplay, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(0, 255, 0)}):Play()
                    wait(0.5)
                    tweenService:Create(petDisplay, TweenInfo.new(0.5), {TextColor3 = Color3.fromRGB(255, 255, 0)}):Play()
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
    espToggle.Text = "ESP: " .. (espState and "OFF" or "ON") .. " 👁️🌌"
end

-- وظيفة Auto Randomize
local autoRunning = false
local function toggleAutoRandomize()
    autoRunning = not autoRunning
    autoToggle.Text = "Auto Randomize: " .. (autoRunning and "ON" or "OFF") .. " 🔄⚡"
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
