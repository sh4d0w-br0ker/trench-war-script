local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Удаление старой копии
if CoreGui:FindFirstChild("Unified_Menu_V3") then CoreGui.Unified_Menu_V3:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Unified_Menu_V3"

-- Переменные
local AuraEnabled = false
local AuraConnection = nil
local EspEnabled = false

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 400)
MainFrame.Position = UDim2.new(0.5, -110, 0.2, 0)
MainFrame.BackgroundTransparency = 1 -- Прозрачный фон, так как блоки будут внутри
MainFrame.Active = true
MainFrame.Draggable = true

local MainList = Instance.new("UIListLayout", MainFrame)
MainList.Padding = UDim.new(0, 5)
MainList.SortOrder = Enum.SortOrder.LayoutOrder

-- Функция создания раскрывающихся секций
local function CreateSection(name, order)
    local SectionFrame = Instance.new("Frame", MainFrame)
    SectionFrame.Size = UDim2.new(1, 0, 0, 35)
    SectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SectionFrame.BorderSizePixel = 0
    SectionFrame.LayoutOrder = order
    SectionFrame.ClipsDescendants = true
    
    local Corner = Instance.new("UICorner", SectionFrame)
    
    local Title = Instance.new("TextLabel", SectionFrame)
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = name
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleBtn = Instance.new("TextButton", SectionFrame)
    ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -35, 0, 2)
    ToggleBtn.Text = "<"
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", ToggleBtn)

    local Content = Instance.new("Frame", SectionFrame)
    Content.Size = UDim2.new(1, 0, 0, 300)
    Content.Position = UDim2.new(0, 0, 0, 35)
    Content.BackgroundTransparency = 1
    
    local ContentList = Instance.new("UIListLayout", Content)
    ContentList.Padding = UDim.new(0, 5)
    ContentList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Instance.new("UIPadding", Content).PaddingTop = UDim.new(0, 5)

    local isOpen = false
    ToggleBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        ToggleBtn.Text = isOpen and "v" or "<"
        SectionFrame.Size = isOpen and UDim2.new(1, 0, 0, 335) or UDim2.new(1, 0, 0, 35)
    end)

    return Content
end

-- Создаем секции
local KillContent = CreateSection("Kill Gui", 1)
local EspContent = CreateSection("Esp Gui", 2)

--- [ ЛОГИКА KILL ] ---
local TargetInput = Instance.new("TextBox", KillContent)
TargetInput.Size = UDim2.new(0.9, 0, 0, 30)
TargetInput.PlaceholderText = "Target Name..."
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetInput)

local KillBtn = Instance.new("TextButton", KillContent)
KillBtn.Size = UDim2.new(0.9, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KillBtn)

local AuraBtn = Instance.new("TextButton", KillContent)
AuraBtn.Size = UDim2.new(0.9, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AuraBtn)

--- [ ЛОГИКА ESP ] ---
local EspAllBtn = Instance.new("TextButton", EspContent)
EspAllBtn.Size = UDim2.new(0.9, 0, 0, 35)
EspAllBtn.Text = "ESP All: OFF"
EspAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EspAllBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", EspAllBtn)

-- Список игроков (общий для обеих вкладок)
local PlayerList = Instance.new("ScrollingFrame", EspContent)
PlayerList.Size = UDim2.new(0.9, 0, 0, 150)
PlayerList.BackgroundTransparency = 0.9
PlayerList.CanvasSize = UDim2.new(0, 0, 5, 0)
local ListLayout = Instance.new("UIListLayout", PlayerList)

local function updatePlayers()
    for _, child in pairs(PlayerList:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", PlayerList)
            btn.Size = UDim2.new(1, 0, 0, 20)
            btn.Text = p.Name
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
            btn.MouseButton1Click:Connect(function() TargetInput.Text = p.Name end)
        end
    end
end
spawn(function() while wait(5) do updatePlayers() end end)
updatePlayers()

-- ФУНКЦИИ ОРУЖИЯ
local function getTool() return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol") end
local function fireRemote(tHum, tRoot)
    local tool = getTool()
    if tool and tool:FindFirstChild("RemoteEvent") then
        tool.RemoteEvent:FireServer(tHum, 100, {9.17, tRoot.CFrame})
    end
end

-- КНОПКИ ДЕЙСТВИЯ
KillBtn.MouseButton1Click:Connect(function()
    local name = TargetInput.Text:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name and p.Character then
            fireRemote(p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("HumanoidRootPart"))
        end
    end
end)

AuraBtn.MouseButton1Click:Connect(function()
    AuraEnabled = not AuraEnabled
    AuraBtn.Text = AuraEnabled and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = AuraEnabled and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(60, 60, 60)
    if AuraEnabled then
        AuraConnection = RunService.Heartbeat:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local h = p.Character:FindFirstChild("Humanoid")
                    local r = p.Character:FindFirstChild("HumanoidRootPart")
                    if h and r and h.Health > 0 then fireRemote(h, r) end
                end
            end
        end)
    else
        if AuraConnection then AuraConnection:Disconnect() end
    end
end)

EspAllBtn.MouseButton1Click:Connect(function()
    EspEnabled = not EspEnabled
    EspAllBtn.Text = EspEnabled and "ESP All: ON" or "ESP All: OFF"
    EspAllBtn.BackgroundColor3 = EspEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
end)

-- РЕНДЕР ESP (Командные цвета)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local highlight = p.Character:FindFirstChild("Highlight")
            
            -- Если ESP включен ИЛИ ник совпадает с полем ввода
            if EspEnabled or (TargetInput.Text ~= "" and p.Name:lower():sub(1, #TargetInput.Text) == TargetInput.Text:lower()) then
                if not highlight then
                    highlight = Instance.new("Highlight", p.Character)
                    highlight.OutlineTransparency = 0
                    highlight.FillTransparency = 0.5
                end
                -- Определяем цвет по команде из Leaderboard
                highlight.FillColor = p.TeamColor.Color
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

print("Unified Killer/ESP Menu Loaded.")
