-- Trench War Script | Рабочая версия
-- Убрано получение оружия

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Удаляем старую копию, если есть
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("TrenchWarMenu") then
    PlayerGui.TrenchWarMenu:Destroy()
end

-- Создаём ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrenchWarMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Главное окно (фон)
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 280, 0, 400)
Main.Position = UDim2.new(0.5, -140, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

-- Заголовок "main"
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, -70, 0, 30)
Title.Position = UDim2.new(0, 8, 0, 5)
Title.Text = "main"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка сворачивания (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Main
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18

-- Кнопка закрытия (×)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Main
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -28, 0, 5)
CloseBtn.Text = "x"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18

-- Контейнер для контента
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1, -10, 1, -40)
Content.Position = UDim2.new(0, 5, 0, 38)
Content.BackgroundTransparency = 1
Content.Visible = true

-- Панель с контентом
local DisplayPanel = Instance.new("Frame")
DisplayPanel.Parent = Content
DisplayPanel.Size = UDim2.new(1, 0, 1, 0)
DisplayPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DisplayPanel.BorderSizePixel = 0

-- Лист для расположения элементов
local ContentList = Instance.new("UIListLayout")
ContentList.Parent = DisplayPanel
ContentList.Padding = UDim.new(0, 6)
ContentList.SortOrder = Enum.SortOrder.LayoutOrder

-- Отступы
local Padding = Instance.new("UIPadding")
Padding.Parent = DisplayPanel
Padding.PaddingTop = UDim.new(0, 8)
Padding.PaddingLeft = UDim.new(0, 8)
Padding.PaddingRight = UDim.new(0, 8)

-- ==================== ПОЛЕ ВВОДА ====================
local InputLabel = Instance.new("TextLabel")
InputLabel.Parent = DisplayPanel
InputLabel.Size = UDim2.new(1, 0, 0, 20)
InputLabel.BackgroundTransparency = 1
InputLabel.Text = "Name:"
InputLabel.TextColor3 = Color3.new(1, 1, 1)
InputLabel.Font = Enum.Font.GothamBold
InputLabel.TextSize = 14
InputLabel.TextXAlignment = Enum.TextXAlignment.Left

local TargetInput = Instance.new("TextBox")
TargetInput.Parent = DisplayPanel
TargetInput.Size = UDim2.new(1, 0, 0, 26)
TargetInput.PlaceholderText = "Enter name..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 14

-- ==================== КНОПКА KILL ====================
local KillBtn = Instance.new("TextButton")
KillBtn.Parent = DisplayPanel
KillBtn.Size = UDim2.new(1, 0, 0, 30)
KillBtn.Text = "KILL"
KillBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.GothamBold
KillBtn.TextSize = 16

-- ==================== СПИСОК ИГРОКОВ ====================
local PlayerListLabel = Instance.new("TextLabel")
PlayerListLabel.Parent = DisplayPanel
PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
PlayerListLabel.BackgroundTransparency = 1
PlayerListLabel.Text = "Enemies:"
PlayerListLabel.TextColor3 = Color3.new(1, 0.3, 0.3)
PlayerListLabel.Font = Enum.Font.GothamBold
PlayerListLabel.TextSize = 14
PlayerListLabel.TextXAlignment = Enum.TextXAlignment.Left

local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Parent = DisplayPanel
PlayerListFrame.Size = UDim2.new(1, 0, 0, 120)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 3

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = PlayerListFrame
ListLayout.Padding = UDim.new(0, 2)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ==================== КНОПКА KILL ALL ====================
local KillAllBtn = Instance.new("TextButton")
KillAllBtn.Parent = DisplayPanel
KillAllBtn.Size = UDim2.new(1, 0, 0, 30)
KillAllBtn.Text = "KILL ALL"
KillAllBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
KillAllBtn.TextColor3 = Color3.new(1, 1, 1)
KillAllBtn.Font = Enum.Font.GothamBold
KillAllBtn.TextSize = 16

-- ==================== КНОПКА AURA ====================
local AuraBtn = Instance.new("TextButton")
AuraBtn.Parent = DisplayPanel
AuraBtn.Size = UDim2.new(1, 0, 0, 30)
AuraBtn.Text = "AURA: OFF"
AuraBtn.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
AuraBtn.TextColor3 = Color3.new(1, 1, 1)
AuraBtn.Font = Enum.Font.GothamBold
AuraBtn.TextSize = 16

