-- Steal An Egg - Ultimate Auto Farm Hub
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- حماية من التكرار إذا تم تشغيل السكربت مرتين
if _G.StealAnEggRunning then
    warn("السكربت يعمل بالفعل!")
    return
end
_G.StealAnEggRunning = true

-- إنشاء واجهة المستخدم (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZC_Style_EggGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "eggs Hub | Steal An Egg"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.TextSize = 16

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- خانة كتابة نوع البيض المراد سرقته
local EggBox = Instance.new("TextBox")
EggBox.Parent = MainFrame
EggBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EggBox.Position = UDim2.new(0.08, 0, 0.25, 0)
EggBox.Size = UDim2.new(0.84, 0, 0, 40)
EggBox.Font = Enum.Font.Gotham
EggBox.PlaceholderText = "اكتب اسم البيضة هنا (أو اتركه فارغاً للكل)"
EggBox.Text = ""
EggBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EggBox.TextSize = 13

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = EggBox

-- زر التفعيل والتعطيل
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleBtn.Position = UDim2.new(0.08, 0, 0.47, 0)
ToggleBtn.Size = UDim2.new(0.84, 0, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Auto Farm: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

-- نص الحالة لتوضيح ما يفعله السكربت الآن
local StatusTxt = Instance.new("TextLabel")
StatusTxt.Parent = MainFrame
StatusTxt.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
StatusTxt.Position = UDim2.new(0.08, 0, 0.72, 0)
StatusTxt.Size = UDim2.new(0.84, 0, 0, 50)
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.Text = "الحالة: جاهز، حدد البيضة واضغط تشغيل"
StatusTxt.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusTxt.TextSize, StatusTxt.TextWrapped = 12, true

-- البرمجة والمنطق التلقائي
local activeFarm = false

ToggleBtn.MouseButton1Click:Connect(function()
    activeFarm = not activeFarm
    if activeFarm then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        ToggleBtn.Text = "Auto Farm: ON"
        StatusTxt.Text = "الحالة: جاري البحث وجمع البيض تلقائياً..."
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleBtn.Text = "Auto Farm: OFF"
        StatusTxt.Text = "الحالة: تم إيقاف التفرم."
        _G.StealAnEggRunning = false
    end
end)

-- نظام الانتقال والتفرم التلقائي للبيضة المحددة
task.spawn(function()
    while _G.StealAnEggRunning do
        task.wait(0.4)
        if activeFarm then
            pcall(function()
                local targetName = EggBox.Text:lower()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                -- البحث في العالم عن البيض الخاص بالحدث
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not activeFarm then break end
                    if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("بيضة")) then
                        if targetName == "" or obj.Name:lower():find(targetName) then
                            local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                            if part then
                                StatusTxt.Text = "جاري سرقة: " .. obj.Name
                                -- الانتقال المباشر للبيضة كأنه يلعب عنك
                                hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
