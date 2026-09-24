-- Steal An Egg - Ultimate Pro Hack & Anti-Ban Hub By AZC
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

if _G.ProStealEggRunning then
    warn("السكربت يعمل بالفعل!")
    return
end
_G.ProStealEggRunning = true

-- نظام حماية خمول ومنع الطرد (Anti-AFK & Anti-Kick)
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- إنشاء الواجهة الاحترافية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZC_Pro_EggGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- أيقونة فتح وإغلاق القائمة
local ToggleUIIcon = Instance.new("TextButton")
ToggleUIIcon.Name = "ToggleUIIcon"
ToggleUIIcon.Parent = ScreenGui
ToggleUIIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 440)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local uiVisible = true
ToggleUIIcon.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = uiVisible
end)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "AZC Pro Hub | Auto Grab & Speed"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 14

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- زر تحديث أسماء البيض المتاحة
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = MainFrame
RefreshBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RefreshBtn.Position = UDim2.new(0.05, 0, 0.11, 0)
RefreshBtn.Size = UDim2.new(0.9, 0, 0, 32)
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Text = "🔄 جلب وفحص جميع بيض اللعبة"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.TextSize = 12

local RefCorner = Instance.new("UICorner")
RefCorner.CornerRadius = UDim.new(0, 6)
RefCorner.Parent = RefreshBtn

-- صندوق تمرير لقائمة البيض
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.20, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0, 170)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 6

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollingFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- زر التشغيل والإيقاف
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Auto Farm: OFF (Safe Mode)"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

-- نص الحالة
local StatusTxt = Instance.new("TextLabel")
StatusTxt.Parent = MainFrame
StatusTxt.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
StatusTxt.Position = UDim2.new(0.05, 0, 0.74, 0)
StatusTxt.Size = UDim2.new(0.9, 0, 0, 95)
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.Text = "الحالة: اضغط زر جلب البيض بالأعلى، حدد ما تريد، ثم شغل السكربت.\n(السرعة الفائقة والحماية مفعلة)"
StatusTxt.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusTxt.TextSize, StatusTxt.TextWrapped = 11, true

local SelectedEggs = {}
local activeFarm = false

ToggleBtn.MouseButton1Click:Connect(function()
    activeFarm = not activeFarm
    if activeFarm then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        ToggleBtn.Text = "Auto Farm: ON (Hyper Speed)"
        StatusTxt.Text = "الحالة: يتم رصد وجلب البيض المحدد بسرعة خارقة..."
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleBtn.Text = "Auto Farm: OFF"
        StatusTxt.Text = "الحالة: متوقف."
    end
end)

-- وظيفة جلب أسماء البيض وعمل مربعات جانبية للاختيار المتعدد
local function UpdateEggList()
    for _, v in ipairs(ScrollingFrame:GetChildren()) do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end
    
    local eggData = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("بيضة")) then
            eggData[obj.Name] = (eggData[obj.Name] or 0) + 1
        end
    end
    
    for eggName, count in pairs(eggData) do
        -- إطار يضم اسم البيضة والعدد ومربع الاختيار بجانبها
        local itemFrame = Instance.new("Frame")
        itemFrame.Parent = ScrollingFrame
        itemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        itemFrame.Size = UDim2.new(1, -10, 0, 36)
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = itemFrame
        
        -- زر المربع الصغير الجانبي للتحديد
        local checkBox = Instance.new("TextButton")
        checkBox.Parent = itemFrame
        checkBox.BackgroundColor3 = SelectedEggs[eggName] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(70, 70, 70)
        checkBox.Position = UDim2.new(0.02, 0, 0.15, 0)
        checkBox.Size = UDim2.new(0, 25, 0, 25)
        checkBox.Font = Enum.Font.GothamBold
        checkBox.Text = SelectedEggs[eggName] and "✓" else ""
        checkBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        checkBox.TextSize = 14
        
        local checkCorner = Instance.new("UICorner")
        checkCorner.CornerRadius = UDim.new(0, 4)
        checkCorner.Parent = checkBox
        
        -- اسم البيضة والعدد
        local label = Instance.new("TextLabel")
        label.Parent = itemFrame
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0.15, 0, 0, 0)
        label.Size = UDim2.new(0.8, 0, 1, 0)
        label.Font = Enum.Font.GothamBold
        label.Text = eggName .. " (العدد: " .. count .. ")"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize, label.TextXAlignment = 12, Enum.TextXAlignment.Left
        
        -- تفعيل الاختيار عند الضغط على المربع أو السطر
        local function toggleSelect()
            if SelectedEggs[eggName] then
                SelectedEggs[eggName] = nil
                checkBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                checkBox.Text = ""
            else
                SelectedEggs[eggName] = true
                checkBox.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                checkBox.Text = "✓"
            end
        end
        
        checkBox.MouseButton1Click:Connect(toggleSelect)
        itemFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                toggleSelect()
            end
        end)
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    UpdateEggList()
end)

-- محرك السرعة الفائقة والنقل السريع للبيض بأمان
task.spawn(function()
    while true do
        task.wait(0.2)
        if activeFarm then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local found = false
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not activeFarm then break end
                    if obj:IsA("Model") and SelectedEggs[obj.Name] then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            found = true
                            StatusTxt.Text = "جاري القفز السريع وجلب: " .. obj.Name
                            
                            -- سرعة فائقة جداً بالنقل الفوري فوق البيضة مهما كانت بعيدة أو كبيرة
                            hrp.CFrame = part.CFrame + Vector3.new(0, 2.5, 0)
                            task.wait(0.1)
                            
                            -- تفعيل اللمس والسرقة بقوة
                            firetouchinterest(hrp, part, 0)
                            task.wait(0.05)
                            firetouchinterest(hrp, part, 1)
                            
                            for _, prompt in ipairs(obj:GetDescendants()) do
                                if prompt:IsA("ProximityPrompt") then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end
                
                if not found then
                    StatusTxt.Text = "بانتظار ظهور البيض المحدد..."
                end
            end)
        end
    end
end)

pcall(UpdateEggList)
