-- Steal An Egg - Advanced Hub By AZC
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

if _G.AdvancedEggRunning then
    warn("السكربت يعمل بالفعل!")
    return
end
_G.AdvancedEggRunning = true

-- إنشاء واجهة المستخدم الاحترافية مع زر إخفاء وإظهار
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZC_Advanced_EggGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- زر فتح/إغلاق القائمة الصغير ع الشاشة
local ToggleUIIcon = Instance.new("TextButton")
ToggleUIIcon.Name = "ToggleUIIcon"
ToggleUIIcon.Parent = ScreenGui
ToggleUIIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleUIIcon.Position = UDim2.new(0.02, 0, 0.1, 0)
ToggleUIIcon.Size = UDim2.new(0, 45, 0, 45)
ToggleUIIcon.Font = Enum.Font.GothamBold
ToggleUIIcon.Text = "🥚"
ToggleUIIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleUIIcon.TextSize = 20

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 10)
IconCorner.Parent = ToggleUIIcon

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- إخفاء وإظهار الواجهة عند الضغط على الأيقونة
local uiVisible = true
ToggleUIIcon.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = uiVisible
end)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "AZC Hub | Steal An Egg Pro"
Title.TextColor3 = Color3.fromRGB(255, 170, 0)
Title.TextSize = 15

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- خانة كتابة نوع البيضة أو جزء من اسمها
local EggBox = Instance.new("TextBox")
EggBox.Parent = MainFrame
EggBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EggBox.Position = UDim2.new(0.08, 0, 0.22, 0)
EggBox.Size = UDim2.new(0.84, 0, 0, 40)
EggBox.Font = Enum.Font.Gotham
EggBox.PlaceholderText = "اكتب اسم البيضة (أو اتركه فارغاً للكل)"
EggBox.Text = ""
EggBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EggBox.TextSize = 12

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = EggBox

-- زر تفعيل/إيقاف التفرم التلقائي
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleBtn.Position = UDim2.new(0.08, 0, 0.42, 0)
ToggleBtn.Size = UDim2.new(0.84, 0, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Auto Farm & Grab: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize, ToggleBtn.TextWrapped = 13, true

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

-- نص حالة التتبع الفوري
local StatusTxt = Instance.new("TextLabel")
StatusTxt.Parent = MainFrame
StatusTxt.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
StatusTxt.Position = UDim2.new(0.08, 0, 0.65, 0)
StatusTxt.Size = UDim2.new(0.84, 0, 0, 80)
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.Text = "الحالة: جاهز بانتظار تفعيل التفرم..."
StatusTxt.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusTxt.TextSize, StatusTxt.TextWrapped = 12, true

local activeFarm = false

ToggleBtn.MouseButton1Click:Connect(function()
    activeFarm = not activeFarm
    if activeFarm then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        ToggleBtn.Text = "Auto Farm & Grab: ON"
        StatusTxt.Text = "الحالة: يتم البحث عن البيض والتقاطه فور رسبنته..."
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleBtn.Text = "Auto Farm & Grab: OFF"
        StatusTxt.Text = "الحالة: تم الإيقاف."
        _G.AdvancedEggRunning = false
    end
end)

-- محرك التفرم المطور (انتقال فوري + محاكاة اللمس والسرقة الحقيقية)
task.spawn(function()
    while true do
        task.wait(0.3)
        if activeFarm then
            pcall(function()
                local targetName = EggBox.Text:lower()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local foundEgg = false
                -- فحص دقيق لجميع العناصر في العالم للبحث عن البيض وقت ظهورها
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not activeFarm then break end
                    if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("بيضة")) then
                        if targetName == "" or obj.Name:lower():find(targetName) then
                            local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                            if part then
                                foundEgg = true
                                StatusTxt.Text = "جاري جلب ورسوب البيضة: " .. obj.Name
                                
                                -- انتقال فوري لمكان البيضة
                                hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                task.wait(0.2)
                                
                                -- محاكاة التفاعل وسحب البيضة (Touch / Proximity)
                                firetouchinterest(hrp, part, 0)
                                task.wait(0.1)
                                firetouchinterest(hrp, part, 1)
                                
                                -- تشغيل أي برومبت تفاعلي موجود بالبيضة
                                for _, prompt in ipairs(obj:GetDescendants()) do
                                    if prompt:IsA("ProximityPrompt") then
                                        fireproximityprompt(prompt)
                                    end
                                end
                            end
                        end
                    end
                end
                
                if not foundEgg then
                    StatusTxt.Text = "انتظار رسبون البيضة المطلوبة..."
                end
            end)
        end
    end
end)
