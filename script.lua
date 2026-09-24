-- Steal An Egg - Ultimate Multi-Egg Hub By AZC
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

if _G.UltimateEggRunning then
    warn("السكربت يعمل بالفعل!")
    return
end
_G.UltimateEggRunning = true

-- نظام منع الخمول والطرد (Anti-AFK) لضمان عدم خروجك كل 20 دقيقة
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- إنشاء واجهة المستخدم الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZC_Ultimate_EggGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- أيقونة مصغرة لفتح/إغلاق الواجهة
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
MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 420)
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
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "AZC Hub | Multi-Egg Selector Pro"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.TextSize = 14

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- زر لتحديث قائمة البيض المتاح في اللعبة
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = MainFrame
RefreshBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RefreshBtn.Position = UDim2.new(0.05, 0, 0.11, 0)
RefreshBtn.Size = UDim2.new(0.9, 0, 0, 30)
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Text = "🔄 تحديث قائمة البيض والعدد"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.TextSize = 12

local RefCorner = Instance.new("UICorner")
RefCorner.CornerRadius = UDim.new(0, 6)
RefCorner.Parent = RefreshBtn

-- صندوق تمرير لقائمة خيارات البيض (مربعات خضراء)
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.20, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0, 160)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 6

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollingFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- زر تفعيل/إيقاف التفرم العام
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Auto Farm: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

-- نص الحالة المباشر
local StatusTxt = Instance.new("TextLabel")
StatusTxt.Parent = MainFrame
StatusTxt.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
StatusTxt.Position = UDim2.new(0.05, 0, 0.75, 0)
StatusTxt.Size = UDim2.new(0.9, 0, 0, 85)
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.Text = "الحالة: حدد البيض المطلوب من القائمة بالأعلى واضغط تشغيل.\n(Anti-AFK مفعل لمنع الطرد تلقائياً)"
StatusTxt.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusTxt.TextSize, StatusTxt.TextWrapped = 11, true

-- جدول لتخزين البيض المحدد من قبل المستخدم
local SelectedEggs = {}
local activeFarm = false

ToggleBtn.MouseButton1Click:Connect(function()
    activeFarm = not activeFarm
    if activeFarm then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        ToggleBtn.Text = "Auto Farm: ON (Anti-Kick Active)"
        StatusTxt.Text = "الحالة: يتم جمع البيض المحدد تلقائياً..."
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleBtn.Text = "Auto Farm: OFF"
        StatusTxt.Text = "الحالة: متوقف."
    end
end)

-- وظيفة تحديث قائمة البيض المتاح وعدده في اللعبة
local function UpdateEggList()
    -- حذف القائمة القديمة
    for _, v in ipairs(ScrollingFrame:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
    
    local eggCounts = {}
    -- عد وتجميع أنواع البيض الموجودة بالعالم حالياً
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("بيضة")) then
            eggCounts[obj.Name] = (eggCounts[obj.Name] or 0) + 1
        end
    end
    
    -- إنشاء مربعات خضراء تفاعلية لكل نوع بيض مع عدده
    for eggName, count in pairs(eggCounts) do
        local btn = Instance.new("TextButton")
        btn.Parent = ScrollingFrame
        btn.BackgroundColor3 = SelectedEggs[eggName] and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(60, 60, 60)
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Font = Enum.Font.GothamBold
        btn.Text = "🥚 " .. eggName .. " (العدد: " .. count .. ")"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 6)
        c.Parent = btn
        
        -- نظام التحديد المتعدد عند الضغط على المربع
        btn.MouseButton1Click:Connect(function()
            if SelectedEggs[eggName] then
                SelectedEggs[eggName] = nil
                btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            else
                SelectedEggs[eggName] = true
                btn.BackgroundColor3 = Color3.fromRGB(40, 180, 40) -- يتحول للأخضر عند التحديد
            end
        end)
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    UpdateEggList()
end)

-- التشغيل التلقائي لفحص وجمع البيض المحدد
task.spawn(function()
    while true do
        task.wait(0.3)
        if activeFarm then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local targeted = false
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not activeFarm then break end
                    if obj:IsA("Model") and SelectedEggs[obj.Name] then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            targeted = true
                            StatusTxt.Text = "جاري جمع: " .. obj.Name
                            
                            -- الانتقال للبيضة وسحبها فعلياً
                            hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                            task.wait(0.2)
                            firetouchinterest(hrp, part, 0)
                            task.wait(0.1)
                            firetouchinterest(hrp, part, 1)
                            
                            for _, prompt in ipairs(obj:GetDescendants()) do
                                if prompt:IsA("ProximityPrompt") then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end
                
                if not targeted then
                    StatusTxt.Text = "بانتظار ظهور البيض المحدد..."
                end
            end)
        end
    end
end)

-- تحديث أولي للقائمة عند التشغيل
pcall(UpdateEggList)
