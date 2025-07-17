-- سكربت تلقائي للتعرف على البيض وتغيير الحيوان في Grow a Garden
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- دالة للحصول على قائمة البيض تلقائيًا
local function getEggs()
    local eggList = {}
    -- فحص ReplicatedStorage للبيض
    for _, item in pairs(replicatedStorage:GetChildren()) do
        if item:IsA("StringValue") or item:IsA("ObjectValue") or item.Name:lower():find("egg") then
            table.insert(eggList, item.Name)
        end
    end
    -- فحص Workspace لو البيض موجودة هناك
    for _, item in pairs(game.Workspace:GetChildren()) do
        if item:IsA("StringValue") or item:IsA("ObjectValue") or item.Name:lower():find("egg") then
            table.insert(eggList, item.Name)
        end
    end
    return eggList
end

local desiredPet = "DragonPet" -- الحيوان المطلوب (غيره حسب اللعبة)

-- دالة لفتح بيضة مع تحديد الحيوان
local function openEggWithPet()
    local eggs = getEggs()
    if #eggs == 0 then
        warn("لم يتم العثور على أي بيض في ReplicatedStorage أو Workspace.")
        return
    end
    local selectedEgg = eggs[math.random(1, #eggs)] -- اختيار بيضة عشوائية
    print(player.Name .. " يحاول فتح: " .. selectedEgg .. " للحصول على: " .. desiredPet)

    -- محاولة فتح البيضة مع تحديد الحيوان
    local hatchEggEvent = replicatedStorage:FindFirstChild("HatchEggEvent")
    if hatchEggEvent then
        hatchEggEvent:FireServer(selectedEgg, desiredPet)
    else
        warn("خطأ: لم يتم العثور على 'HatchEggEvent' في ReplicatedStorage. تأكد من اسم الإيفنت.")
    end
end

-- تشغيل الدالة كل 5 ثواني
while true do
    wait(5)
    openEggWithPet()
end