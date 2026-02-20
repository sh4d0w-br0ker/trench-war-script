local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("Final_Straight_Gui") then CoreGui.Final_Straight_Gui:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Final_Straight_Gui"

-- Общий контейнер, который держит обе части вместе
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 72)
MainFrame.Position = UDim2.new(0.5, -110, 0.2, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.Active = true
MainFrame.Draggable = true

local Layout = Instance.new("UIListLayout", MainFrame)
Layout.Padding = UDim.new(0, 2) -- Склейка плашек

-- Функция сборки секции
local function MakeSection(name)
    local Sec = Instance.new("Frame", MainFrame)
    Sec.Size = UDim2.new(1, 0, 0, 35)
    Sec.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Sec.BorderSizePixel = 0
    Sec.ClipsDescendants = true
    Instance.new("UICorner", Sec)

    local Btn = Instance.new("TextButton", Sec)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Text = name .. "  <"
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.BackgroundTransparency = 1
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 16

    local Content = Instance.new("Frame", Sec)
    Content.Size = UDim2.new(1, 0, 0, 280)
    Content.Position = UDim2.new(0, 0, 0, 35)
    Content.BackgroundTransparency = 1
    Instance.new("UIListLayout", Content).HorizontalAlignment = Enum.HorizontalAlignment.Center

    local open = false
    Btn.MouseButton1Click:Connect(function()
        open = not open
        Sec.Size = open and UDim2.new(1, 0, 0, 315) or UDim2.new(1, 0, 0, 35)
        Btn.Text = name .. (open and "  v" or "  <")
        
        -- Считаем общую высоту для Draggable фрейма
        local h = 0
        for _, v in pairs(MainFrame:GetChildren()) do
            if v:IsA("Frame") then h = h + v.Size.Y.Offset + 2 end
        end
        MainFrame.Size = UDim2.new(0, 220, 0, h)
    end)
    return Content
end

local KillBox = MakeSection("Kill Gui")
local EspBox = MakeSection("Esp Gui")

-- Контент Kill
local Target = Instance.new("TextBox", KillBox)
Target.Size = UDim2.new(0.9, 0, 0, 30)
Target.PlaceholderText = "Username..."
Target.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Target.TextColor3 = Color3.new(1, 1, 1)

local KBtn = Instance.new("TextButton", KillBox)
KBtn.Size = UDim2.new(0.9, 0, 0, 35)
KBtn.Text = "Kill Player"
KBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KBtn.TextColor3 = Color3.new(1, 1, 1)

local ABtn = Instance.new("TextButton", KillBox)
ABtn.Size = UDim2.new(0.9, 0, 0, 35)
ABtn.Text = "Aura: OFF"
ABtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ABtn.TextColor3 = Color3.new(1, 1, 1)

-- Контент ESP
local EAll = Instance.new("TextButton", EspBox)
EAll.Size = UDim2.new(0.9, 0, 0, 35)
EAll.Text = "ESP All: OFF"
EAll.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EAll.TextColor3 = Color3.new(1, 1, 1)

local List = Instance.new("ScrollingFrame", EspBox)
List.Size = UDim2.new(0.9, 0, 0, 120)
List.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
List.CanvasSize = UDim2.new(0, 0, 5, 0)
Instance.new("UIListLayout", List)

-- Логика Pistol
local function fire(h, r)
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
    if tool and tool:FindFirstChild("RemoteEvent") then tool.RemoteEvent:FireServer(h, 100, {9.17, r.CFrame}) end
end

KBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #Target.Text) == Target.Text:lower() and p.Character then
            fire(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

local Aura = false
ABtn.MouseButton1Click:Connect(function()
    Aura = not Aura
    ABtn.Text = Aura and "Aura: ON" or "Aura: OFF"
    ABtn.BackgroundColor3 = Aura and Color3.fromRGB(130, 0, 255) or Color3.fromRGB(60, 60, 60)
end)

RunService.Heartbeat:Connect(function()
    if Aura then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("Humanoid")
                if h and h.Health > 0 then fire(h, p.Character.HumanoidRootPart) end
            end
        end
    end
end)

local EspOn = false
EAll.MouseButton1Click:Connect(function()
    EspOn = not EspOn
    EAll.Text = EspOn and "ESP: ON" or "ESP: OFF"
    EAll.BackgroundColor3 = EspOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
end)

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hi = p.Character:FindFirstChild("Highlight")
            if EspOn or (Target.Text ~= "" and p.Name:lower():sub(1, #Target.Text) == Target.Text:lower()) then
                if not hi then hi = Instance.new("Highlight", p.Character) end
                hi.FillColor = p.TeamColor.Color
            elseif hi then hi:Destroy() end
        end
    end
end)

local function refresh()
    for _, c in pairs(List:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", List)
            b.Size = UDim2.new(1, 0, 0, 20)
            b.Text = p.Name
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.MouseButton1Click:Connect(function() Target.Text = p.Name end)
        end
    end
end
spawn(function() while wait(5) do refresh() end end)
refresh()