-- ==================== ЛОГИКА РАБОТЫ ====================

-- Получение команды игрока
local function getPlayerTeam(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return nil end
    
    local team = leaderstats:FindFirstChild("Team")
    if team then return team.Value end
    
    team = leaderstats:FindFirstChild("Faction")
    if team then return team.Value end
    
    team = leaderstats:FindFirstChild("Axis")
    if team then
        if team.Value == 1 then return "Axis" else return "Allies" end
    end
    
    team = leaderstats:FindFirstChild("Allies")
    if team then
        if team.Value == 1 then return "Allies" else return "Axis" end
    end
    
    return nil
end

-- Получение команды локального игрока
local function getMyTeam()
    return getPlayerTeam(LocalPlayer)
end

-- Проверка, враг ли игрок
local function isEnemy(player)
    if player == LocalPlayer then return false end
    
    local myTeam = getMyTeam()
    local theirTeam = getPlayerTeam(player)
    
    if not myTeam then return true end
    if not theirTeam then return false end
    
    return myTeam ~= theirTeam
end

-- Получение инструмента
local function getTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Pistol")
end

-- Отправка удалённого события для убийства
local function fireRemote(targetHum, targetRoot)
    local tool = getTool()
    if tool and tool:FindFirstChild("RemoteEvent") then
        tool.RemoteEvent:FireServer(targetHum, 100, {9.17, targetRoot.CFrame})
    end
end

-- Убить по имени
local function executeKill(targetName)
    if targetName == "" then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isEnemy(p) and string.lower(p.Name):sub(1, #targetName) == string.lower(targetName) and p.Character then
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
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local enemyCount = 0
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isEnemy(p) then
            enemyCount = enemyCount + 1
            local pBtn = Instance.new("TextButton")
            pBtn.Parent = PlayerListFrame
            pBtn.Size = UDim2.new(1, -5, 0, 22)
            pBtn.Text = p.Name
            pBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            pBtn.TextColor3 = Color3.new(1, 0.5, 0.5)
            pBtn.BorderSizePixel = 0
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 13
            pBtn.MouseButton1Click:Connect(function()
                TargetInput.Text = p.Name
            end)
        end
    end
    
    PlayerListLabel.Text = "Enemies (" .. enemyCount .. "):"
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, math.max(enemyCount * 24, 10), 0)
end

-- Обновляем список
updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Кнопка KILL
KillBtn.MouseButton1Click:Connect(function()
    executeKill(TargetInput.Text)
end)

-- Enter в поле ввода
TargetInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and TargetInput.Text ~= "" then
        executeKill(TargetInput.Text)
    end
end)

-- KILL ALL
KillAllBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isEnemy(p) and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                fireRemote(hum, root)
            end
        end
    end
end)

-- AURA
local AuraEnabled = false
local AuraConnection = nil

AuraBtn.MouseButton1Click:Connect(function()
    AuraEnabled = not AuraEnabled
    AuraBtn.Text = AuraEnabled and "AURA: ON" or "AURA: OFF"
    AuraBtn.BackgroundColor3 = AuraEnabled and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(75, 0, 130)
    
    if AuraEnabled then
        AuraConnection = RunService.Heartbeat:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and isEnemy(p) and p.Character then
                    local hum = p.Character:FindFirstChild("Humanoid")
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 then
                        fireRemote(hum, root)
                    end
                end
            end
        end)
    else
        if AuraConnection then
            AuraConnection:Disconnect()
            AuraConnection = nil
        end
    end
end)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Content.Visible = not isMinimized
    Main.Size = isMinimized and UDim2.new(0, 280, 0, 40) or UDim2.new(0, 280, 0, 400)
    MinBtn.Text = isMinimized and "+" or "-"
end)

-- Закрытие
CloseBtn.MouseButton1Click:Connect(function()
    if AuraConnection then AuraConnection:Disconnect() end
    ScreenGui:Destroy()
end)

print("Trench War Script loaded. GUI in PlayerGui")
