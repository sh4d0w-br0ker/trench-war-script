local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Удаление старой копии, если есть
if CoreGui:FindFirstChild("PistolKiller_V2") then CoreGui.PistolKiller_V2:Destroy() end

local Enabled = false
local Connection = nil

-- Основной интерфейс
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "PistolKiller_V2"

-- Главная плашка (Main)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 200, 0, 35)
Main.Position = UDim2.new(0.5, -100, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 6)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "main"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSans
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Position = UDim2.new(1, -35, 0, 2)
ToggleBtn.Text = "<"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleBtn.Font = Enum.Font.SourceSansBold
local BtnCorner = Instance.new("UICorner", ToggleBtn)

-- Контент-панель (скрытая часть)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 0, 320)
Content.Position = UDim2.new(0, 0, 1, 5)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Content.Visible = false
Instance.new("UICorner", Content)

local Padding = Instance.new("UIPadding", Content)
Padding.PaddingTop = UDim.new(0, 10)
Padding.PaddingLeft = UDim.new(0, 10)
Padding.PaddingRight = UDim.new(0, 10)

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 8)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Поле ввода ника
local TargetInput = Instance.new("TextBox", Content)
TargetInput.Size = UDim2.new(1, 0, 0, 30)
TargetInput.PlaceholderText = "Target Username..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetInput)

-- Кнопка KILL PLAYER
local KillBtn = Instance.new("TextButton", Content)
KillBtn.Size = UDim2.new(1, 0, 0, 35)
KillBtn.Text = "Kill Player"
KillBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KillBtn)

-- Список игроков (скролл)
local PlayerListFrame = Instance.new("ScrollingFrame", Content)
PlayerListFrame.Size = UDim2.new(1, 0, 0, 100)
PlayerListFrame.BackgroundTransparency = 1
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
PlayerListFrame.ScrollBarThickness = 2
local ListLayout = Instance.new("UIListLayout", PlayerListFrame)

-- Кнопка KILL ALL (Разово)
local KillAllBtn = Instance.new("TextButton", Content)
KillAllBtn.Size = UDim2.new(1, 0, 0, 35)
KillAllBtn.Text = "Kill All"
KillAllBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
KillAllBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KillAllBtn)

-- Кнопка AURA (Всегда)
local AuraBtn = Instance.new("TextButton", Content)
AuraBtn.Size = UDim2.new(1, 0, 0, 35)
AuraBtn.Text = "Aura: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AuraBtn)

-- ЛОГИКА
local function getTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
end

local function fireRemote(targetHum, targetRoot)
    local tool = getTool()
    if tool and tool:FindFirstChild("RemoteEvent") then
        tool.RemoteEvent:FireServer(targetHum, 100, {9.17, targetRoot.CFrame})
    end
end

-- Функция убийства
local function executeKill(targetName)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #targetName) == targetName:lower() and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                fireRemote(hum, root)
            end
        end
    end
end

-- Обновление списка игроков
local function updatePlayerList()
    for _, child in pairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerListFrame)
            pBtn.Size = UDim2.new(1, -5, 0, 20)
            pBtn.Text = p.Name
            pBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            pBtn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            pBtn.BorderSizePixel = 0
            pBtn.MouseButton1Click:Connect(function()
                TargetInput.Text = p.Name
            end)
        end
    end
end

-- Кнопки действий
ToggleBtn.MouseButton1Click:Connect(function()
    Content.Visible = not Content.Visible
    ToggleBtn.Text = Content.Visible and "v" or "<"
    if Content.Visible then updatePlayerList() end
end)

KillBtn.MouseButton1Click:Connect(function()
    executeKill(TargetInput.Text)
end)

KillAllBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and root then fireRemote(hum, root) end
        end
    end
end)

AuraBtn.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    AuraBtn.Text = Enabled and "Aura: ON" or "Aura: OFF"
    AuraBtn.BackgroundColor3 = Enabled and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(75, 0, 130)
    
    if Enabled then
        Connection = RunService.Heartbeat:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hum = p.Character:FindFirstChild("Humanoid")
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 then fireRemote(hum, root) end
                end
            end
        end)
    else
        if Connection then Connection:Disconnect() end
    end
end)

print("Minimalist Killer Loaded.")
