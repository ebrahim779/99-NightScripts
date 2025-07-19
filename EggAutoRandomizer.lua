– تحميل مكتبة Kavo UI (Loading Kavo UI Library)
local Library = loadstring(game:HttpGet(“https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua”))()

– إنشاء النافذة الرئيسية (Creating Main Window)
local Window = Library.CreateLib(“Pet Randomizer ✨”, “BloodTheme”)

– إنشاء تبويب العشوائية (Creating Randomize Tab)
local Tab = Window:NewTab(“🎲 Randomize Pets”)

– إنشاء قسم الحيوانات الأليفة (Creating Pet Section)
local Section = Tab:NewSection(“Pet Controls”)

– متغيرات التحكم (Control Variables)
local espEnabled = false
local autoRandomizeEnabled = false
local autoRandomizeConnection = nil

– زر عشوائية الحيوانات الأليفة (Randomize Pets Button)
Section:NewButton(“🎲 Randomize Pets”, “Click to randomize your pets”, function()
print(“Pet randomization activated!”)
– هنا ضع كود عشوائية الحيوانات (Put your pet randomization code here)
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “Pet Randomizer”;
Text = “Pets randomized successfully!”;
Duration = 3;
})
end)

– تبديل ESP (ESP Toggle)
Section:NewToggle(“👁️ ESP”, “Enable/Disable ESP feature”, function(state)
espEnabled = state
if espEnabled then
print(“ESP: ON”)
– كود تشغيل ESP (ESP activation code)
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “ESP Status”;
Text = “ESP is now ON”;
Duration = 2;
})
else
print(“ESP: OFF”)
– كود إيقاف ESP (ESP deactivation code)
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “ESP Status”;
Text = “ESP is now OFF”;
Duration = 2;
})
end
end)

– تبديل العشوائية التلقائية (Auto Randomize Toggle)
Section:NewToggle(“🔄 Auto Randomize”, “Enable/Disable automatic pet randomization”, function(state)
autoRandomizeEnabled = state

```
if autoRandomizeEnabled then
    print("Auto Randomize: ON")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Randomize";
        Text = "Auto Randomize is now ON";
        Duration = 2;
    })
    
    -- بدء العشوائية التلقائية (Start auto randomization)
    autoRandomizeConnection = game:GetService("RunService").Heartbeat:Connect(function()
        wait(5) -- انتظار 5 ثوانٍ بين كل عشوائية (Wait 5 seconds between randomizations)
        if autoRandomizeEnabled then
            print("Auto randomizing pets...")
            -- هنا ضع كود العشوائية التلقائية (Put your auto randomization code here)
        end
    end)
    
else
    print("Auto Randomize: OFF")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Auto Randomize";
        Text = "Auto Randomize is now OFF";
        Duration = 2;
    })
    
    -- إيقاف العشوائية التلقائية (Stop auto randomization)
    if autoRandomizeConnection then
        autoRandomizeConnection:Disconnect()
        autoRandomizeConnection = nil
    end
end
```

end)

– قسم إضافي للإعدادات (Additional Settings Section)
local SettingsSection = Tab:NewSection(“Settings”)

– شريط منزلق لسرعة العشوائية التلقائية (Auto Randomize Speed Slider)
SettingsSection:NewSlider(“⏱️ Auto Speed”, “Set auto randomize speed (seconds)”, 10, 1, function(value)
print(“Auto randomize speed set to: “ .. value .. “ seconds”)
– يمكنك استخدام هذه القيمة لتعديل سرعة العشوائية التلقائية
– (You can use this value to modify auto randomization speed)
end)

– مربع نص للإعدادات المخصصة (Text Box for Custom Settings)
SettingsSection:NewTextBox(“🔧 Custom Command”, “Enter custom command”, function(text)
print(“Custom command entered: “ .. text)
– معالجة الأوامر المخصصة (Handle custom commands)
if text:lower() == “reset” then
– إعادة تعيين الإعدادات (Reset settings)
espEnabled = false
autoRandomizeEnabled = false
if autoRandomizeConnection then
autoRandomizeConnection:Disconnect()
autoRandomizeConnection = nil
end
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “Reset”;
Text = “All settings have been reset!”;
Duration = 3;
})
end
end)

– قسم المعلومات (Information Section)
local InfoSection = Tab:NewSection(“Information”)

– زر المعلومات (Info Button)
InfoSection:NewButton(“ℹ️ Script Info”, “View script information”, function()
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “Pet Randomizer”;
Text = “Made by - munkizzz ⭐”;
Duration = 5;
})
print(“Script created by munkizzz”)
end)

– زر إعادة تحميل الواجهة (Reload UI Button)
InfoSection:NewButton(“🔄 Reload UI”, “Reload the user interface”, function()
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “Reloading”;
Text = “Reloading UI…”;
Duration = 2;
})

```
wait(1)
-- إعادة تحميل السكريبت (Reload the script)
loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
```

end)

– رسالة الترحيب (Welcome Message)
game:GetService(“StarterGui”):SetCore(“SendNotification”, {
Title = “Pet Randomizer Loaded! ✨”;
Text = “Welcome! Script is ready to use.”;
Duration = 4;
})

print(“Pet Randomizer script loaded successfully!”)
print(“Features available:”)
print(”- 🎲 Randomize Pets”)
print(”- 👁️ ESP Toggle”)
print(”- 🔄 Auto Randomize”)
print(”- ⏱️ Speed Control”)
print(“Made by munkizzz ⭐”)
