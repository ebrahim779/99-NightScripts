-- سكربت تلقائي محسّن للتعرف على البيض وتغيير الحيوان في Grow a Garden
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local serverStorage = game:GetService("ServerStorage")

-- دالة للحصول على قائمة البيض تلقائيًا من أماكن متعددة
local function getEggs()
    local eggList = {}
    -- فحص ReplicatedStorage
    for _, item in pairs(replicatedStorage:GetChildren()) do
        if item:IsA("StringValue") or item:IsA("ObjectValue") or item.Name:lower():find("egg") then
            table.insert(eggList, item.Name)
        end
    end
    -- فحص Workspace
    for _, item in pairs(game.Workspace:GetChildren()) do
        if item:IsA("StringValue") or item:IsA("ObjectValue") or item.Name:lower():find("egg") then
            table.insert(eggList, item.Name)
        end
    end
    -- فحص ServerStorage (للسيرفرات الخاصة)
    for _, item in pairs(serverStorage:GetChildren()) do
        if item:IsA("StringValue") or item:IsA("ObjectValue") or item.Name:lower():find("egg") then
            table.insert(eggList, item.Name)
        end
    end
    -- فحص Inventory الخاص باللاعب (لو موجود)
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        for _, screenGui in pairs(playerGui:GetChildren()) do
            if screenGui:IsA("ScreenGui") then
                for _, item in pairs(screenGui:GetDescendants()) do
                    if item:IsA("StringValue") or item:IsA("ObjectValue") or item.Name:lower():find("egg") then
                        table.insert(eggList, item.Name)
                    end
                end
            end
        end
    end
    return eggList
end

local desiredPet = "DragonPet" -- الحيوان المطلوب (غيره حسب اللعبة)
local hatchEggEventName = "HatchEggEvent" -- اسم الـ Remote Event (غيره إذا كان غلط)

-- دالة لفتح بيضة مع تحديد الحيوان
local function openEggWithPet()
    local eggs = getEggs()
    if #eggs == 0 then
        warn("لم يتم العثور على أي بيض في ReplicatedStorage، Workspace، ServerStorage، أو PlayerGui.")
        return
    end
    local selectedEgg = eggs[math.random(1, #eggs)] -- اختيار بيضة عشوائية
    print(player.Name .. " يحاول فتح: " .. selectedEgg .. " للحصول على: " .. desiredPet)

    -- محاولة فتح البيضة مع تحديد الحيوان
    local hatchEggEvent = replicatedStorage:FindFirstChild(hatchEggEventName)
    if hatchEggEvent then
        hatchEggEvent:FireServer(selectedEgg, desiredPet)
    else
        warn("خطأ: لم يتم العثور على '" .. hatchEggEventName .. "' في ReplicatedStorage. تأكد من اسم الإيفنت.")
    end
end

-- تشغيل الدالة كل 5 ثواني
while true do
    wait(5)
    openEggWithPet()
end
