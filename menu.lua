local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("KillerEsp_V3") then CoreGui.KillerEsp_V3:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KillerEsp_V3"

-- Переменные состояния
local AuraEnabled = false
local AuraConnection = nil
local EspEnabled = false

-- Функция создания секций
local function CreateSection(name, pos)
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 220, 0, 35)
    Main.Position = pos
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = name
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleBtn = Instance.new("TextButton", Main)
    ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -35, 0, 2)
    ToggleBtn.Text = "<"
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", ToggleBtn)

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, 0, 0, 330)
    Content.Position = UDim2.new(0, 0, 1, 5)
    Content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Content.Visible = false
    Instance.new("UICorner", Content)
    
    local List = Instance.new("UIListLayout", Content)
    List.Padding = UDim.new(0, 5)
    List.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Instance.new("UIPadding", Content).PaddingTop = UDim.new(0, 10)

    ToggleBtn.MouseButton1Click:Connect(function()
        Content.Visible = not Content.Visible
        ToggleBtn.Text = Content.Visible and "v" or "<"
    end)

    return Content, Main
end

-- Создаем GUI
local KillContent, KillMain = CreateSection("Kill Gui", UDim2.new(0.5, -230, 0.2, 0))
local EspContent, EspMain = CreateSection("Esp Gui", UDim2.new(0.5, 10, 0.2, 0))

-- Общие функции
local function getTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
end

local function fireRemote(targetHum, targetRoot)
    local tool = getTool()
    if tool and tool:FindFirstChild("RemoteEvent") then
        tool.RemoteEvent:FireServer(targetHum, 100, {9.17, targetRoot.CFrame})
    end
end

-- Внутренние элементы для Kill
local TargetKill = Instance.new("TextBox", KillContent)
TargetKill.Size = UDim2.new(0.9, 0, 0, 30)
TargetKill.PlaceholderText = "Username..."
TargetKill.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TargetKill.TextColor3 = Color3.new(1, 1, 1)

local KillBtn = Instance.new("TextButton", KillContent)
KillBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillBtn.TextColor3 = Color3.new(1, 1, 1)

local AuraBtn = Instance.new("TextButton", KillContent)
AuraBtn.Size = UDim2.new(0.9, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)

-- Внутренние элементы для ESP
local TargetEsp = Instance.new("TextBox", EspContent)
TargetEsp.Size = UDim2.new(0.9, 0, 0, 30)
TargetEsp.PlaceholderText = "Username..."
TargetEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TargetEsp.TextColor3 = Color3.new(1, 1, 1)

local EspAllBtn = Instance.new("TextButton", EspContent)
EspAllBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspAllBtn.Text = "ESP All: OFF"
EspAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspAllBtn.TextColor3 = Color3.new(1, 1, 1)

-- Скролл списки (дублируются в обе секции для удобства)
local function CreateScroll(parent, inputField)
    local Scroll = Instance.new("ScrollingFrame", parent)
    Scroll.Size = UDim2.new(0.9, 0, 0, 120)
    Scroll.BackgroundTransparency = 1
    Scroll.CanvasSize = UDim2.new(0, 0, 4, 0)
    local L = Instance.new("UIListLayout", Scroll)
    
    local function refresh()
        for _, c in pairs(Scroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local b = Instance.new("TextButton", Scroll)
                b.Size = UDim2.new(1, 0, 0, 20)
                b.Text = p.Name
                b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                b.TextColor3 = Color3.new(0.8, 0.8, 0.8)
                b.MouseButton1Click:Connect(function() 
                    TargetKill.Text = p.Name 
                    TargetEsp.Text = p.Name
                end)
            end
        end
    end
    RunService.Stepped:Connect(function() if parent.Visible then L.Parent.Visible = true end end) -- Костыль для обновления
    spawn(function() while wait(5) do refresh() end end)
    refresh()
end

CreateScroll(KillContent, TargetKill)
CreateScroll(EspContent, TargetEsp)

-- Логика ESP
local function ApplyEsp(player)
    if player == LocalPlayer then return end
    if player.Character and not player.Character:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        -- Проверка команды (Team Color)
        highlight.FillColor = player.TeamColor.Color
        highlight.OutlineColor = Color3.new(1,1,1)
    end
end

local function RemoveEsp(player)
    if player.Character and player.Character:FindFirstChild("Highlight") then
        player.Character.Highlight:Destroy()
    end
end

-- Обработка кнопок
KillBtn.MouseButton1Click:Connect(function()
    local t = TargetKill.Text:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #t) == t and p.Character then
            fireRemote(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

AuraBtn.MouseButton1Click:Connect(function()
    AuraEnabled = not AuraEnabled
    AuraBtn.Text = AuraEnabled and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = AuraEnabled and Color3.fromRGB(100, 0, 200) or Color3.fromRGB(60, 60, 60)
    if AuraEnabled then
        AuraConnection = RunService.Heartbeat:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    fireRemote(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
                end
            end
        end)
    elseif AuraConnection then
        AuraConnection:Disconnect()
    end
end)

EspAllBtn.MouseButton1Click:Connect(function()
    EspEnabled = not EspEnabled
    EspAllBtn.Text = EspEnabled and "ESP All: ON" or "ESP All: OFF"
    EspAllBtn.BackgroundColor3 = EspEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
end)

-- Цикл ESP
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if EspEnabled or (TargetEsp.Text ~= "" and p.Name:lower():sub(1, #TargetEsp.Text) == TargetEsp.Text:lower()) then
            ApplyEsp(p)
        else
            RemoveEsp(p)
        end
    end
end)

print("V3 Loaded: Killer + Team-Color ESP")
