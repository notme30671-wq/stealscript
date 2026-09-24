-- Steal An Egg - Direct Ultimate Pro Hub By AZC-- Steal An Egg - Ultra Simple & Safe Fast Hub
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- حماية منع الخمول والطرد (Anti-AFK)
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- إزالة أي واجهة قديمة
if LocalPlayer.PlayerGui:FindFirstChild("AZC_Simple_Egg") then
    LocalPlayer.PlayerGui.AZC_Simple_Egg:Destroy()
end

-- إنشاء واجهة بسيطة جداً وغير قابلة للاختفاء
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZC_Simple_Egg"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 240, 0, 150)
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "AZC Fast Egg Farm"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 13

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleBtn.Position = UDim2.new(0.07, 0, 0.32, 0)
ToggleBtn.Size = UDim2.new(0.86, 0, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Auto Farm: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 13

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

local Status = Instance.new("TextLabel")
Status.Parent = Frame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0.07, 0, 0.7, 0)
Status.Size = UDim2.new(0.86, 0, 0, 30)
Status.Font = Enum.Font.Gotham
Status.Text = "الحالة: جاهز للتشغيل"
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.TextSize = 11

local active = false

ToggleBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        ToggleBtn.Text = "Auto Farm: ON"
        Status.Text = "الحالة: يجمع كل البيض الآن..."
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleBtn.Text = "Auto Farm: OFF"
        Status.Text = "الحالة: متوقف."
    end
end)

-- محرك جمع البيض السريع المباشر
task.spawn(function()
    while true do
        task.wait(0.2)
        if active then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not active then break end
                    -- فحص أي مجسم يحتوي على كلمة egg أو بيضة
                    if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("بيضة")) then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            -- الانتقال السريع لمكان البيضة
                            hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                            task.wait(0.1)
                            
                            -- تفعيل اللمس وسحب البرومبت
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
            end)
        end
    end
end)
