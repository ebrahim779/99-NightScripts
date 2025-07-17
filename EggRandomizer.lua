-- سكربت لتغيير الحيوان الأليف في Grow a Garden
local eggs = {"FPS Egg", "Basic Egg", "Night Egg", "Primal Egg"} -- قائمة البيض (تأكد من الأسماء)
local desiredPet = "DragonPet" -- الحيوان المطلوب (غيره حسب اللعبة)
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- دالة لفتح بيضة مع تحديد الحيوان
local function openEggWithPet()
    local selectedEgg = "FPS Egg" -- التركيز على FPS Egg
    print(player.Name .. " يحاول فتح: " .. selectedEgg .. " للحصول على: " .. desiredPet)

    -- محاولة فتح البيضة مع تحديد الحيوان
    local hatchEggEvent = replicatedStorage:FindFirstChild("HatchEggEvent")
    if hatchEggEvent then
        hatchEggEvent:FireServer(selectedEgg, desiredPet)
    else
        warn("خطأ: لم يتم العثور على 'HatchEggEvent'. تأكد من اسم الإيفنت.")
    end
end

-- تشغيل الدالة كل 5 ثواني
while true do
    wait(5)
    openEggWithPet()
end